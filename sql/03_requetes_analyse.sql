-- =====================================================
-- REQUÊTES D'ANALYSE MÉTIER
-- BAAC 2020-2024
-- =====================================================
-- =====================================================
-- 1. EXPLORATION DES DONNÉES
-- =====================================================

-- 1.1. Aperçu de la table Accident
SELECT *
FROM Accident
LIMIT 10;


-- 1.2. Aperçu de la table Lieu
SELECT *
FROM Lieu
LIMIT 10;


-- 1.3. Aperçu de la table Vehicule
SELECT *
FROM Vehicule
LIMIT 10;


-- 1.4. Aperçu de la table Usager
SELECT *
FROM Usager
LIMIT 10;



-- =====================================================
-- 2. COMMENT LES ACCIDENTS ÉVOLUENT-ILS DANS LE TEMPS ?
-- =====================================================

-- 2.1. Nombre d'accidents par année

SELECT
    annee,
    COUNT(*) AS nombre_accidents
FROM Accident
GROUP BY annee
ORDER BY annee;


-- 2.2. Évolution de la gravité des usagers par année

SELECT
    a.annee,

    CASE u.gravite
        WHEN 1 THEN 'Indemne'
        WHEN 2 THEN 'Tué'
        WHEN 3 THEN 'Blessé hospitalisé'
        WHEN 4 THEN 'Blessé léger'
        ELSE 'Non renseigné'
    END AS niveau_gravite,

    COUNT(*) AS nombre_usagers

FROM Usager u

JOIN Vehicule v
    ON u.id_vehicule = v.id_vehicule

JOIN Accident a
    ON v.Num_Acc = a.Num_Acc

GROUP BY
    a.annee,
    u.gravite

ORDER BY
    a.annee,
    u.gravite;

-- 2.3. Évolution mensuelle du nombre d'accidents

SELECT
    mois,

    SUM(CASE WHEN annee = 2020 THEN 1 ELSE 0 END) AS "2020",
    SUM(CASE WHEN annee = 2021 THEN 1 ELSE 0 END) AS "2021",
    SUM(CASE WHEN annee = 2022 THEN 1 ELSE 0 END) AS "2022",
    SUM(CASE WHEN annee = 2023 THEN 1 ELSE 0 END) AS "2023",
    SUM(CASE WHEN annee = 2024 THEN 1 ELSE 0 END) AS "2024"

FROM Accident

GROUP BY mois

ORDER BY mois;

-- 2.4. Répartition des accidents selon l'heure

SELECT
    CAST(SUBSTR(heure_minute, 1, 2) AS INTEGER) AS heure,
    COUNT(*) AS nombre_accidents
FROM Accident
GROUP BY heure
ORDER BY heure;


-- =====================================================
-- 3. QUELLES CIRCONSTANCES SONT ASSOCIÉES À LA GRAVITÉ ?
-- =====================================================

-- 3.1. Répartition des accidents selon
-- les conditions atmosphériques

SELECT
    CASE conditions_atmospheriques
        WHEN 1 THEN 'Normale'
        WHEN 2 THEN 'Pluie légère'
        WHEN 3 THEN 'Pluie forte'
        WHEN 4 THEN 'Neige / grêle'
        WHEN 5 THEN 'Brouillard / fumée'
        WHEN 6 THEN 'Vent fort / tempête'
        WHEN 7 THEN 'Temps éblouissant'
        WHEN 8 THEN 'Temps couvert'
        WHEN 9 THEN 'Autre'
        ELSE 'Non renseigné'
    END AS condition_atmospherique,

    COUNT(*) AS nombre_accidents

FROM Accident

GROUP BY conditions_atmospheriques

ORDER BY nombre_accidents DESC;

-- 3.2. Taux de gravité élevée selon les conditions atmosphériques

-- Gravité élevée = Tué ou Blessé hospitalisé
-- Le taux est calculé uniquement sur les usagers
-- dont la gravité est renseignée.

