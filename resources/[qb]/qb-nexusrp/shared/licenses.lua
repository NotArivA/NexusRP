Config = Config or {}

local vec3 = vec3 or vector3
local vec4 = vec4 or vector4

Config.TheoryExam = {
    start = vec3(-550.2, -192.45, 38.22),
    price = 250,
    passRate = 0.8,
    questions = {
        {
            title = 'Que devez-vous faire lorsque vous approchez d\'un passage piéton sans feux ?',
            answers = {
                { label = 'Ralentir et vous arrêter si des piétons s\'engagent.', correct = true },
                { label = 'Klaxonner pour avertir et continuer.', correct = false },
                { label = 'Accélérer pour franchir le passage rapidement.', correct = false }
            }
        },
        {
            title = 'Quelle est la priorité lorsque deux véhicules arrivent à un carrefour sans signalisation ?',
            answers = {
                { label = 'La priorité est donnée au véhicule venant de droite.', correct = true },
                { label = 'Le plus gros véhicule passe en premier.', correct = false },
                { label = 'Le véhicule le plus rapide passe en premier.', correct = false }
            }
        },
        {
            title = 'Comment réagissez-vous lorsqu\'un feu passe à l\'orange fixe ?',
            answers = {
                { label = 'Vous stoppez si les conditions de sécurité le permettent.', correct = true },
                { label = 'Vous accélérez pour franchir l\'intersection.', correct = false },
                { label = 'Vous klaxonnez et continuez.', correct = false }
            }
        },
        {
            title = 'En agglomération, quelle est la vitesse maximale autorisée sauf indication contraire ?',
            answers = {
                { label = '50 km/h.', correct = true },
                { label = '70 km/h.', correct = false },
                { label = '90 km/h.', correct = false }
            }
        },
        {
            title = 'Dans quelle situation devez-vous utiliser vos feux de détresse ?',
            answers = {
                { label = 'En cas d\'arrêt d\'urgence ou de situation dangereuse.', correct = true },
                { label = 'Pour remercier un autre conducteur.', correct = false },
                { label = 'Pour avertir d\'un dépassement.', correct = false }
            }
        },
        {
            title = 'Que signifie un marquage jaune continu au sol ?',
            answers = {
                { label = 'Interdiction de stationner.', correct = true },
                { label = 'Stationnement limité à 15 minutes.', correct = false },
                { label = 'Emplacement réservé aux taxis.', correct = false }
            }
        },
        {
            title = 'Quand est-il autorisé de franchir une ligne continue ?',
            answers = {
                { label = 'Jamais, sauf signalisation ponctuelle autorisée.', correct = true },
                { label = 'Pour dépasser un véhicule lent.', correct = false },
                { label = 'Pour tourner à gauche.', correct = false }
            }
        },
        {
            title = 'Quel est le bon comportement sur autoroute ?',
            answers = {
                { label = 'Rester sur la voie de droite sauf dépassement.', correct = true },
                { label = 'Rester toujours sur la voie du milieu.', correct = false },
                { label = 'Changer de voie régulièrement pour rester éveillé.', correct = false }
            }
        },
        {
            title = 'Comment devez-vous réagir sous forte pluie ?',
            answers = {
                { label = 'Réduire votre vitesse et augmenter les distances de sécurité.', correct = true },
                { label = 'Activer les feux de route.', correct = false },
                { label = 'Coller le véhicule devant pour profiter de ses essuie-glaces.', correct = false }
            }
        },
        {
            title = 'Que signifie un panneau triangulaire avec un point d\'exclamation ?',
            answers = {
                { label = 'Danger non précisé, soyez vigilant.', correct = true },
                { label = 'Parking obligatoire.', correct = false },
                { label = 'Fin de limitation de vitesse.', correct = false }
            }
        },
        {
            title = 'Que devez-vous faire si un bus scolaire s\'arrête avec ses feux clignotants ?',
            answers = {
                { label = 'Vous arrêtez et attendez que les feux cessent de clignoter.', correct = true },
                { label = 'Vous doublez rapidement par la gauche.', correct = false },
                { label = 'Vous passez en klaxonnant pour avertir.', correct = false }
            }
        },
        {
            title = 'Comment prévenir un risque de somnolence au volant ?',
            answers = {
                { label = 'S\'arrêter et se reposer dès les premiers signes de fatigue.', correct = true },
                { label = 'Boire du café et ouvrir les fenêtres.', correct = false },
                { label = 'Augmenter le volume de la radio.', correct = false }
            }
        }
    }
}

