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

## Structure du projet

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
│   └── processed/
│       ├── caract_2020_2024_clean.csv
│       ├── lieux_2020_2024_clean.csv
│       ├── usagers_2020_2024_clean.csv
│       └── vehicules_2020_2024_clean.csv
│
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
- Git / GitHub.

D'autres technologies seront ajoutées au fur et à mesure de l'avancement du projet, notamment Power BI et les bibliothèques nécessaires au Machine Learning.

## Prochaines étapes

Les prochaines étapes prévues sont :

1. réaliser l'analyse exploratoire des données (EDA) ;
2. réaliser une veille IA / Big Data ;
3. définir les indicateurs et préparer les données pour Power BI ;
4. construire le tableau de bord Power BI ;
5. préparer les données pour le Machine Learning ;
6. entraîner, optimiser et comparer plusieurs modèles ;
7. évaluer les performances, risques et limites des modèles ;
8. préparer la présentation et la restitution finale.

## Statut du projet

🚧 **Projet en cours de développement**

La préparation et le nettoyage des données, la modélisation relationnelle, la création et le chargement de la base SQLite, les principales analyses SQL ainsi que le développement et le test de l'API REST sont terminés.

La prochaine étape concerne l'analyse exploratoire des données (EDA).