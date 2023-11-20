-- Active: 1700401443805@@127.0.0.1@3306@MyResources

-- Création de de la base de données

CREATE DATABASE MyResources;

-- Création des tables

CREATE TABLE utilisateurs (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom_utilisateur VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

CREATE TABLE squads (
    id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_squad VARCHAR(30) NOT NULL,
    leader_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (leader_id) REFERENCES utilisateurs (id)
) ENGINE = InnoDB;

CREATE TABLE projets (
    id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_projet VARCHAR(30) NOT NULL,
    description VARCHAR(30) NOT NULL,
    date_debut DATE,
    date_fin DATE,
    squad_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (squad_id) REFERENCES squads (id)
) ENGINE = InnoDB;

CREATE TABLE ressources (
    id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_ressource VARCHAR(30) NOT NULL,
    description VARCHAR(30) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE categories (
    id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(30) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE souscategories (
    id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_souscategorie VARCHAR(30) NOT NULL,
    categorie_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (categorie_id) REFERENCES categories (id)
) ENGINE = InnoDB;

ALTER TABLE utilisateurs
ADD COLUMN squad_id SMALLINT UNSIGNED,
ADD FOREIGN KEY (squad_id) REFERENCES squads(id);

CREATE TABLE projet_ressources (
    projet_id SMALLINT UNSIGNED NOT NULL,
    ressource_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (projet_id, ressource_id),
    FOREIGN KEY (projet_id) REFERENCES projets (id),
    FOREIGN KEY (ressource_id) REFERENCES ressources (id)
) ENGINE = InnoDB;

ALTER TABLE ressources
ADD COLUMN souscategorie_id SMALLINT UNSIGNED,
ADD FOREIGN KEY (souscategorie_id) REFERENCES souscategories(id);

-- En tant qu'administrateur système, je veux créer de nouveaux utilisateurs dans la base de données pour maintenir une liste actualisée des membres de l'équipe.

-- Créer une procédure stockée pour ajouter un nouvel utilisateur

DELIMITER //

CREATE PROCEDURE AddUser(
    IN p_nom_utilisateur VARCHAR(30),
    IN p_email VARCHAR(50)
)
BEGIN
    INSERT INTO utilisateurs (nom_utilisateur, email)
    VALUES (p_nom_utilisateur, p_email);
END //

DELIMITER ;

-- Appel du procédure

CALL AddUser('Abdellah Bardich', 'abdellahbardichwork@gmail.com');

CALL AddUser('Otman Kharbouch', 'otmankharbouch813@gmail.com');

CALL AddUser('Rabia Ait imghi', 'rabiaaitimghi7@gmail.com');

CALL AddUser('Anass Drissi', 'anasdrissi77@gmail.com');

CALL AddUser('Hamza Ezzahar Idrissi', 'hamza.ezzaharidrissi1@gmail.com');

CALL AddUser('Khalid Znnouhi', 'khalidzennouhi08@gmail.com');

CALL AddUser('Abdeljabar Ait Ayoub', 'abdeljabarayoubi@gmail.com');

CALL AddUser('Mohamed Amine Baih', 'baihmohamedamine@gmail.com');

CALL AddUser('Anass Ait Ouaguerd', 'aitouageurdanass@gmail.com');

CALL AddUser('Abdeljalil El Filaly', 'elfilalyabdeljalil@gmail.com');

CALL AddUser('Aicha Ettabet', 'aicha70tabite@gmail.com');

CALL AddUser('Khalid El Mati', 'khalidgara8@gmail.com');

CALL AddUser('Latifa Chakir', 'chakirlatifa2001@gmail.com');

CALL AddUser('Nabil El Hakimi', 'nabilelhakimi2023@gmail.com');

CALL AddUser('Mohammed-Amine Benmade', 'aminebenmade1999@gmail.com');

CALL AddUser('Niama El Hrychy', 'niamaelhry@gmail.com');

CALL AddUser('Mbarek El Adraoui', 'elaadraouimbarek2023@gmail.com');

CALL AddUser('Zouhair Zerzkhane', 'zerzkhanezouhair@gmail.com');

CALL AddUser('Omaima El baz', 'elbazouma70@gmail.com');

CALL AddUser('Khalid Haiddou', 'khalid.haiddou01@gmail.com');

CALL AddUser('Soumaya Ait Lmqaddam', 'soumiatinghir119@gmail.com');

CALL AddUser('Youness Erbai', 'younesserbai@gmail.com');

-- En tant que leader de squad, je souhaite créer un nouveau squad, spécifiant le nom et ajoutant des membres à ce squad,
-- pour former rapidement des équipes dédiées à des projets spécifiques.

-- Création des squads
INSERT INTO squads (nom_squad, leader_id)
VALUES
    ('Brogrammers', 12),
    ('ProDevs', 14),
    ('CODEZILLA', 4),
    ('cell13', 1),
    ('Alpha', 3);

-- Ajouter les membres

UPDATE utilisateurs
SET squad_id = 4
WHERE
    id = 5
    OR id = 1
    OR id = 11
    OR id = 22;

UPDATE utilisateurs
SET squad_id = 5
WHERE
    id = 3
    OR id = 10
    OR id = 19
    OR id = 20;

UPDATE utilisateurs
SET squad_id = 1
WHERE
    id = 12
    OR id = 7
    OR id = 21
    OR id = 17;

UPDATE utilisateurs
SET squad_id = 2
WHERE
    id = 14
    OR id = 2
    OR id = 16
    OR id = 6
    OR id = 18;

UPDATE utilisateurs
SET squad_id = 3
WHERE
    id = 4
    OR id = 8
    OR id = 15
    OR id = 13
    OR id = 9;

-- En tant que chef de projet, je veux créer un nouveau projet en fournissant des détails tels que le nom, la description et les dates,
-- pour définir clairement les paramètres de chaque projet.

INSERT INTO projets (
    nom_projet,
    description,
    date_debut,
    date_fin,
    squad_id
)
VALUES (
    'Projet 1',
    'Lorem ipsum',
    '2023-11-20',
    '2023-12-31',
    1
);

DELIMITER //

CREATE PROCEDURE CreateNewProject(
    IN p_nom_projet VARCHAR(30),
    IN p_description VARCHAR(30),
    IN p_date_debut DATE,
    IN p_date_fin DATE,
    IN p_squad_id SMALLINT UNSIGNED
)
BEGIN
    INSERT INTO projets (nom_projet, description, date_debut, date_fin, squad_id)
    VALUES (p_nom_projet, p_description, p_date_debut, p_date_fin, p_squad_id);
END //

DELIMITER ;

CALL CreateNewProject('Projet 2', 'Lorem ipsum', '2023-01-01', '2023-12-31', 2);

-- En tant que membre de squad, je veux voir la liste des projets pour lesquels mon squad est responsable
-- pour comprendre les projets actuels et suivre les responsabilités.

DELIMITER //

CREATE PROCEDURE ListSquadProjects(
    IN p_squad_id SMALLINT UNSIGNED
)
BEGIN
    SELECT * FROM projets
    WHERE squad_id = p_squad_id;
END //

DELIMITER ;

CALL ListSquadProjects(2);

-- En tant que responsable des ressources, je veux ajouter une nouvelle ressource en spécifiant son nom, sa catégorie,
-- sa sous-catégorie et son association éventuelle à un squad ou à un projet, pour gérer efficacement les ressources disponibles.

INSERT INTO ressources (nom_ressource, description)
VALUES ('Nom de la Ressource', 'Description de la Ressource');

-- Associer avec un projet
INSERT INTO projet_ressources (projet_id, ressource_id)
VALUES (1, LAST_INSERT_ID());

-- En tant que développeur Fullstack, je veux pouvoir mettre à jour les détails d'un utilisateur, d'un squad,
-- d'un projet ou d'une ressource existante pour ajuster les informations en fonction des évolutions.

UPDATE utilisateurs
SET nom_utilisateur = 'Nouveau nom d utilisateur'
WHERE id = 1;

UPDATE squads
SET nom_squad = 'Nouveau nom de squad'
WHERE id = 2;

UPDATE projets
SET nom_projet = 'Nouveau nom de projet'
WHERE id = 3;

UPDATE ressources
SET nom_ressource = 'Nouveau nom de ressource'
WHERE id = 4;

DELIMITER //
CREATE PROCEDURE updateProjectDetails (
    IN projectId SMALLINT UNSIGNED, 
    IN newProjectName VARCHAR(30)
    )
BEGIN
    UPDATE projets
    SET nom_projet = newProjectName
    WHERE id = projectId;
END //

DELIMITER ;

-- En tant que responsable des catégories et sous-catégories, je souhaite créer de nouvelles catégories et sous-catégories
-- pour classer les ressources et organiser efficacement la base de données.
DELIMITER //
CREATE PROCEDURE createCategory (IN categoryName VARCHAR(30))
BEGIN
    INSERT INTO categories (nom_categorie)
    VALUES (categoryName);
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE createSubcategory (
    IN subcategoryName VARCHAR(30), 
    IN categoryId SMALLINT UNSIGNED
    )
BEGIN
    INSERT INTO souscategories (nom_souscategorie, categorie_id)
    VALUES (subcategoryName, categoryId);
END //

DELIMITER ;

-- Afficher les ressources associées à un projet particulier :
SELECT *
FROM projet_ressources
WHERE projet_id = 1;

-- Afficher les noms des membres de chaque squad
SELECT s.nom_squad, u.nom_utilisateur
FROM squads s, utilisateurs u
WHERE s.id = u.squad_id
ORDER BY s.nom_squad, u.nom_utilisateur;

-- Affichage des squads et du nombre de membres dans chaque squad, trié par nombre de membres décroissant :
SELECT s.nom_squad, COUNT(u.id) AS nombre_de_membres
FROM squads s
LEFT JOIN utilisateurs u ON s.id = u.squad_id
GROUP BY s.nom_squad
ORDER BY nombre_de_membres DESC;