Config.PracticalRoutes = {
    car = {
        label = 'Examen pratique voiture',
        vehicle = 'blista',
        start = vec4(233.05, -1394.81, 30.55, 317.61),
        price = 500,
        checkpoints = {
            { coords = vec3(221.27, -1373.5, 30.59), radius = 6.0, maxSpeed = 55 },
            { coords = vec3(182.39, -1345.27, 29.65), radius = 5.0, maxSpeed = 55 },
            { coords = vec3(152.53, -1324.12, 29.2), radius = 5.0, maxSpeed = 55 },
            { coords = vec3(103.88, -1335.94, 28.79), radius = 6.0, maxSpeed = 55 },
            { coords = vec3(76.21, -1408.21, 29.37), radius = 6.5, maxSpeed = 55 },
            { coords = vec3(121.76, -1479.64, 29.36), radius = 6.0, maxSpeed = 65 },
            { coords = vec3(178.72, -1504.64, 29.14), radius = 6.0, maxSpeed = 65 },
            { coords = vec3(235.51, -1468.23, 29.4), radius = 6.0, maxSpeed = 50 },
            { coords = vec3(250.89, -1409.62, 29.3), radius = 6.0, maxSpeed = 50 },
            { coords = vec3(236.52, -1377.44, 30.51), radius = 5.0, maxSpeed = 45 }
        }
    },
    truck = {
        label = 'Examen pratique camion',
        vehicle = 'hauler',
        start = vec4(896.47, -2536.83, 28.3, 85.77),
        price = 750,
        checkpoints = {
            { coords = vec3(930.74, -2523.94, 27.95), radius = 7.5, maxSpeed = 45 },
            { coords = vec3(975.61, -2478.82, 28.45), radius = 7.5, maxSpeed = 55 },
            { coords = vec3(1026.52, -2453.14, 28.43), radius = 7.5, maxSpeed = 55 },
            { coords = vec3(1087.27, -2472.18, 28.46), radius = 7.5, maxSpeed = 50 },
            { coords = vec3(1152.86, -2492.53, 28.52), radius = 7.5, maxSpeed = 50 },
            { coords = vec3(1189.73, -2571.01, 37.5), radius = 9.0, maxSpeed = 45 },
            { coords = vec3(1117.21, -2654.23, 28.2), radius = 9.0, maxSpeed = 45 },
            { coords = vec3(1057.62, -2666.43, 28.06), radius = 8.0, maxSpeed = 45 },
            { coords = vec3(978.84, -2679.14, 28.26), radius = 8.0, maxSpeed = 45 },
            { coords = vec3(915.54, -2598.21, 28.45), radius = 7.5, maxSpeed = 40 }
        }
    },
    motorcycle = {
        label = 'Examen pratique moto',
        vehicle = 'bati',
        start = vec4(462.88, -1024.35, 28.13, 90.34),
        price = 400,
        checkpoints = {
            { coords = vec3(508.75, -1018.2, 28.3), radius = 5.0, maxSpeed = 45 },
            { coords = vec3(551.92, -1034.12, 28.65), radius = 5.0, maxSpeed = 45 },
            { coords = vec3(600.51, -1084.33, 28.71), radius = 5.0, maxSpeed = 55 },
            { coords = vec3(637.22, -1145.45, 28.73), radius = 5.0, maxSpeed = 55 },
            { coords = vec3(628.43, -1212.12, 28.7), radius = 5.0, maxSpeed = 55 },
            { coords = vec3(566.21, -1241.76, 28.13), radius = 5.0, maxSpeed = 50 },
            { coords = vec3(512.17, -1237.67, 28.34), radius = 5.0, maxSpeed = 45 },
            { coords = vec3(468.53, -1181.42, 28.17), radius = 5.0, maxSpeed = 45 },
            { coords = vec3(438.51, -1108.53, 28.19), radius = 5.0, maxSpeed = 45 },
            { coords = vec3(451.34, -1032.89, 28.2), radius = 5.0, maxSpeed = 40 }
        }
    }
}

