# Imports

# FastAPI = framework Python utilisé pour créer notre API REST
# HTTPException = permet de retourner une erreur HTTP contrôlée
# Exemple : erreur 404 lorsqu'un accident demandé n'existe pas
from fastapi import FastAPI, HTTPException

# sqlite3 = permet à Python de communiquer avec notre base SQLite
import sqlite3

# BaseModel = permet de définir la structure des données reçues par l'API
from pydantic import BaseModel


# 1. Modèle de données

# Ce modèle définit la structure d'un accident reçu par l'API.
# Il est utilisé notamment pour POST et PUT.
class Accident(BaseModel):
    Num_Acc: str
    jour: int
    mois: int
    annee: int
    heure_minute: str
    luminosite: int | None = None
    departement: str
    commune: str
    agglomeration: int | None = None
    intersection: int | None = None
    conditions_atmospheriques: int | None = None
    type_collision: int | None = None
    adresse: str | None = None
    latitude: float | None = None
    longitude: float | None = None
    date_accident: str


# 2. Création de l'application FastAPI

# app contient notre application API
app = FastAPI()


# 3. Route d'accueil

# GET = Read (Lire)
# Cette route permet simplement de vérifier que l'API fonctionne.
# Elle ne modifie pas la base de données.
@app.get("/")
async def root():
    return {"message": "API BAAC 2020-2024"}


# 4. Lire les accidents

# GET = Read (Lire)
# GET permet de récupérer des données existantes
# sans modifier la base de données.


# Récupérer les 10 premiers accidents
@app.get("/accidents")
async def get_accidents():

    # Ouverture de la connexion avec la base SQLite
    connexion = sqlite3.connect("baac_2020_2024.db")

    # Permet de récupérer les résultats avec les noms des colonnes
    connexion.row_factory = sqlite3.Row

    # Le curseur permet d'exécuter les requêtes SQL
    curseur = connexion.cursor()

    # Sélection des 10 premiers accidents
    curseur.execute("SELECT * FROM Accident LIMIT 10")

    # fetchall() récupère toutes les lignes retournées par la requête
    accidents = curseur.fetchall()

    # Fermeture de la connexion
    connexion.close()

    # Transformation des lignes SQLite en dictionnaires
    # pour obtenir un JSON lisible dans l'API
    return {"accidents": [dict(accident) for accident in accidents]}


# Récupérer un accident précis grâce à son Num_Acc
# {num_acc} est un paramètre de chemin.
# Exemple :
# GET /accidents/TEST_API_001
@app.get("/accidents/{num_acc}")
async def get_accident(num_acc: str):

    # Connexion à la base SQLite
    connexion = sqlite3.connect("baac_2020_2024.db")

    # Permet de conserver les noms des colonnes
    connexion.row_factory = sqlite3.Row

    # Création du curseur SQL
    curseur = connexion.cursor()

    # Recherche de l'accident correspondant au Num_Acc reçu dans l'URL
    curseur.execute(
        "SELECT * FROM Accident WHERE Num_Acc = ?",
        (num_acc,)
    )

    # fetchone() récupère une seule ligne
    accident = curseur.fetchone()

    # Fermeture de la connexion
    connexion.close()

    # Vérification que l'accident existe dans la base de données
    # Si fetchone() n'a trouvé aucune ligne, accident vaut None
    if accident is None:

        # HTTPException permet d'envoyer une erreur HTTP au client
        # 404 = Not Found = la ressource demandée n'existe pas
        raise HTTPException(
            status_code=404,
            detail="Accident non trouvé"
        )

    # Si l'accident existe, il est transformé en dictionnaire
    # afin d'être retourné au format JSON par l'API
    return {"accident": dict(accident)}

# 5. Créer un accident

