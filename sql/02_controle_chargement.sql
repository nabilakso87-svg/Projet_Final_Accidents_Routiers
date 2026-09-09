-- 1. Vérification de l'activation des clés étrangères
PRAGMA foreign_keys;


-- 2. Vérification du nombre de lignes chargées

SELECT COUNT(*) AS nombre_accidents
FROM Accident;

SELECT COUNT(*) AS nombre_lieux
FROM Lieu;

SELECT COUNT(*) AS nombre_vehicules
FROM Vehicule;

SELECT COUNT(*) AS nombre_usagers
FROM Usager;


-- 3. Vérification de l'intégrité des relations

-- Vérifier que tous les lieux correspondent à un accident existant
SELECT COUNT(*) AS lieux_sans_accident
FROM Lieu l
LEFT JOIN Accident a
    ON l.Num_Acc = a.Num_Acc
WHERE a.Num_Acc IS NULL;

-- Vérifier que tous les véhicules correspondent à un accident existant
SELECT COUNT(*) AS vehicules_sans_accident
FROM Vehicule v
LEFT JOIN Accident a
    ON v.Num_Acc = a.Num_Acc
WHERE a.Num_Acc IS NULL;

-- Vérifier que tous les usagers correspondent à un véhicule existant
SELECT COUNT(*) AS usagers_sans_vehicule
FROM Usager u
LEFT JOIN Vehicule v
    ON u.id_vehicule = v.id_vehicule
WHERE v.id_vehicule IS NULL;


-- 4. Vérification globale des clés étrangères SQLite
PRAGMA foreign_key_check;


-- 5. Vérification des valeurs manquantes
-- Vérification des valeurs manquantes après réimport de Accident
SELECT
    COUNT(*) AS nombre_lignes,
    SUM(CASE WHEN adresse IS NULL THEN 1 ELSE 0 END) AS adresse_null,
    SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS latitude_null,
    SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS longitude_null
FROM Accident;

-- Vérification des valeurs manquantes après réimport de Lieu
SELECT
    COUNT(*) AS nombre_lignes,
    SUM(CASE WHEN regime_circulation IS NULL THEN 1 ELSE 0 END) AS regime_circulation_null,
    SUM(CASE WHEN nombre_voies IS NULL THEN 1 ELSE 0 END) AS nombre_voies_null,
    SUM(CASE WHEN profil_route IS NULL THEN 1 ELSE 0 END) AS profil_route_null,
    SUM(CASE WHEN trace_route IS NULL THEN 1 ELSE 0 END) AS trace_route_null,
    SUM(CASE WHEN etat_surface IS NULL THEN 1 ELSE 0 END) AS etat_surface_null,
    SUM(CASE WHEN situation_accident IS NULL THEN 1 ELSE 0 END) AS situation_accident_null,
    SUM(CASE WHEN vitesse_max_autorisee IS NULL THEN 1 ELSE 0 END) AS vitesse_max_autorisee_null
FROM Lieu;


-- Vérification des valeurs manquantes après réimport de Vehicule
SELECT
    COUNT(*) AS nombre_lignes,
    SUM(CASE WHEN categorie_vehicule IS NULL THEN 1 ELSE 0 END) AS categorie_vehicule_null,
    SUM(CASE WHEN obstacle_fixe IS NULL THEN 1 ELSE 0 END) AS obstacle_fixe_null,
    SUM(CASE WHEN obstacle_mobile IS NULL THEN 1 ELSE 0 END) AS obstacle_mobile_null,
    SUM(CASE WHEN point_choc_initial IS NULL THEN 1 ELSE 0 END) AS point_choc_initial_null,
    SUM(CASE WHEN manoeuvre_principale IS NULL THEN 1 ELSE 0 END) AS manoeuvre_principale_null,
    SUM(CASE WHEN motorisation IS NULL THEN 1 ELSE 0 END) AS motorisation_null
FROM Vehicule;

-- Vérification des valeurs manquantes après réimport de Usager
SELECT
    COUNT(*) AS nombre_lignes,
    SUM(CASE WHEN id_usager IS NULL THEN 1 ELSE 0 END) AS id_usager_null,
    SUM(CASE WHEN place_usager IS NULL THEN 1 ELSE 0 END) AS place_usager_null,
    SUM(CASE WHEN gravite IS NULL THEN 1 ELSE 0 END) AS gravite_null,
    SUM(CASE WHEN sexe IS NULL THEN 1 ELSE 0 END) AS sexe_null,
    SUM(CASE WHEN annee_naissance IS NULL THEN 1 ELSE 0 END) AS annee_naissance_null,
    SUM(CASE WHEN motif_trajet IS NULL THEN 1 ELSE 0 END) AS motif_trajet_null,
    SUM(CASE WHEN equipement_securite IS NULL THEN 1 ELSE 0 END) AS equipement_securite_null
FROM Usager;