SELECT
    CASE a.conditions_atmospheriques
        WHEN 1 THEN 'Normale'
        WHEN 2 THEN 'Pluie légère'
        WHEN 3 THEN 'Pluie forte'
        WHEN 4 THEN 'Neige / grêle'
        WHEN 5 THEN 'Brouillard / fumée'
        WHEN 6 THEN 'Vent fort / tempête'
        WHEN 7 THEN 'Temps éblouissant'
        WHEN 8 THEN 'Temps couvert'
        WHEN 9 THEN 'Autre'
        ELSE 'Non renseigné'
    END AS condition_atmospherique,

    COUNT(*) AS nombre_usagers,

    SUM(
        CASE
            WHEN u.gravite IN (2, 3) THEN 1
            ELSE 0
        END
    ) AS nombre_gravite_elevee,

    SUM(
        CASE
            WHEN u.gravite IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS nombre_gravite_connue,

    ROUND(
        100.0 *
        SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        /
        NULLIF(
            SUM(CASE WHEN u.gravite IS NOT NULL THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS taux_gravite_elevee,

    SUM(
        CASE
            WHEN u.gravite IS NULL THEN 1
            ELSE 0
        END
    ) AS gravite_non_renseignee

FROM Usager u

JOIN Vehicule v
    ON u.id_vehicule = v.id_vehicule

JOIN Accident a
    ON v.Num_Acc = a.Num_Acc

GROUP BY a.conditions_atmospheriques

ORDER BY taux_gravite_elevee DESC;

-- 3.3. Taux de gravité élevée selon les conditions de luminosité

-- Gravité élevée = Tué ou Blessé hospitalisé
-- Le taux est calculé uniquement sur les usagers
-- dont la gravité est renseignée.

SELECT
    CASE a.luminosite
        WHEN 1 THEN 'Plein jour'
        WHEN 2 THEN 'Crépuscule ou aube'
        WHEN 3 THEN 'Nuit sans éclairage public'
        WHEN 4 THEN 'Nuit avec éclairage public non allumé'
        WHEN 5 THEN 'Nuit avec éclairage public allumé'
        ELSE 'Non renseigné'
    END AS condition_luminosite,

    COUNT(*) AS nombre_usagers,

    SUM(
        CASE
            WHEN u.gravite IN (2, 3) THEN 1
            ELSE 0
        END
    ) AS nombre_gravite_elevee,

    SUM(
        CASE
            WHEN u.gravite IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS nombre_gravite_connue,

    ROUND(
        100.0 *
        SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        /
        NULLIF(
            SUM(CASE WHEN u.gravite IS NOT NULL THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS taux_gravite_elevee,

    SUM(
        CASE
            WHEN u.gravite IS NULL THEN 1
            ELSE 0
        END
    ) AS gravite_non_renseignee

FROM Usager u

JOIN Vehicule v
    ON u.id_vehicule = v.id_vehicule

JOIN Accident a
    ON v.Num_Acc = a.Num_Acc

GROUP BY a.luminosite

ORDER BY taux_gravite_elevee DESC;

-- =====================================================
-- 4. OÙ LES ACCIDENTS GRAVES SONT-ILS LES PLUS FRÉQUENTS ?
-- =====================================================

-- 4.1. Gravité élevée par département

-- Gravité élevée = Tué ou Blessé hospitalisé
-- Le taux est calculé uniquement sur les usagers
-- dont la gravité est renseignée.

SELECT
    a.departement,

    COUNT(*) AS nombre_usagers,

    SUM(
        CASE
            WHEN u.gravite IN (2, 3) THEN 1
            ELSE 0
        END
    ) AS nombre_gravite_elevee,

    SUM(
        CASE
            WHEN u.gravite IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS nombre_gravite_connue,

    ROUND(
        100.0 *
        SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        /
        NULLIF(
            SUM(CASE WHEN u.gravite IS NOT NULL THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS taux_gravite_elevee,

    SUM(
        CASE
            WHEN u.gravite IS NULL THEN 1
            ELSE 0
        END
    ) AS gravite_non_renseignee

FROM Usager u

JOIN Vehicule v
    ON u.id_vehicule = v.id_vehicule

JOIN Accident a
    ON v.Num_Acc = a.Num_Acc

GROUP BY a.departement

ORDER BY nombre_gravite_elevee DESC;

-- 4.2. Gravité élevée selon le type d'agglomération

SELECT
    CASE a.agglomeration
        WHEN 1 THEN 'Hors agglomération'
        WHEN 2 THEN 'En agglomération'
    END AS type_agglomeration,

    COUNT(*) AS nombre_usagers,

    SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        AS nombre_gravite_elevee,

    ROUND(
        100.0 * SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        / COUNT(u.gravite),
        2
    ) AS taux_gravite_elevee

FROM Usager u
JOIN Vehicule v ON u.id_vehicule = v.id_vehicule
JOIN Accident a ON v.Num_Acc = a.Num_Acc

GROUP BY a.agglomeration
ORDER BY taux_gravite_elevee DESC;

-- =====================================================
-- 5. QUELS PROFILS D'USAGERS SONT LES PLUS CONCERNÉS ?
-- =====================================================

-- 5.1. Gravité élevée selon la catégorie d'usager

SELECT
    CASE categorie_usager
        WHEN 1 THEN 'Conducteur'
        WHEN 2 THEN 'Passager'
        WHEN 3 THEN 'Piéton'
        ELSE 'Non renseigné'
    END AS categorie_usager,

    COUNT(*) AS nombre_usagers,

    SUM(CASE WHEN gravite IN (2, 3) THEN 1 ELSE 0 END)
        AS nombre_gravite_elevee,

    ROUND(
        100.0 * SUM(CASE WHEN gravite IN (2, 3) THEN 1 ELSE 0 END)
        / COUNT(gravite),
        2
    ) AS taux_gravite_elevee

FROM Usager

GROUP BY categorie_usager

ORDER BY taux_gravite_elevee DESC;

-- 5.2. Gravité élevée selon la tranche d'âge
-- Les âges supérieurs à 100 ans (44 observations)
-- sont exclus de cette analyse comme valeurs aberrantes.
-- Ce seuil correspond à un choix analytique du projet.

SELECT
    CASE
        WHEN a.annee - u.annee_naissance < 18 THEN '0-17 ans'
        WHEN a.annee - u.annee_naissance BETWEEN 18 AND 24 THEN '18-24 ans'
        WHEN a.annee - u.annee_naissance BETWEEN 25 AND 34 THEN '25-34 ans'
        WHEN a.annee - u.annee_naissance BETWEEN 35 AND 49 THEN '35-49 ans'
        WHEN a.annee - u.annee_naissance BETWEEN 50 AND 64 THEN '50-64 ans'
        WHEN a.annee - u.annee_naissance BETWEEN 65 AND 100 THEN '65 ans et plus'
    END AS tranche_age,

    COUNT(*) AS nombre_usagers,

    SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        AS nombre_gravite_elevee,

    ROUND(
        100.0 * SUM(CASE WHEN u.gravite IN (2, 3) THEN 1 ELSE 0 END)
        / COUNT(u.gravite),
        2
    ) AS taux_gravite_elevee

FROM Usager u
JOIN Vehicule v ON u.id_vehicule = v.id_vehicule
JOIN Accident a ON v.Num_Acc = a.Num_Acc

WHERE u.annee_naissance IS NOT NULL
  AND a.annee - u.annee_naissance BETWEEN 0 AND 100

GROUP BY tranche_age

ORDER BY taux_gravite_elevee DESC;

-- 5.3. Gravité élevée selon le sexe

SELECT
    CASE sexe
        WHEN 1 THEN 'Masculin'
        WHEN 2 THEN 'Féminin'
    END AS sexe,

    COUNT(*) AS nombre_usagers,

    SUM(CASE WHEN gravite IN (2, 3) THEN 1 ELSE 0 END)
        AS nombre_gravite_elevee,

    ROUND(
        100.0 * SUM(CASE WHEN gravite IN (2, 3) THEN 1 ELSE 0 END)
        / COUNT(gravite),
        2
    ) AS taux_gravite_elevee

FROM Usager

WHERE sexe IS NOT NULL

GROUP BY sexe

ORDER BY taux_gravite_elevee DESC;

