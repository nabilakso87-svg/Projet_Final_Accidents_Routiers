# Analyse des accidents routiers en France – BAAC 2020-2024

## Présentation du projet

Ce projet est réalisé dans le cadre de ma formation Data Analyst.

Il porte sur l'analyse des accidents corporels de la circulation en France entre 2020 et 2024 à partir des données officielles BAAC (Bulletins d'Analyse des Accidents Corporels).

L'objectif est d'étudier l'évolution des accidents et d'identifier les situations et profils associés aux accidents les plus graves.

## Problématique

**Comment les accidents corporels de la circulation ont-ils évolué en France entre 2020 et 2024, et quels facteurs permettent d’identifier les situations et profils associés aux accidents les plus graves ?**

## Source des données

Les données utilisées proviennent des bases annuelles BAAC publiées sur la plateforme data.gouv.fr par l'Observatoire national interministériel de la sécurité routière (ONISR).

Pour chaque année de 2020 à 2024, les données sont réparties en quatre catégories :

- Caractéristiques
- Lieux
- Véhicules
- Usagers

Les fichiers bruts sont conservés sans modification afin de préserver les données d'origine.

## Organisation des données

Les données sont organisées en trois niveaux :

- `data/raw` : fichiers BAAC originaux téléchargés pour les années 2020 à 2024 ;
- `data/interim` : fichiers intermédiaires obtenus après harmonisation et consolidation des données annuelles ;
- `data/processed` : fichiers nettoyés et préparés pour les analyses suivantes.
- `data/looker_studio/` : fichiers CSV préparés pour les visualisations dans Google Looker Studio.
  
## Travail réalisé

### 1. Préparation et nettoyage des données

La première phase du projet a permis de préparer et de fiabiliser les données BAAC avant leur exploitation.

Les principales étapes réalisées sont :

- collecte et organisation des fichiers BAAC de 2020 à 2024 ;
- contrôle de la structure des fichiers annuels ;
- harmonisation des colonnes et des types de données ;
- consolidation des données 2020 à 2024 ;
- analyse des valeurs manquantes, doublons et valeurs incohérentes ;
- traitement des données en tenant compte de la documentation officielle BAAC ;
- sélection et renommage des variables utiles ;
- création des fichiers nettoyés pour Caractéristiques, Lieux, Véhicules et Usagers ;
- contrôle des identifiants et des relations entre les quatre catégories de données ;
- validation de la cohérence globale des données.

### 2. Modélisation relationnelle

Un modèle relationnel a été construit à partir des quatre principales entités :

- Accident ;
- Lieu ;
- Véhicule ;
- Usager.

Les clés primaires et étrangères ont été définies afin de représenter les relations entre les différentes tables.

Le MCD et le MLD ont été réalisés avec Looping.

### 3. Création et chargement de la base SQL

Une base de données SQLite a été créée à partir du modèle relationnel.

Les quatre tables ont été chargées avec les données nettoyées :

- Accident : 268 788 lignes ;
- Lieu : 294 438 lignes ;
- Vehicule : 459 137 lignes ;
- Usager : 612 181 lignes.

Des contrôles ont ensuite été réalisés afin de vérifier :

- le nombre de lignes chargées ;
- l'intégrité des relations entre les tables ;
- l'absence de lignes orphelines ;
- le respect des clés étrangères ;
- la bonne prise en compte des valeurs manquantes.

### 4. Analyses SQL

Des requêtes SQL ont été réalisées afin de répondre progressivement à la problématique du projet.

Les analyses portent notamment sur :

- l'évolution annuelle et mensuelle des accidents ;
- la répartition des accidents selon l'heure ;
- les conditions atmosphériques ;
- les conditions de luminosité ;
- la gravité selon les départements ;
- la gravité en et hors agglomération ;
- la catégorie des usagers ;
- les tranches d'âge ;
- le sexe des usagers.

Pour les analyses de gravité, un indicateur de **gravité élevée** a été défini dans le cadre du projet comme regroupant les usagers **tués ou blessés hospitalisés**.

Les résultats sont étudiés à la fois en nombre de cas et en taux afin de distinguer le volume des accidents de la proportion de situations graves.

### 5. API REST

Une API REST a été développée avec FastAPI afin d'exposer les données de la table Accident stockées dans la base SQLite `baac_2020_2024.db`.

L'API permet de réaliser les quatre opérations CRUD :

- GET : consulter les accidents ;
- POST : créer un accident ;
- PUT : modifier un accident ;
- DELETE : supprimer un accident.

L'API est lancée depuis la racine du projet avec la commande :

```bash
uvicorn api.main:app --reload
```

