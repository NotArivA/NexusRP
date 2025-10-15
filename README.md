
+Serveur FiveM GTA V entièrement personnalisé basé sur le framework **qb-core**.
+Ce dépôt fournit la configuration complète du serveur, des ressources personnalisées
+et un script d'installation pour télécharger les dépendances officielles qb-core.
+
+## Sommaire
+- [Fonctionnalités](#fonctionnalités)
+- [Prérequis](#prérequis)
+- [Installation](#installation)
+- [Configuration](#configuration)
+- [Ressource personnalisée `qb-nexusrp`](#ressource-personnalisée-qb-nexusrp)
+- [Structure du dépôt](#structure-du-dépôt)
+- [Développement local](#développement-local)
+
+## Fonctionnalités
+- Configuration `server.cfg` prête à l'emploi avec les ressources qb-core essentielles.
+- Script `setup.sh` pour télécharger automatiquement qb-core et les ressources dépendantes.
+- Ressource personnalisée `qb-nexusrp` proposant :
+  - Trois métiers inédits (police, EMS, mécanicien) avec zones de service dynamiques.
+  - Gestion de stocks sécurisés restreints par métier.
+  - Système de salaires différés avec menu de récupération et notifications.
+  - Items de départ personnalisés et badge NexusRP utilisable.
+  - Intégration billing/sociétés et webhooks Discord structurés.
+  - Tableau de missions immersif inspiré du lore GTA avec interface NUI responsive et thèmes par métier.
+  - Générateur de contrats dynamiques par métier avec suivi en direct, primes bancaires et roster en service.
+  - Portail d'enregistrement RP complet avec biographies, origines, voix et personnalisation visuelle inspirée GTA.
+  - Boutiques immersives (électronique, loisirs, alimentation, alcool, textile) avec paiements cash/carte et essayage NUI.
+  - HUD vital (santé, armure, faim, soif) stylisé et synchronisé avec les métadonnées qb-core.
+  - Module conducteur GTA-like affichant vitesse, kilométrage et jauge d'essence en temps réel.
+  - Synchronisation intelligente de la faim/soif avec envoi différé côté serveur et partage d'état pour les autres systèmes.
+  - Réseau d'annonces Nexus diffusant des bulletins dynamiques (F7) et alertes carburant corrélées aux fluctuations de prix.
+  - Activités scénarisées propres à chaque métier avec primes instantanées et suivi du dispatch.
+  - Activités payantes grand public (tour skyline, croisière, descentes encadrées) avec inscription sécurisée.
+  - Système d'appartements modulaires avec achats persistants, stockage privé, dressing et zones RP.
+  - Système bancaire complet Maze Bank avec agences, ATM interactifs, virements et relevés NUI.
+  - Inventaire Nexus personnalisé avec sacs persistants, entrepôts privés et interface NUI lore friendly.
+  - Réseau de franchises LSCustoms/Benny's avec NUI de customisation, partage des revenus et persistance des modifications véhicules.
+
+## Prérequis
+- [FXServer](https://docs.fivem.net/docs/server-manual/setting-up-a-server/) (artefacts récents).
+- Base de données MySQL/MariaDB accessible (recommandé : `oxmysql`).
+- Git installé sur la machine de déploiement (utilisé par le script `setup.sh`).
+- Clé de licence FiveM valide (`sv_licenseKey`).
+
+## Installation
+1. Cloner ce dépôt sur votre machine serveur :
+   ```bash
+   git clone https://example.com/NexusRP.git
+   cd NexusRP
+   ```
+2. Télécharger les ressources qb-core officielles :
+   ```bash
+   chmod +x scripts/setup.sh
+   ./scripts/setup.sh
+   ```
+3. Copier `server.cfg` à la racine de votre dossier FXServer.
+4. Ajuster les valeurs sensibles (clé de licence, bannière, webhooks, identifiants MySQL).
+5. Lancer le serveur via `bash ./run.sh +exec server.cfg` (ou le script adapté à votre hébergeur).
+
+## Configuration
+- `server.cfg` définit les ressources à lancer (`ensure qb-nexusrp`) et les paramètres globaux.
+- Les variables `setr nexusrp:*` permettent d'activer le logging structuré Discord.
+- Le fichier `resources/[qb]/qb-nexusrp/shared/config.lua` contient :
+  - Les métiers personnalisés, leurs grades et localisations clés.
+  - Les items de départ distribués à chaque nouveau joueur.
+  - Les stocks sécurisés et comptes de facturation.
+  - La configuration des tableaux de mission (position, thème visuel et contrats).
+  - Les activités de métier, activités payantes et points d'entrée d'appartement.
+  - Les paramètres d'enregistrement RP, les options de personnalisation et les préréglages de tenues.
+  - Les inventaires des boutiques immersives et les réglages des besoins vitaux ainsi que du carburant dynamique.
+  - Les paramètres d'inventaire Nexus (slots par défaut, sacs, entrepôts et poids maximum).
+  - Les ateliers `Config.VehicleCustoms` (LSCustoms/Benny's) avec options, franchises, partages et tarifs de main-d'œuvre.
+  - Les intégrations `Config.DiscordIntegrations` permettant de relayer le réseau social in-game vers Discord.
+
+### Tableau de missions Nexus
+
+- Interactions via `qb-target` sur les consoles LSPD, EMS et Nexus Customs.
+- Interface NUI respectant l'identité visuelle GTA (Los Santos Command Terminal) et adaptée à chaque corps de métier.
+- Attribution de contrats avec difficulté, zone d'intervention et récompense dynamique.
+- Possibilité de clôturer ou d'abandonner une mission directement depuis l'interface.
+- Rafraîchissement automatique du roster en service et statistiques des contrats actifs.
+
+### Enregistrement & personnalisation de personnage
+
+- Ouverture automatique du dossier Nexus à la première connexion ou sur demande du staff.
+- Étapes guidées : biographie/motto, origines & lifestyle, voix/accent et sélection de tenues/haircut.
+- Prévisualisation directe in-game (NUI) avec application instantanée via exports `qb-nexusrp:PreviewAppearance`.
+- Sauvegarde des sélections (background, lifestyle, apparence) dans les métadonnées pour réouverture ultérieure.
+- Session styliste depuis la boutique textile pour modifier le style sans repasser par les étapes RP.
+- Archivage automatique du dossier dans `nexusrp_character_registry` avec liaison Discord (identifiant `discord:`) pour audit staff.
+
+### Boutiques immersives prêtes à l'emploi
+
+- 5 magasins répartis en ville : Digital Den (électronique), Vespucci Hobbies (loisirs), 24/7 Del Perro (alimentation), Vinewood Spirits (alcool) et Textile City Atelier.
+- Interface NUI unique avec panier rapide, essayage des outfits et paiements cash ou carte selon la boutique.
+- Achat de services (session styliste) ouvrant directement la personnalisation, et journalisation serveur (`qb-nexusrp:server:logEvent`).
+- Zones `qb-target` + blips configurables, chaque inventaire étant défini dans `Config.Stores`.
+
+### Concessions Nexus & flottes spécialisées
+
+- `Config.Stores` intègre désormais des concessions moto (Mirror Park Moto), autos (Downtown Nexus Autos) et hypercars (Apollo Exotics) ainsi que les dépôts nautique, avion et hélico. Chaque boutique applique des thèmes immersifs (`Config.InterfaceThemes`) et livre directement les véhicules sur l'aire configurée.
+- Les concessions civiles valident automatiquement les prérequis de permis (`requiresLicenses`) avant l'achat et facturent les véhicules via le système commun `qb-nexusrp:server:purchaseFromShop`.
+- Les flottes métiers (Nexus Customs, LSPD Nexus, EMS Nexus) disposent de boutiques séparées avec restrictions de grade (`access.jobs`) et garages dédiés afin d'éviter tout mélange entre services.
+- L'armurerie Maze & Co nécessite le permis d'armes et propose armes/équipements réglementés, en assurant la livraison via la même interface NUI.
+
+### LSCustoms & Benny's franchises
+
+- `Config.VehicleCustoms.franchises` définit les ateliers disponibles (Burton LSC, Benny's Little Seoul) avec prix d'achat, pourcentage de commission et rayon `qb-target`.
+- Tout citoyen peut accéder au menu de customisation depuis la zone : l'UI NUI liste les catégories (peintures, performance, intérieur, accessoires) avec aperçu instantané et panier.
+- Les franchisés peuvent acheter l'atelier (paiement banque) et accumulent un pourcentage de chaque commande : les bénéfices sont crédités en base (`nexusrp_customs_franchises.balance`) et retirables via le panneau.
+- Les modifications appliquées mettent à jour la base de données selon le type de véhicule : `player_vehicles.mods` pour les véhicules personnels, `nexusrp_company_vehicles` pour les flottes métiers (dépôts police/EMS/mécano).
+- Les tarifs incluent automatiquement le coût de main-d'œuvre (`Config.VehicleCustoms.laborFee`) et les propriétaires reçoivent des journaux (`customs_*`) dans les logs serveur.
+
+### Intégration téléphone & webhooks Discord
+
+- Le module `server/phone.lua` écoute les évènements Twitter du téléphone (`qb-phone`) et relaie chaque publication sur le webhook défini dans `Config.DiscordIntegrations.twitterWebhook`.
+- Les embeds Discord reprennent auteur, handle, message, image éventuelle et identifiants (CitizenID + Discord) pour modération rapide.
+- Un évènement personnalisé `qb-nexusrp:server:twitter:relay` permet d'envoyer manuellement une publication si vous utilisez une autre application téléphone.
+
+### Système de licences & examens Nexus
+
+- `Config.Licenses` définit chaque homologation (auto, poids lourd, nautique, avion, hélicoptère, port d'arme) avec questionnaires, parcours pratiques, frais et dépendances (ex. permis auto obligatoire avant poids lourd).
+- Les centres d'examen (`Config.LicenseCenters`) posent des zones `qb-target`, blips et thèmes pour accéder au bureau des permis.
+- La NUI « Bureau des permis Nexus » gère affichage des prérequis, frais, progression et lancement des examens. Les examens théoriques sont chronométrés dans l'UI, l'épreuve pratique déclenche un véhicule / stand de tir avec suivi du temps, erreurs et checkpoints.
+- Les résultats sont persistés dans les métadonnées joueur (`nexusrp_licenses`) et réutilisés dans les boutiques (concessions, armureries, flottes).
+
+### Activités de métier scénarisées
+
+- Points de dispatch `qb-target` dédiés à chaque corps (LSPD, EMS, mécano) définis dans `Config.JobActivities`.
+- Menu `qb-menu` listant les interventions disponibles, avec contrôle de cooldown par joueur.
+- Envoi automatique de waypoint/blip, interaction sur zone et progression animée avant prime bancaire.
+- Toutes les récompenses et messages sont configurables dans `shared/config.lua` et loggés via `qb-nexusrp:server:logEvent`.
+
+### Activités payantes grand public
+
+- Chaque activité (`Config.PaidActivities`) expose un point d'inscription `qb-target`, un blip optionnel et un texte descriptif.
+- Le serveur gère la facturation (banque puis cash) et la distribution de la récompense lorsque l'objectif est complété.
+- Les coordonnées d'objectif sont synchronisées au client (blip + waypoint) avec progression immersive (`Progressbar`).
+- Ajoutez vos propres expériences en dupliquant une entrée et en ajustant prix, récompense et limite de temps.
+
+### Contrats indépendants rémunérés
+
+- Nouveau module `Config.FreelanceActivities` proposant des contrats mineur, électricien, pêcheur et nettoyeur de piscine accessibles sans whitelist.
+- Chaque contrat vérifie l'équipement requis (pioche + gants, caisse à outils, canne à pêche + appâts, kit de nettoyage + chlore) avant de démarrer.
+- Les joueurs reçoivent un waypoint, une zone `qb-target` immersive avec animation adaptée et une prime cash immédiate à la complétion.
+- Les expirations, journaux (`qb-nexusrp:server:logEvent`) et blips thématiques sont entièrement configurables côté serveur.
+
+### Système d'appartements Nexus
+
+- Halls d'accueil `qb-target` pour chaque résidence définie dans `Config.Apartments` (prix, charges, coordonnées interior).
+- Achat persistant (table SQL `nexusrp_apartments`) avec limite configurable (`Config.ApartmentSettings.maxOwned`).
+- Intérieur instancié : sortie, stockage privé Nexus (inventaire personnalisé), dressing (`qb-clothing`) et zone de repos RP.
+- Les résidents peuvent réouvrir le menu depuis le hall, et un mode visite permet de prévisualiser avant achat.
+
+### Système bancaire Maze Bank
+
+- Création automatique des comptes courant et épargne pour chaque citoyen, paramétrables via `Config.Banking`.
+- Interface NUI immersive : soldes, limite journalière de virement, historique détaillé des opérations et thèmes Maze Bank.
+- Guichets automatiques (ATM) et conseillers en agence `qb-target` avec dépôts/retraits cash, transferts internes et virements citoyens.
+- Intérêts configurables sur le livret, frais d'ATM et blips/targets prêts à l'emploi pour les agences principales de Los Santos.
+
+### Inventaire Nexus & sacs persistants
+
+- Interface NUI dédiée reprenant le design Maze Bank Logistics : colonnes joueur, sac et stockage externe avec résumé des capacités.
+- `Config.Inventory` pilote les slots/poids par défaut, la réserve de raccourcis, les trois paliers de sacs (`nexus_bag_small`, `nexus_bag_medium`, `nexus_bag_large`), les entrepôts urbains ainsi que les consignes statiques (`staticStashes`) et leurs accès.
+- Les sacs sont des items utilisables : à l'équipement, ils créent un stockage persistant synchronisé en base (`nexusrp_bags`).
+- Le module serveur expose une API de transfert sécurisée (joueur ↔ sac ↔ stash ↔ entrepôt) avec vérification du poids et journalisation côté qb-core.
+- Des entrepôts publics (docks, Vinewood, Sandy) sont accessibles via `qb-target` ou depuis le panneau inventaire ; un frais configurable est débité lors de l'ouverture.
+- Les consignes Nexus (central Maze Bank, canal Vespucci, relais Paleto) sont préenregistrées avec zones `qb-target`, restrictions par métier et boutons dédiés dans la NUI.
+- Les métadonnées joueur (`nexusrp_bag`) suivent le sac actif pour permettre aux autres scripts de vérifier la capacité supplémentaire disponible.
+
+### Ligne Souterraine & activités clandestines
+
+- Deux VPM (vendeurs à profil masqué) stationnent à Vespucci et Del Perro. Ils exigent un kit de piratage complet (VPN, Trojan USB x2, crochet avancé) pour vous inscrire sur leur registre chiffré.
+- Une fois introduit, votre profil reçoit un identifiant aléatoire `555-XXXX` et l'application **Ligne Souterraine** s'ajoute à votre NUI. Toutes les interactions sont sécurisées via ce numéro.
+- Trois dossiers de sélection doivent être validés avant de débloquer les contrats : détournement de cache Blacksite, fraude bancaire Ghost Accounts et livraison EMP Mirrored Payload. Chaque dossier consomme des items rares et un dépôt cash.
+- L'interface mobile permet de suivre les exigences, de livrer les gages et de consulter la réputation clandestine associée au profil.
+- Les contrats illégaux (Storm Siphon, Crownwire Heist, Néon Pressure) déroulent des étapes multi-zones (planque, piratage, livraison) avec waypoint dynamique, vérification véhicule et retrait d'items requis. Les récompenses sont versées en cash et augmentent la réputation.
+- Tout abandon ou dépassement de délai applique une pénalité automatique (`failurePenalty`) avant de retenter un contrat. Les logs serveurs `underworld-*` tracent l'ensemble des interactions.
+
+### Statuts vitaux & conduite
+
+- HUD discret en bas à gauche affichant santé, armure, faim et soif avec transitions de couleur selon les seuils (normal, warning, critical).
+- Décrément configurable (`Config.Needs`) et synchronisation avec les métadonnées qb-core (hunger/thirst).
+- Notifications dynamiques lorsque les seuils warning/critical sont atteints pour les quatre jauges.
+- API serveur `qb-nexusrp:server:updateNeeds` permettant à d'autres scripts d'ajuster les valeurs si nécessaire.
+- HUD conducteur à droite : vitesse instantanée (km/h), kilométrage cumulé et jauge de carburant dynamique.
+
+### Système de carburant dynamique
+
+- `Config.Fuel` définit la consommation par classe de véhicule, les stations `qb-target`, les options de remplissage et l'intervalle de synchronisation.
+- Prix du litre fluctuant automatiquement dans une fourchette configurable et diffusé via notifications et écrans de stations.
+- En stations, menu immersif permettant de choisir un remplissage (10/25/50 L ou plein) avec barre de progression et retrait cash sécurisé.
+- Sauvegarde serveur par plaque : niveau d'essence, kilométrage et coupure moteur automatique si le réservoir est vide.
+
+## Ressource personnalisée `qb-nexusrp`
+- **Client** (`client/*.lua`) : gestion du service, zones `qb-target`, menu salaires.
+- **Serveur** (`server/*.lua`) : enregistrement des métiers, distribution des items, facturation et journaux.
+- **Shared** (`shared/*.lua`) : configuration, locales et traduction française.
+- Déclare les dépendances vers `qb-core`, `qb-target`, `qb-menu`, `qb-inventory` et `oxmysql`.
+
+### Ajouter un nouveau métier
+1. Ajouter une entrée dans `Config.CustomJobs` (nom unique, grades, positions).
+2. Redémarrer la ressource `qb-nexusrp` ou le serveur pour charger le métier.
+3. Utiliser `QBCore.Functions.SetJob` via un script ou l'administration pour affecter le métier à un joueur.
+
+### Personnaliser les salaires
+- Modifier `payment` dans la définition des grades.
+- Ajuster la logique de génération de paie dans `server/jobs.lua` (`Utils.QueuePaycheck`).
+
+## Structure du dépôt
+```
+NexusRP/
+├── README.md
+├── server.cfg
+├── sql/
+│   └── nexusrp_inventory.sql
+├── scripts/
+│   └── setup.sh
+└── resources/
+    └── [qb]/
+        └── qb-nexusrp/
+            ├── fxmanifest.lua
+            ├── client/
+            ├── server/
+            └── shared/
+```
+
+Le dossier `sql/` fournit un script unique (`nexusrp_inventory.sql`) à importer via phpMyAdmin/HeidiSQL : il crée les tables `nexusrp_stashes`, `nexusrp_bags`, `nexusrp_customs_franchises`, `nexusrp_company_vehicles`, `nexusrp_character_registry` et ajoute les items `nexus_bag_*` au catalogue `items`.
+
+## Développement local
+- Utiliser la commande `ensure qb-nexusrp` pour recharger la ressource après modifications.
+- Activer le mode debug de `qb-target` si nécessaire pour vérifier les zones (`debugPoly = true`).
+- Surveiller la console serveur pour les logs `qb-nexusrp` et les éventuelles erreurs Lua.
+
+Bon développement et bienvenue sur NexusRP !
