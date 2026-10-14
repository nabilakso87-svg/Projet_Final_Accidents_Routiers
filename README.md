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


### 10. Machine Learning — Prédiction de la gravité des accidents

Une démarche de Machine Learning supervisé a été mise en œuvre afin de prédire si un accident corporel présente une gravité élevée, définie par la présence d'au moins un usager tué ou blessé hospitalisé.

L'analyse a été réalisée dans le notebook `07_machine_learning_gravite.ipynb` à partir des données BAAC 2020-2024.

#### Préparation des données

- Construction d'une variable cible binaire : accident non grave (0) ou grave (1) ;
- Sélection de 14 variables explicatives relatives aux circonstances, aux conditions de circulation et aux infrastructures routières ;
- Séparation des données en jeux d'apprentissage, de validation et de test ;
- Prétraitement des variables numériques et catégorielles avec des pipelines Scikit-learn ;
- Contrôle de l'absence de chevauchement entre les jeux de données.

#### Entraînement et comparaison des modèles

Deux algorithmes de classification ont été entraînés et comparés : la régression logistique et le Random Forest.

| Modèle | Accuracy | Précision | Rappel | F1-score | ROC-AUC |
|---|---:|---:|---:|---:|---:|
| Régression logistique | 72,54 % | 66,64 % | 46,51 % | 54,78 % | 75,23 % |
| Random Forest (seuil 0,50) | 71,90 % | 60,28 % | 62,87 % | 61,55 % | 76,41 % |


Les premiers résultats ont montré que le Random Forest présentait un meilleur rappel et un meilleur F1-score pour la classe des accidents graves que la régression logistique.

Une optimisation complémentaire des hyperparamètres a ensuite été réalisée avec GridSearchCV afin d'améliorer les performances du modèle.



#### Validation et optimisation

Le Random Forest a été optimisé avec GridSearchCV, en évaluant 8 configurations d'hyperparamètres par validation croisée à 3 plis.

Les hyperparamètres retenus sont :

- `n_estimators = 150`
- `max_depth = 20`
- `min_samples_leaf = 5`

Un seuil de classification de 0,45 a été conservé pour favoriser la détection des accidents graves.

Le modèle optimisé a ensuite été entraîné et évalué sur le jeu de test.


#### Performances finales sur le jeu de test

Le Random Forest optimisé avec GridSearchCV, associé à un seuil de classification de 0,45, a obtenu les performances suivantes :

| Indicateur | Résultat |
|---|---:|
| Accuracy | 69,44 % |
| Précision — classe grave | 55,68 % |
| Rappel — classe grave | 71,27 % |
| F1-score — classe grave | 62,52 % |
| ROC-AUC | 76,54 % |

Sur les 19 228 accidents graves du jeu de test, le modèle en identifie correctement 13 704.

En revanche, 5 524 accidents graves ne sont pas détectés, soit un taux de non-détection de 28,73 %.

Ces résultats montrent que le modèle optimisé privilégie la détection des accidents graves, tout en conservant des limites importantes liées aux erreurs de classification.



#### Interprétation et limites

Le Random Forest optimisé permet d'identifier 71,27 % des accidents graves du jeu de test.

Cependant, 28,73 % des accidents graves ne sont pas détectés. Le modèle génère également des fausses alertes, ce qui limite son utilisation pour des décisions opérationnelles.

Les résultats dépendent de la qualité et de la représentativité des données BAAC 2020-2024.

Les variables explicatives peuvent présenter des biais liés à la collecte des données, aux caractéristiques des territoires ou aux conditions de circulation.

Les prédictions mettent en évidence des associations statistiques et ne permettent pas d'établir des relations causales.

Le modèle constitue donc un outil d'analyse prédictive exploratoire. Son utilisation opérationnelle nécessiterait des validations complémentaires.


#### Sauvegarde du modèle

Le Random Forest optimisé avec GridSearchCV a été retenu comme modèle final du projet.

Le pipeline entraîné, le seuil de classification (0,45) et la liste des variables explicatives ont été sauvegardés dans `modeles/random_forest_optimise.joblib`.

Le rechargement du modèle a été vérifié avec succès. Les probabilités et les prédictions obtenues après rechargement sont identiques à celles du modèle avant sauvegarde.

Le fichier `.joblib` est exclu du dépôt GitHub via `.gitignore`.


### 11. Présentation finale du projet

Une présentation de synthèse du projet BAAC 2020-2024 a été réalisée afin de restituer les principales étapes et les résultats de l'analyse.

Elle présente notamment :

- Le contexte, les objectifs et la problématique du projet ;
- La collecte, le nettoyage et la préparation des données ;
- La modélisation relationnelle et les analyses SQL ;
- L'analyse exploratoire et les visualisations Looker Studio ;
- La démarche de Machine Learning et les performances du modèle retenu ;
- Les principales conclusions, limites et perspectives du projet.

Cette présentation constitue le support de restitution finale du projet.

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
├── modeles/
│   └── random_forest_optimise.joblib (non suivi par Git)
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
├── 07_machine_learning_gravite.ipynb
|
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
- Google Maps (visualisation géographique);
- Scikit-learn (prétraitement, classification et évaluation) ;
- Matplotlib (visualisation des résultats) ;
- Joblib (sauvegarde et rechargement du modèle).

Power BI, initialement envisagé, a été remplacé par Looker Studio.


## Prochaines étapes

Les principales étapes techniques et la présentation finale du projet sont réalisées.

Les dernières actions concernent :

1. Vérifier la cohérence et la reproductibilité des livrables.
2. Finaliser la mise à jour du dépôt GitHub.
3. Effectuer les derniers contrôles avant la clôture définitive du projet.


## Statut du projet

**Projet finalisé — Dernières vérifications avant clôture**

Les principales phases du projet sont terminées :

- Préparation, nettoyage et contrôle des données BAAC 2020-2024 ;
- Modélisation relationnelle et création de la base SQLite ;
- Analyses SQL et développement de l'API REST ;
- Analyse exploratoire des données ;
- Veille technologique IA / Big Data ;
- Création du tableau de bord interactif Looker Studio ;
- Entraînement, comparaison et optimisation des modèles de Machine Learning ;
- Évaluation et sauvegarde du Random Forest optimisé ;
- Documentation des résultats et des limites ;
- Réalisation de la présentation finale du projet.

**Étape actuelle :** vérification finale des livrables et synchronisation du dépôt GitHub.