La documentation interactive Swagger est accessible à l'adresse :

`http://127.0.0.1:8000/docs`

Les principaux endpoints disponibles sont :

| Méthode | Endpoint | Fonction |
|---|---|---|
| GET | `/` | Vérifier le fonctionnement de l'API |
| GET | `/accidents` | Récupérer les 10 premiers accidents |
| GET | `/accidents/{num_acc}` | Récupérer un accident précis |
| POST | `/accidents` | Créer un accident |
| PUT | `/accidents/{num_acc}` | Modifier un accident |
| DELETE | `/accidents/{num_acc}` | Supprimer un accident |

Les opérations CRUD ont été testées dans Swagger avec une donnée fictive `TEST_API_001`, ensuite supprimée de la base.

La gestion d'un accident inexistant a également été vérifiée avec une réponse HTTP 404.


### 6. Analyse exploratoire des données (EDA)

Une analyse exploratoire des données a été réalisée afin de mieux comprendre les caractéristiques des accidents corporels de la circulation en France entre 2020 et 2024.

Cette analyse a notamment porté sur :

- L'évolution annuelle, trimestrielle et mensuelle des accidents ;
- La répartition des accidents selon les périodes de l'année ;
- Les conditions de luminosité ;
- Les conditions atmosphériques ;
- La localisation géographique des accidents ;
- Les caractéristiques des usagers ;
- Les catégories de véhicules impliqués ;
- La gravité des accidents et les profils concernés.

L'objectif est d'identifier les principales tendances, de comparer les différentes catégories et de préparer les indicateurs et visualisations nécessaires à la restitution des résultats.

Les analyses ont été réalisées avec Python, notamment Pandas, dans le notebook :

`06_analyse_exploratoire.ipynb`

### 7. Veille technologique IA / Big Data

Une veille technologique a été réalisée afin d'identifier les principales évolutions dans les domaines de l'intelligence artificielle et de l'exploitation des données.

Quatre thématiques ont été étudiées :

1. **IA agentique (Agentic AI)** : systèmes d'intelligence artificielle capables de réaliser des tâches complexes en plusieurs étapes.
2. **AI-ready data** : importance de la qualité, de la préparation et de la gouvernance des données pour les applications d'intelligence artificielle.
3. **Real-time data et streaming** : traitement et exploitation des flux de données en temps réel.
4. **IA responsable** : transparence, fiabilité, protection des données et maîtrise des risques liés à l'utilisation de l'intelligence artificielle.

Cette veille permet de mieux comprendre les évolutions technologiques du métier de Data Analyst et leurs implications pour les projets de données.

Le travail est documenté dans le fichier :

`documentation/veille_IA_Big_Data.md`

### 8. Préparation des données pour Looker Studio

Les données BAAC nettoyées ont été préparées pour leur exploitation dans Google Looker Studio, outil retenu pour la création du tableau de bord interactif.

Des fichiers CSV spécifiques ont été créés dans le dossier :

`data/looker_studio/`

Les principales sources sont :

- `caract_2020_2024_clean.csv` ;
- `lieux_2020_2024_clean.csv` ;
- `vehicules_2020_2024_clean.csv` ;
- `usagers_2020_2024_clean.csv`.

Plusieurs opérations ont été réalisées :

- Adaptation des fichiers CSV pour leur importation ;
- Vérification des types de données ;
- Configuration des sources de données ;
- Création de champs calculés ;
- Définition des dimensions et des métriques ;
- Configuration des agrégations ;
- Préparation des relations entre les sources ;
- Vérification de la cohérence des indicateurs et prévention des doubles comptages.

Cette étape a permis de préparer les données nécessaires à la création des visualisations.

### 9. Création du tableau de bord Looker Studio

Un tableau de bord interactif intitulé **Accidents routiers en France — 2020-2024** a été réalisé avec Google Looker Studio.

Il comprend quatre pages thématiques.

#### Page 1 — Vue d'ensemble

Cette page présente les principaux indicateurs du projet :

| Indicateur | Valeur |
|---|---:|
| Nombre d'accidents | 268 788 |
| Nombre d'usagers | 612 181 |
| Nombre de tués | 16 379 |
| Nombre de blessés hospitalisés | 93 525 |

Ces KPI permettent d'obtenir une vision globale des accidents corporels étudiés sur la période 2020-2024.

#### Page 2 — Temporalité et circonstances

Cette page permet d'étudier l'évolution des accidents dans le temps et selon leurs circonstances.

Elle présente notamment :

- L'évolution trimestrielle des accidents par année ;
- L'évolution mensuelle des accidents par année ;
- La répartition selon les conditions de luminosité ;
- La répartition selon les conditions atmosphériques.

