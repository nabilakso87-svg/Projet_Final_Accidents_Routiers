# Modélisation de la base de données BAAC 2020-2024

## 1. Objectif

Cette étape permet de structurer les données BAAC préparées précédemment sous la forme d'une base de données relationnelle.

Le modèle repose sur quatre entités principales :

- ACCIDENT
- LIEU
- VEHICULE
- USAGER

Le MCD a été réalisé avec Looping, puis transformé en MLD afin de préparer la création de la base de données SQL.

## 2. Les entités

### ACCIDENT

La table ACCIDENT contient les informations générales concernant chaque accident : date, heure, localisation, luminosité, conditions atmosphériques, type de collision, etc.

Clé primaire : `Num_Acc`

`Num_Acc` correspond à l'identifiant d'un accident dans les données BAAC.

### LIEU

La table LIEU décrit les caractéristiques de la route et du lieu où s'est produit l'accident : catégorie de route, régime de circulation, nombre de voies, état de la surface, vitesse maximale autorisée, etc.

Clé primaire : `id_lieu`

J'ai ajouté `id_lieu` comme identifiant technique car plusieurs lignes de lieu peuvent être associées au même accident. `Num_Acc` ne peut donc pas servir de clé primaire dans cette table.

### VEHICULE

La table VEHICULE contient les caractéristiques des véhicules impliqués dans les accidents : catégorie du véhicule, obstacles, point de choc, manœuvre principale et motorisation.

Clé primaire : `id_vehicule`

### USAGER

La table USAGER contient les informations concernant les personnes impliquées : catégorie d'usager, place dans le véhicule, gravité, sexe, année de naissance, motif du trajet et équipement de sécurité.

Clé primaire : `id_usager_projet`

L'identifiant officiel `id_usager` n'est pas disponible pour l'année 2020. J'ai donc créé `id_usager_projet` pendant la préparation des données afin de disposer d'un identifiant unique pour toutes les lignes d'usagers entre 2020 et 2024.

## 3. Relations et cardinalités

Le modèle contient trois relations principales :

- ACCIDENT → LIEU : un accident possède un ou plusieurs lieux et une ligne de lieu appartient à un seul accident.
- ACCIDENT → VEHICULE : un accident implique un ou plusieurs véhicules et un véhicule appartient à un seul accident.
- VEHICULE → USAGER : un véhicule comporte un ou plusieurs usagers et un usager est rattaché à un seul véhicule.

Ces relations ont été définies à partir de la structure des données BAAC et vérifiées lors du contrôle global des données préparées.

## 4. Passage du MCD au MLD

Le MCD représente les entités, leurs attributs et leurs relations d'un point de vue conceptuel.

Le MLD traduit ensuite ces relations pour préparer la base SQL.

Les relations deviennent notamment des clés étrangères :

- `LIEU.Num_Acc` → `ACCIDENT.Num_Acc`
- `VEHICULE.Num_Acc` → `ACCIDENT.Num_Acc`
- `USAGER.id_vehicule` → `VEHICULE.id_vehicule`

## 5. Fichiers de modélisation

- `MCD_BAAC_2020_2024.loo` : fichier source modifiable avec Looping.
- `MCD_BAAC_2020_2024.jpg` : représentation du modèle conceptuel de données.
- `MLD_BAAC_2020_2024.jpg` : représentation du modèle logique de données.

Cette modélisation servira de base à la création et au chargement de la base de données SQL.