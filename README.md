# Analyse des accidents routiers en France – BAAC 2020-2024

## Présentation du projet

Ce projet est réalisé dans le cadre de ma formation Data Analyst.

Il porte sur l'analyse des accidents corporels de la circulation en France entre 2020 et 2024 à partir des données officielles BAAC (Bulletins d'Analyse des Accidents Corporels).

L'objectif est d'exploiter ces données afin d'identifier les principaux facteurs associés à la gravité des accidents et de mettre en évidence des situations et profils à risque.

## Problématique

**Quels facteurs sont associés à la gravité des accidents corporels de la circulation en France entre 2020 et 2024, et comment l'analyse des données peut-elle permettre d'identifier des situations et profils à risque ?**

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

La première phase du projet a permis de préparer et de fiabiliser les données BAAC avant leur exploitation.

Les principales étapes réalisées sont :

- collecte et organisation des fichiers BAAC de 2020 à 2024 ;
- contrôle de la structure des fichiers annuels ;
- harmonisation des colonnes et des types de données entre les différentes années ;
- consolidation des données 2020 à 2024 par catégorie ;
- analyse des valeurs manquantes, doublons et valeurs incohérentes ;
- traitement des données en tenant compte de la documentation officielle BAAC ;
- sélection et renommage des variables utiles ;
- création des fichiers nettoyés pour Caractéristiques, Lieux, Véhicules et Usagers ;
- contrôle des identifiants et des relations entre les quatre catégories de données ;
- validation de la cohérence globale des données avant la modélisation relationnelle.  
## Structure du projet

```text
Projet_Final_Accidents_Routiers/
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
├── 01_preparation_donnees_2020_2024.ipynb
├── 02_preparation_lieux_2020_2024.ipynb
├── 03_preparation_vehicules_2020_2024.ipynb
├── 04_preparation_usagers_2020_2024.ipynb
├── 05_controle_global_donnees.ipynb
│
├── .gitignore
├── requirements.txt
└── README.md
``` 
## Technologies utilisées

À ce stade du projet, les principaux outils et technologies utilisés sont :

- Python
- Pandas
- NumPy
- Jupyter Notebook
- VS Code
- Git / GitHub

D'autres technologies seront ajoutées au fur et à mesure de l'avancement du projet, notamment SQL, Power BI et des outils de Machine Learning.

## Prochaines étapes

Les prochaines étapes prévues sont :

1. concevoir le modèle relationnel des données ;
2. créer et alimenter la base de données SQL ;
3. réaliser les analyses SQL ;
4. développer et tester une API REST ;
5. réaliser l'analyse exploratoire des données ;
6. réaliser une veille IA / Big Data ;
7. définir les indicateurs et construire le tableau de bord Power BI ;
8. préparer les données pour le Machine Learning ;
9. entraîner, optimiser et comparer plusieurs modèles ;
10. analyser les performances, risques et limites des modèles ;
11. préparer la restitution finale du projet.

## Statut du projet

🚧 **Projet en cours de développement**

La préparation, le nettoyage et le contrôle global des données BAAC 2020-2024 sont terminés.

La prochaine étape concerne la modélisation relationnelle des données avant la création de la base SQL.
  