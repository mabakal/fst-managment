
# use  FstGestion ;

DROP TABLE IF EXISTS Etudiants ;
CREATE TABLE Etudiants (cne int AUTO_INCREMENT NOT NULL,
nom_etudant CHAR(40),
prenom_etudiant CHAR(40),
mail_etudiant CHAR(40)
PRIMARY KEY (cne) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Module ;
CREATE TABLE Module (id_module int AUTO_INCREMENT NOT NULL,
module CHAR(30),
semestre CHAR(40),
PRIMARY KEY (id_module) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Filiere ;
CREATE TABLE Filiere (id_filiere int AUTO_INCREMENT NOT NULL,
filiere CHAR(30),
coordinateur INT,
cycle CHAR(20),
PRIMARY KEY (id_filiere) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Enseignant ;
CREATE TABLE Enseignant (id_enseignant int AUTO_INCREMENT NOT NULL,
nom_enseignant CHAR(40),
prenom_enseignant CHAR(40),
mail_ensiegnant CHAR(39),
PRIMARY KEY (id_enseignant) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Departement ;
CREATE TABLE Departement (id_departement int AUTO_INCREMENT NOT NULL,
nom_departement CHAR(30),
chef_departement INT,
PRIMARY KEY (id_departement) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS SuisCours ;
CREATE TABLE SuisCours (id_cours INT AUTO_INCREMENT NOT NULL,
cne int ,
id_module INT NOT NULL,
date_ DATE,
valide CHAR,
PRIMARY KEY (cne,
 id_module) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Dispense ;
CREATE TABLE Dispense ( id_dispense INT AUTO_INCREMENT NOT NULL, 
id_module int ,
id_enseignant INT NOT NULL,
PRIMARY KEY (id_module,
 id_enseignant) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Travail ;
CREATE TABLE Travail (id_travail INT AUTO_INCREMENT NOT NULL,
id_enseignant int ,
id_departement INT NOT NULL,
poste CHAR,
PRIMARY KEY (id_enseignant,
 id_departement) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Inscrit ;
CREATE TABLE Inscrit (numero INT AUTO_INCREMENT NOT NULL,
cne int ,
id_filiere INT NOT NULL,
PRIMARY KEY (cne,
 id_filiere) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS Propose ;
CREATE TABLE Propose (id_propose INT,
id_filiere int AUTO_INCREMENT NOT NULL,
id_departement INT NOT NULL,
annee CHAR,
PRIMARY KEY (id_filiere,
 id_departement) ) ENGINE=InnoDB;

ALTER TABLE SuisCours ADD CONSTRAINT FK_SuisCours_cne FOREIGN KEY (cne) REFERENCES Etudiants (cne);

ALTER TABLE SuisCours ADD CONSTRAINT FK_SuisCours_id_module FOREIGN KEY (id_module) REFERENCES Module (id_module);
ALTER TABLE Dispense ADD CONSTRAINT FK_Dispense_id_module FOREIGN KEY (id_module) REFERENCES Module (id_module);
ALTER TABLE Dispense ADD CONSTRAINT FK_Dispense_id_enseignant FOREIGN KEY (id_enseignant) REFERENCES Enseignant (id_enseignant);
ALTER TABLE Travail ADD CONSTRAINT FK_Travail_id_enseignant FOREIGN KEY (id_enseignant) REFERENCES Enseignant (id_enseignant);
ALTER TABLE Travail ADD CONSTRAINT FK_Travail_id_departement FOREIGN KEY (id_departement) REFERENCES Departement (id_departement);
ALTER TABLE Inscrit ADD CONSTRAINT FK_Inscrit_cne FOREIGN KEY (cne) REFERENCES Etudiants (cne);
ALTER TABLE Inscrit ADD CONSTRAINT FK_Inscrit_id_filiere FOREIGN KEY (id_filiere) REFERENCES Filiere (id_filiere);
ALTER TABLE Propose ADD CONSTRAINT FK_Propose_id_filiere FOREIGN KEY (id_filiere) REFERENCES Filiere (id_filiere);
ALTER TABLE Propose ADD CONSTRAINT FK_Propose_id_departement FOREIGN KEY (id_departement) REFERENCES Departement (id_departement);

-- Les insertion

-- les donnees dans la base des etudiants

INSERT INTO Etudiants VALUES
("BADJO","Koffi","badjokoffi1@gmail.com"),
("AAAA","amma","amabolika@gmail.com"),
("VALORIE","value","voloricala@gmail.com"),
("Sultan","omina","alirga","aligate@gmail.com"),
("VIBORE","Vibolirita","vibori@gmail.com"),
("SURIZANE","omicalino","alegato@gmail.com")
("SALIFOU","Mohamed","salifoumohamed@gmail.com"),
("SOULEYMAN","Salim","Souleymansalim@gmail.com"),
("Fatou","farida","fatoufarida@gmail.com"),
("Basso","tchikpi","Bassotchikpi@gmail.com"),
("Olivier","lamber","Olivierlamber@gmail.com"),
("ATTISSO","Bernard","attissobernard@gmail.com"),
("SULTANIO","Morino","sultanomorino@gmail.com")


--insertion dans module
INSERT INTO Module VALUES
("Gestion de projet",1),
("System Information",1),
("Reseau Informatique",1),
("Initiation au base de donnees",1),
("Programmation Java",1),
("Programmation Web",1),
("Analyse 1",1),
("Analyse 2",1),
("Electricite",1),
("Mecanique",1),
("Atomistique",1),
("Algebre 1",2)
("Algebre 2",2),
("Electronique ",2),
("Reactivite chimique",2),
("Informatique 1", 2)


-- insertion dans la base Filiere