#### Page 3 — Profils et véhicules

Cette page est consacrée à l'analyse des caractéristiques des usagers et des véhicules impliqués dans les accidents.

Elle permet notamment d'étudier les différents profils d'usagers et les catégories de véhicules.

#### Page 4 — Géographie et gravité

Cette page présente la répartition géographique des accidents et les indicateurs liés à leur gravité.

Elle permet notamment :

- D'explorer la localisation des accidents ;
- De comparer les territoires ;
- D'étudier les différences de gravité ;
- De mettre en évidence les zones présentant des volumes importants d'accidents.

#### Objectifs du tableau de bord

Le tableau de bord permet de :

- Présenter les résultats de manière claire et synthétique ;
- Faciliter l'exploration interactive des données ;
- Comparer les années 2020 à 2024 ;
- Identifier les principales tendances ;
- Mettre en évidence les situations associées aux accidents graves ;
- Appuyer les conclusions de l'analyse.

**Google Looker Studio a été retenu en remplacement de Power BI, initialement envisagé pour le projet.**


```text
Projet_Final_Accidents_Routiers/
│
├── api/
│   └── main.py
│
├── data/
│   ├── raw/
│   │   ├── 2020/
│   │   ├── 2021/
│   │   ├── 2022/
│   │   ├── 2023/
│   │   └── 2024/
│   │
│   ├── interim/
│   │   ├── caract_2020_2024.csv
│   │   ├── lieux_2020_2024.csv
│   │   ├── usagers_2020_2024.csv
│   │   └── vehicules_2020_2024.csv
│   │
│   ├── processed/
│   |   ├── caract_2020_2024_clean.csv
│   |   ├── lieux_2020_2024_clean.csv
│   |   ├── usagers_2020_2024_clean.csv
│   |   └── vehicules_2020_2024_clean.csv
|   |
|   └── looker_studio/
|       ├── accidents_par_departement_annee.csv
│       ├── caract_2020_2024_clean.csv
│       ├── gravite_usagers_par_annee.csv
│       ├── lieux_2020_2024_clean.csv
|       ├── usagers_2020_2024_clean.csv
│       ├── usagers_sexe_par_annee.csv
│       ├── usagers_tranches_age_par_annee.csv
│       ├── vehicules_2020_2024_clean.csv 
|       └── vehicules_categories_par_annee.csv
├── documentation/
|
├── modelisation/
│   ├── MCD_BAAC_2020_2024.jpg
│   ├── MLD_BAAC_2020_2024.jpg
│   └── MCD_BAAC_2020_2024.loo
│
├── sql/
│   ├── 01_creation_tables.sql
│   ├── 02_controle_chargement.sql
│   └── 03_requetes_analyse.sql
│
├── 01_preparation_donnees_2020_2024.ipynb
├── 02_preparation_lieux_2020_2024.ipynb
├── 03_preparation_vehicules_2020_2024.ipynb
├── 04_preparation_usagers_2020_2024.ipynb
├── 05_controle_global_donnees.ipynb
├── 06_analyse_exploratoire.ipynb
│
├── baac_2020_2024.db
├── .gitignore
├── requirements.txt
└── README.md
```


## Technologies utilisées

Les principaux outils et technologies utilisés à ce stade sont :

- Python ;
- Pandas ;
- NumPy ;
- Jupyter Notebook ;
- VS Code ;
- Looping ;
- SQLite ;
- SQL ;
- DBeaver ;
- FastAPI ;
- Uvicorn ;
- Swagger ;
- Git / GitHub ;
- Google Looker Studio ;
- Google Maps (visualisation géographique).

Les bibliothèques de Machine Learning seront précisées après l'entraînement et l'évaluation des modèles. Power BI, initialement envisagé, a été remplacé par Looker Studio.

## Prochaines étapes

Les prochaines étapes prévues sont :

1. mettre à jour la documentation et publier les modifications sur GitHub ;
2. préparer les données pour le Machine Learning ;
3. entraîner, optimiser et comparer plusieurs modèles ;
4. évaluer les performances, les risques et les limites des modèles ;
5. préparer la présentation et la restitution finale ;
6. vérifier les livrables et clôturer le projet.

## Statut du projet

🚧 **Projet en cours de développement**

La préparation et le nettoyage des données, la modélisation relationnelle, la base SQLite, les analyses SQL, l'API REST, l'analyse exploratoire, la veille technologique et le tableau de bord Looker Studio sont réalisés.

**Étape actuelle :** mise à jour du README et préparation de la publication GitHub. **À venir :** Machine Learning, évaluation et restitution finale.