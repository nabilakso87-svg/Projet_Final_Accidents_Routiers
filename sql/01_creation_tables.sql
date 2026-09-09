-- Activation des clés étrangères
PRAGMA foreign_keys = ON;

-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS Usager;
DROP TABLE IF EXISTS Vehicule;
DROP TABLE IF EXISTS Lieu;
DROP TABLE IF EXISTS Accident;
-- Création de la table Accident
CREATE TABLE Accident (
    Num_Acc TEXT PRIMARY KEY,
    jour INTEGER,
    mois INTEGER,
    annee INTEGER,
    heure_minute TEXT,
    luminosite INTEGER,
    departement TEXT,
    commune TEXT,
    agglomeration INTEGER,
    intersection INTEGER,
    conditions_atmospheriques INTEGER,
    type_collision INTEGER,
    adresse TEXT,
    latitude REAL,
    longitude REAL,
    date_accident TEXT
);

-- Création de la table Lieu
CREATE TABLE Lieu (
    id_lieu INTEGER PRIMARY KEY AUTOINCREMENT,
    Num_Acc TEXT NOT NULL,
    categorie_route INTEGER,
    regime_circulation INTEGER,
    nombre_voies INTEGER,
    profil_route INTEGER,
    trace_route INTEGER,
    etat_surface INTEGER,
    situation_accident INTEGER,
    vitesse_max_autorisee INTEGER,
    FOREIGN KEY (Num_Acc) REFERENCES Accident(Num_Acc)
);

-- Création de la table Vehicule
CREATE TABLE Vehicule (
    id_vehicule TEXT PRIMARY KEY,
    Num_Acc TEXT NOT NULL,
    categorie_vehicule INTEGER,
    obstacle_fixe INTEGER,
    obstacle_mobile INTEGER,
    point_choc_initial INTEGER,
    manoeuvre_principale INTEGER,
    motorisation INTEGER,
    FOREIGN KEY (Num_Acc) REFERENCES Accident(Num_Acc)
);

-- Création de la table Usager
CREATE TABLE Usager (
    id_usager_projet INTEGER PRIMARY KEY,
    id_usager TEXT,
    id_vehicule TEXT NOT NULL,
    place_usager INTEGER,
    categorie_usager INTEGER,
    gravite INTEGER,
    sexe INTEGER,
    annee_naissance INTEGER,
    motif_trajet INTEGER,
    equipement_securite INTEGER,
    FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
);