# POST = Create (Créer)
# POST permet d'ajouter une nouvelle donnée dans la base de données.
@app.post("/accidents")
async def create_accident(accident: Accident):

    # Connexion à la base SQLite
    connexion = sqlite3.connect("baac_2020_2024.db")

    # Création du curseur SQL
    curseur = connexion.cursor()

    # INSERT INTO permet d'ajouter une nouvelle ligne
    # dans la table Accident.
    curseur.execute(
        """
        INSERT INTO Accident (
            Num_Acc,
            jour,
            mois,
            annee,
            heure_minute,
            luminosite,
            departement,
            commune,
            agglomeration,
            intersection,
            conditions_atmospheriques,
            type_collision,
            adresse,
            latitude,
            longitude,
            date_accident
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """,
        (
            accident.Num_Acc,
            accident.jour,
            accident.mois,
            accident.annee,
            accident.heure_minute,
            accident.luminosite,
            accident.departement,
            accident.commune,
            accident.agglomeration,
            accident.intersection,
            accident.conditions_atmospheriques,
            accident.type_collision,
            accident.adresse,
            accident.latitude,
            accident.longitude,
            accident.date_accident
        )
    )

    # commit() valide réellement l'ajout dans la base
    connexion.commit()

    # Fermeture de la connexion
    connexion.close()

    # Réponse retournée au client
    return {"message": "Accident créé avec succès"}


# 6. Modifier un accident

# PUT = Update (Modifier)
# PUT permet de modifier les données d'un accident existant.
# Le Num_Acc indiqué dans l'URL permet de choisir
# précisément l'accident à modifier.
@app.put("/accidents/{num_acc}")
async def update_accident(num_acc: str, accident: Accident):

    # Connexion à la base SQLite
    connexion = sqlite3.connect("baac_2020_2024.db")

    # Création du curseur SQL
    curseur = connexion.cursor()

    # UPDATE permet de modifier une ligne existante.
    # WHERE Num_Acc = ? permet de modifier uniquement
    # l'accident correspondant au numéro reçu dans l'URL.
    curseur.execute(
        """
        UPDATE Accident
        SET
            jour = ?,
            mois = ?,
            annee = ?,
            heure_minute = ?,
            luminosite = ?,
            departement = ?,
            commune = ?,
            agglomeration = ?,
            intersection = ?,
            conditions_atmospheriques = ?,
            type_collision = ?,
            adresse = ?,
            latitude = ?,
            longitude = ?,
            date_accident = ?
        WHERE Num_Acc = ?
        """,
        (
            accident.jour,
            accident.mois,
            accident.annee,
            accident.heure_minute,
            accident.luminosite,
            accident.departement,
            accident.commune,
            accident.agglomeration,
            accident.intersection,
            accident.conditions_atmospheriques,
            accident.type_collision,
            accident.adresse,
            accident.latitude,
            accident.longitude,
            accident.date_accident,
            num_acc
        )
    )

    # commit() valide réellement la modification
    connexion.commit()

    # Fermeture de la connexion
    connexion.close()

    # Réponse retournée au client
    return {"message": "Accident modifié avec succès"}


# 7. Supprimer un accident

# DELETE = Delete (Supprimer)
# DELETE permet de supprimer une donnée existante de la base.
# On utilisera cette route à la fin pour supprimer TEST_API_001.
@app.delete("/accidents/{num_acc}")
async def delete_accident(num_acc: str):

    # Connexion à la base SQLite
    connexion = sqlite3.connect("baac_2020_2024.db")

    # Création du curseur SQL
    curseur = connexion.cursor()

    # DELETE FROM supprime la ligne correspondant
    # au Num_Acc reçu dans l'URL.
    curseur.execute(
        "DELETE FROM Accident WHERE Num_Acc = ?",
        (num_acc,)
    )

    # commit() valide réellement la suppression
    connexion.commit()

    # Fermeture de la connexion
    connexion.close()

    # Réponse retournée au client
    return {"message": "Accident supprimé avec succès"}

# 8. Mémo pour lancer et tester l'API

# Pour lancer l'API depuis la racine du projet dans le terminal Bash :
# uvicorn api.main:app --reload

# Explication de la commande :
# uvicorn = serveur web qui exécute notre API
# api.main = fichier main.py situé dans le dossier api
# app = variable contenant notre application FastAPI
# --reload = recharge automatiquement le serveur
# après une modification du code

# Une fois le serveur lancé :
# http://127.0.0.1:8000/      -> route d'accueil
# http://127.0.0.1:8000/docs  -> documentation Swagger

# Swagger permet de visualiser et tester
# les endpoints de l'API directement dans le navigateur.


# Rappel CRUD :
# Create = POST   = créer
# Read   = GET    = lire
# Update = PUT    = modifier
# Delete = DELETE = supprimer