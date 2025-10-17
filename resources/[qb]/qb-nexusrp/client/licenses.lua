local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config

local activeTheory = false
local activePractical = false
local practicalData = nil
local pendingQuestion = nil
local pendingPromise = nil
local pendingWeaponPromise = nil

local function CloseMenu()
    if exports['qb-menu'] then
        exports['qb-menu']:closeMenu()
    end
end

local function OpenQuestionMenu(question, cb)
    local menu = {
        {
            header = question.title,
            isMenuHeader = true
        }
    }

    for index, option in ipairs(question.answers) do
        menu[#menu + 1] = {
            header = option.label,
            params = {
                event = 'qb-nexusrp:client:selectAnswer',
                args = {
                    choice = index
                }
            }
        }
    end

    pendingQuestion = {
        callback = cb,
        answers = question.answers
    }

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('qb-nexusrp:client:selectAnswer', function(data)
    if not pendingQuestion then return end
    local cb = pendingQuestion.callback
    pendingQuestion = nil
    CloseMenu()
    if cb then
        cb(data.choice)
    end
end)

local function RunExam(questions)
    local correct = 0

    for _, question in ipairs(questions) do
        local p = promise.new()
        OpenQuestionMenu(question, function(choice)
            p:resolve(choice)
        end)

        local choice = Citizen.Await(p)
        if choice then
            local option = question.answers[choice]
            if option and option.correct then
                correct = correct + 1
            end
        end
        Wait(200)
    end

    return correct
end

local function CheckPayment(amount, cb)
    if amount <= 0 then
        cb(true)
        return
    end

    QBCore.Functions.TriggerCallback('qb-nexusrp:server:payExam', function(success)
        cb(success)
    end, amount)
end

local function StartDrivingTheory()
    if activeTheory then
        QBCore.Functions.Notify('Vous passez déjà un examen.', 'error')
        return
    end

    CheckPayment(Config.TheoryExam.price, function(success)
        if not success then
            QBCore.Functions.Notify('Paiement refusé, fonds insuffisants.', 'error')
            return
        end

        activeTheory = true
        QBCore.Functions.Notify('Examen théorique démarré. Répondez attentivement aux questions.', 'primary')

        CreateThread(function()
            local correct = RunExam(Config.TheoryExam.questions)
            local score = correct / #Config.TheoryExam.questions
            local passed = score >= Config.TheoryExam.passRate
            activeTheory = false

            TriggerServerEvent('qb-nexusrp:server:theoryResult', score, passed)

            if passed then
                QBCore.Functions.Notify(('Réussi ! Score %.0f%%.'):format(score * 100), 'success', 10000)
            else
                QBCore.Functions.Notify(('Échec. Score %.0f%%, il faut %.0f%%.'):format(score * 100, Config.TheoryExam.passRate * 100), 'error', 10000)
            end
        end)
    end)
end

local function SpawnPracticalVehicle(route)
    local model = joaat(route.vehicle)
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) do
        Wait(10)
        timeout = timeout + 1
        if timeout > 500 then
            return nil
        end
    end

    local veh = CreateVehicle(model, route.start.x, route.start.y, route.start.z, route.start.w, true, false)
    if not DoesEntityExist(veh) then
        return nil
    end

    SetVehicleOnGroundProperly(veh)
    SetVehicleNumberPlateText(veh, 'EXAM' .. math.random(100, 999))
    SetVehicleDoorsLocked(veh, 1)
    SetVehicleEngineOn(veh, true, true, false)
    SetVehicleFuelLevel(veh, 100.0)
    SetEntityAsMissionEntity(veh, true, true)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, veh, -1)

    return veh
end

local function CleanupPractical()
    if practicalData then
        if DoesEntityExist(practicalData.vehicle) then
            SetEntityAsMissionEntity(practicalData.vehicle, true, true)
            DeleteVehicle(practicalData.vehicle)
        end
        if practicalData.blip and DoesBlipExist(practicalData.blip) then
            RemoveBlip(practicalData.blip)
        end
    end
    practicalData = nil
    activePractical = false
end

local function SetCheckpointBlip(coords, index, total)
    if practicalData and practicalData.blip and DoesBlipExist(practicalData.blip) then
        RemoveBlip(practicalData.blip)
    end

    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 0.75)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(('Point %s/%s'):format(index, total))
    EndTextCommandSetBlipName(blip)

    practicalData.blip = blip
end

local function FailPractical(reason)
    QBCore.Functions.Notify(reason or 'Examen échoué.', 'error', 10000)
    TriggerServerEvent('qb-nexusrp:server:practicalResult', practicalData.type, false)
    CleanupPractical()
end