Config.WeaponExam = {
    start = vec3(12.63, -1106.47, 29.8),
    price = 1250,
    passRate = 0.8,
    questions = {
        {
            title = 'Quelle est la première règle de sécurité avant de manipuler une arme à feu ?',
            answers = {
                { label = 'Considérer toute arme comme chargée.', correct = true },
                { label = 'Pointer le canon vers le sol.', correct = false },
                { label = 'Retirer le chargeur seulement.', correct = false }
            }
        },
        {
            title = 'Quelle est la distance minimale de sécurité pour un tir en stand intérieur ?',
            answers = {
                { label = 'La distance indiquée par l\'officier de tir.', correct = true },
                { label = 'Deux mètres.', correct = false },
                { label = 'Cinq mètres pour toutes les armes.', correct = false }
            }
        },
        {
            title = 'Quelle est la procédure en cas d\'incident de tir (weapon jam) ?',
            answers = {
                { label = 'Pointer l\'arme vers la cible, doigt hors de la détente, et prévenir le superviseur.', correct = true },
                { label = 'Regarder dans le canon pour vérifier.', correct = false },
                { label = 'Poser l\'arme sur la table et repartir.', correct = false }
            }
        },
        {
            title = 'Quand pouvez-vous utiliser une arme à feu en légitime défense ?',
            answers = {
                { label = 'Uniquement en cas de menace immédiate et proportionnée contre votre vie.', correct = true },
                { label = 'Pour protéger vos biens.', correct = false },
                { label = 'Chaque fois que vous vous sentez offensé.', correct = false }
            }
        },
        {
            title = 'Quel est le bon moyen de transporter une arme de poing légalement ?',
            answers = {
                { label = 'Déchargée, sécurisée et dans un étui fermé.', correct = true },
                { label = 'Chargée mais avec la sécurité engagée.', correct = false },
                { label = 'Dans la poche arrière.', correct = false }
            }
        },
        {
            title = 'Quand est-il obligatoire de signaler l\'usage de votre arme ?',
            answers = {
                { label = 'Toujours, même si aucun tir n\'a été effectué.', correct = true },
                { label = 'Uniquement s\'il y a un blessé.', correct = false },
                { label = 'Jamais, si l\'arme est enregistrée.', correct = false }
            }
        },
        {
            title = 'Que devez-vous vérifier avant de remettre une arme à feu à quelqu\'un ?',
            answers = {
                { label = 'Qu\'elle est déchargée et la culasse ouverte.', correct = true },
                { label = 'Que la personne sait tirer.', correct = false },
                { label = 'Que le canon est propre.', correct = false }
            }
        },
        {
            title = 'Quelle munition peut être utilisée avec une arme ?',
            answers = {
                { label = 'Uniquement celle homologuée par le fabricant.', correct = true },
                { label = 'Toute munition de calibre proche.', correct = false },
                { label = 'La munition la moins chère.', correct = false }
            }
        },
        {
            title = 'Comment stocker une arme à domicile ?',
            answers = {
                { label = 'Dans un coffre sécurisé, séparée des munitions.', correct = true },
                { label = 'Sous un oreiller pour un accès rapide.', correct = false },
                { label = 'Sur une étagère hors de portée des enfants.', correct = false }
            }
        },
        {
            title = 'Qui peut inspecter votre arme et votre licence ?',
            answers = {
                { label = 'Tout officier de police habilité.', correct = true },
                { label = 'Uniquement le shérif.', correct = false },
                { label = 'Personne sans mandat.', correct = false }
            }
        },
        {
            title = 'Que faire après avoir tiré un coup de feu en situation légale ?',
            answers = {
                { label = 'Sécuriser la zone, ranger l\'arme et contacter les autorités.', correct = true },
                { label = 'Se débarrasser de l\'arme pour éviter les ennuis.', correct = false },
                { label = 'Poster l\'événement sur les réseaux sociaux.', correct = false }
            }
        },
        {
            title = 'Quelle est la conséquence d\'un usage négligent de votre arme ?',
            answers = {
                { label = 'Suspension voire retrait du permis et poursuites.', correct = true },
                { label = 'Un simple avertissement.', correct = false },
                { label = 'La confiscation temporaire sans suite.', correct = false }
            }
        },
        {
            title = 'Quelle est la règle concernant l\'alcool et les armes à feu ?',
            answers = {
                { label = 'Interdiction totale de porter une arme sous l\'influence.', correct = true },
                { label = 'Autorisé jusqu\'à 0,5 g/L.', correct = false },
                { label = 'Autorisé si l\'arme est déchargée.', correct = false }
            }
        },
        {
            title = 'Dans quelle situation devez-vous décliner votre identité lors d\'un contrôle ?',
            answers = {
                { label = 'Toujours lorsque vous portez ou transportez une arme.', correct = true },
                { label = 'Uniquement si vous êtes suspect.', correct = false },
                { label = 'Jamais sans avocat.', correct = false }
            }
        },
        {
            title = 'Que signifie une double sécurité sur une arme ?',
            answers = {
                { label = 'Deux mécanismes empêchant un tir accidentel.', correct = true },
                { label = 'Deux chargeurs montés.', correct = false },
                { label = 'La possibilité de tirer en rafale.', correct = false }
            }
        }
    }
}

Config.Targets = {
    {
        type = 'theory',
        coords = Config.TheoryExam.start,
        icon = 'fas fa-id-card',
        label = 'Passer l\'examen théorique',
        event = 'qb-nexusrp:client:startTheory'
    },
    {
        type = 'practical_car',
        coords = vec3(232.18, -1393.51, 30.5),
        icon = 'fas fa-car-side',
        label = 'Examen pratique voiture',
        event = 'qb-nexusrp:client:startPractical',
        args = 'car'
    },
    {
        type = 'practical_truck',
        coords = vec3(898.01, -2528.6, 28.3),
        icon = 'fas fa-truck-moving',
        label = 'Examen pratique camion',
        event = 'qb-nexusrp:client:startPractical',
        args = 'truck'
    },
    {
        type = 'practical_motorcycle',
        coords = vec3(461.31, -1028.64, 28.14),
        icon = 'fas fa-motorcycle',
        label = 'Examen pratique moto',
        event = 'qb-nexusrp:client:startPractical',
        args = 'motorcycle'
    },
    {
        type = 'weapon',
        coords = Config.WeaponExam.start,
        icon = 'fas fa-crosshairs',
        label = 'Examen permis port d\'arme',
        event = 'qb-nexusrp:client:startWeaponTheory'
    }
}

return Config
