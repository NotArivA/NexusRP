local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config

local function EnsureLicenses(metadata)
    metadata = metadata or {}
    metadata.driver = metadata.driver or false
    metadata.driver_car = metadata.driver_car or false
    metadata.driver_truck = metadata.driver_truck or false
    metadata.driver_motorcycle = metadata.driver_motorcycle or false
    metadata.driver_theory = metadata.driver_theory or false
    metadata.weapon = metadata.weapon or false
    metadata.weapon_theory = metadata.weapon_theory or false
    return metadata
end

local function SaveLicenses(player, licences)
    player.Functions.SetMetaData('licences', licences)
end

QBCore.Functions.CreateCallback('qb-nexusrp:server:payExam', function(source, cb, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        cb(false)
        return
    end

    local account = 'bank'
    local paid = false

    if Player.PlayerData.money[account] and Player.PlayerData.money[account] >= amount then
        Player.Functions.RemoveMoney(account, amount, 'licence-exam')
        paid = true
    else
        if Player.PlayerData.money['cash'] and Player.PlayerData.money['cash'] >= amount then
            Player.Functions.RemoveMoney('cash', amount, 'licence-exam')
            paid = true
        end
    end

    if paid then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-nexusrp:server:canStartPractical', function(source, cb, examType)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        cb(false, 'Aucun joueur détecté.')
        return
    end

    local licences = EnsureLicenses(Player.PlayerData.metadata['licences'])

    if not licences.driver or not licences.driver_theory then
        cb(false, 'Vous devez réussir l\'examen théorique avant de continuer.')
        return
    end

    if licences['driver_' .. examType] then
        cb(false, 'Vous possédez déjà ce permis spécifique.')
        return
    end

    cb(true)
end)

RegisterNetEvent('qb-nexusrp:server:theoryResult', function(score, passed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local licences = EnsureLicenses(Player.PlayerData.metadata['licences'])
    local update = false

    if passed then
        if not licences.driver_theory then
            licences.driver_theory = true
            update = true
        end
        if not licences.driver then
            licences.driver = true
            update = true
        end
    end

    if update then
        SaveLicenses(Player, licences)
    end

    TriggerClientEvent('QBCore:Notify', src, ('Score %.0f%%'):format((score or 0) * 100), passed and 'success' or 'error', 7500)
end)

RegisterNetEvent('qb-nexusrp:server:practicalResult', function(examType, passed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local licences = EnsureLicenses(Player.PlayerData.metadata['licences'])
    local key = 'driver_' .. examType

    if passed then
        if licences[key] then
            TriggerClientEvent('QBCore:Notify', src, 'Licence déjà acquise.', 'primary')
            return
        end

        licences[key] = true
        SaveLicenses(Player, licences)
        TriggerClientEvent('QBCore:Notify', src, 'Licence mise à jour sur votre pièce d\'identité.', 'success', 10000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Vous devrez repasser l\'examen pour obtenir la licence.', 'error', 8000)
    end
end)

RegisterNetEvent('qb-nexusrp:server:weaponResult', function(score, passed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local licences = EnsureLicenses(Player.PlayerData.metadata['licences'])

    if passed then
        if not licences.weapon_theory then
            licences.weapon_theory = true
        end
        licences.weapon = true
        SaveLicenses(Player, licences)
        TriggerClientEvent('QBCore:Notify', src, 'Permis de port d\'arme accordé. Mention ajoutée sur votre ID.', 'success', 10000)
    else
        TriggerClientEvent('QBCore:Notify', src, ('Score %.0f%% insuffisant, repassez l\'examen.'):format((score or 0) * 100), 'error', 10000)
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    TriggerClientEvent('qb-nexusrp:client:forceCleanup', src)
end)

QBCore.Functions.CreateCallback('qb-nexusrp:server:getLicenses', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        cb(EnsureLicenses(nil))
        return
    end

    cb(EnsureLicenses(Player.PlayerData.metadata['licences']))
end)