local function StartPractical(routeKey)
    if activePractical or activeTheory then
        QBCore.Functions.Notify('Un examen est déjà en cours.', 'error')
        return
    end

    local route = Config.PracticalRoutes[routeKey]
    if not route then return end

    QBCore.Functions.TriggerCallback('qb-nexusrp:server:canStartPractical', function(allowed, reason)
        if not allowed then
            QBCore.Functions.Notify(reason or 'Conditions non remplies.', 'error')
            return
        end

        CheckPayment(route.price or 350, function(success)
            if not success then
                QBCore.Functions.Notify('Paiement refusé, fonds insuffisants.', 'error')
                return
            end

            local veh = SpawnPracticalVehicle(route)
            if not veh then
                QBCore.Functions.Notify('Impossible de récupérer le véhicule d\'examen.', 'error')
                return
            end

            activePractical = true
            practicalData = {
                type = routeKey,
                route = route,
                vehicle = veh,
                checkpoint = 1,
                faults = 0
            }

            QBCore.Functions.Notify('Suivez le parcours indiqué et respectez les limitations.', 'primary', 10000)
            SetCheckpointBlip(route.checkpoints[1].coords, 1, #route.checkpoints)

            CreateThread(function()
                while activePractical do
                    Wait(0)

                    if not practicalData or not DoesEntityExist(practicalData.vehicle) then
                        FailPractical('Véhicule perdu, examen annulé.')
                        break
                    end

                    local ped = PlayerPedId()
                    if not IsPedInVehicle(ped, practicalData.vehicle, false) then
                        FailPractical('Vous devez rester dans le véhicule d\'examen.')
                        break
                    end

                    local coords = GetEntityCoords(practicalData.vehicle)
                    local checkpoint = route.checkpoints[practicalData.checkpoint]
                    if not checkpoint then
                        break
                    end

                    local distance = #(coords - checkpoint.coords)
                    local speed = GetEntitySpeed(practicalData.vehicle) * 3.6

                    if speed > checkpoint.maxSpeed + 10.0 then
                        practicalData.faults = practicalData.faults + 1
                        QBCore.Functions.Notify('Excès de vitesse ! Restez en dessous de la limite.', 'error')
                        Wait(2000)
                    end

                    if distance <= checkpoint.radius then
                        practicalData.checkpoint = practicalData.checkpoint + 1
                        if practicalData.checkpoint > #route.checkpoints then
                            TriggerServerEvent('qb-nexusrp:server:practicalResult', routeKey, true)
                            QBCore.Functions.Notify('Examen réussi ! Rendez le véhicule.', 'success', 10000)
                            CleanupPractical()
                            break
                        else
                            local nextPoint = route.checkpoints[practicalData.checkpoint]
                            SetCheckpointBlip(nextPoint.coords, practicalData.checkpoint, #route.checkpoints)
                            QBCore.Functions.Notify(('Point %d atteint, continuez.'):format(practicalData.checkpoint - 1), 'primary')
                            Wait(500)
                        end
                    end

                    if GetEntityHealth(practicalData.vehicle) < 850.0 then
                        FailPractical('Vous avez endommagé le véhicule d\'examen.')
                        break
                    end
                end
            end)
        end)
    end, routeKey)
end

local function StartWeaponTheory()
    if activeTheory or activePractical then
        QBCore.Functions.Notify('Vous ne pouvez pas passer deux examens en même temps.', 'error')
        return
    end

    CheckPayment(Config.WeaponExam.price, function(success)
        if not success then
            QBCore.Functions.Notify('Paiement refusé, fonds insuffisants.', 'error')
            return
        end

        activeTheory = true
        QBCore.Functions.Notify('Examen de port d\'arme démarré. Répondez avec précision.', 'primary')

        CreateThread(function()
            local correct = RunExam(Config.WeaponExam.questions)
            local score = correct / #Config.WeaponExam.questions
            local passed = score >= Config.WeaponExam.passRate
            activeTheory = false

            TriggerServerEvent('qb-nexusrp:server:weaponResult', score, passed)

            if passed then
                QBCore.Functions.Notify(('Réussi ! Score %.0f%%.'):format(score * 100), 'success', 10000)
            else
                QBCore.Functions.Notify(('Échec. Score %.0f%%, il faut %.0f%%.'):format(score * 100, Config.WeaponExam.passRate * 100), 'error', 10000)
            end
        end)
    end)
end

RegisterNetEvent('qb-nexusrp:client:startTheory', StartDrivingTheory)

RegisterNetEvent('qb-nexusrp:client:startPractical', function(routeKey)
    StartPractical(routeKey)
end)

RegisterNetEvent('qb-nexusrp:client:startWeaponTheory', StartWeaponTheory)

local function RegisterTargets()
    if not Config.Targets then return end

    for _, target in ipairs(Config.Targets) do
        exports['qb-target']:AddBoxZone('nexusrp-licence-' .. target.type, target.coords, 2.0, 2.0, {
            name = 'nexusrp-licence-' .. target.type,
            heading = 0,
            debugPoly = false,
            minZ = target.coords.z - 1.0,
            maxZ = target.coords.z + 1.5
        }, {
            options = {
                {
                    icon = target.icon or 'fas fa-id-card',
                    label = target.label or 'Intéragir',
                    event = target.event,
                    args = target.args
                }
            },
            distance = 2.0
        })
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    RegisterTargets()
end)

CreateThread(function()
    RegisterTargets()
end)

RegisterNetEvent('qb-nexusrp:client:forceCleanup', CleanupPractical)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    CleanupPractical()
end)
