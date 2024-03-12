CREATE DATABASE DB_LigneCommande
use DB_LigneCommande

-- creation of the Produit table

DROP TABLE IF EXISTS  Produit
go 

CREATE TABLE Produit(
num_produit int NOT NULL PRIMARY KEY,
libele char(29),
pu_prod float NOT NULL,
qte_stock float NOT NULL,
s_min float,
s_max float
)

-- creation of Commande table

DROP TABLE IF EXISTS Commande
GO

CREATE TABLE Commande(
num_cmd int NOT NULL PRIMARY KEY,
date_cmd date NOT NULL
)

-- creation de la table des commande et leurs produits respectifs

DROP TABLE IF EXISTS  LigneCommande
GO

CREATE TABLE LigneCommande(
num_prod int NOT NULL,
num_cmd int NOT NULL,
qte_cmdee float NOT NULL,
CONSTRAINT fk_LigneCommande FOREIGN KEY (num_prod) REFERENCES dbo.Produit(num_produit),
CONSTRAINT fk_Commande FOREIGN KEY (num_cmd) REFERENCES dbo.Commande(num_cmd)
)
GO

-- insertion des observations dans les table
DELETE  FROM Produit 
INSERT INTO Produit VALUES
(1,'P1',150,20,5,25),
(2,'P2',100,10,3,15),
(3,'P3',120,5,2,4),
(4,'P4',100,15,5,25),
(5,'P5',110,13,4,30),
(6,'P6',120,12,4,25),
(7,'P7',100,4,1,10),
(8,'P8',120,5,2,10)

INSERT INTO Commande VALUES 
(1,'2019-11-10'),
(2,'2019-10-10'),
(3,'2018-12-13'),
(4,'2018-12-15'),
(5,'2018-12-13'),
(6,'2019-11-10'),
(7,'2019-10-10'),
(8,'2019-10-10')




INSERT INTO LigneCommande VALUES
(1,1,5),
(1,2,4),
(1,06,2),
(2,1,3),
(1,5,1),
(3,08,2),
(4,08,8),
(4,7,7),
(4,5,5),
(5,3,3),
(5,2,10),
(6,1,2),
(6,3,10),
(6,5,5),
(6,2,4),
(8,8,3),
(8,1,2)
GO


-- interogation de la base de donnees

-- affichage des produit

SELECT num_produit AS numero, libele, pu_prod , 'Etat' =
Case
When
qte_stock=0
then
'Non Disponible'
When qte_stock>s_min
then 'Disponible' ELSE
'à Commander' 
End
From produit 
GO

-- calcule le montant du stock numero 5

DECLARE @montant float
SET @montant = (SELECT sum(qte_cmdee*pu_prod) FROM DB_LigneCommande.dbo.Produit AS P INNER JOIN
DB_LigneCommande.dbo.LigneCommande AS L ON P.num_produit=L.num_prod WHERE num_cmd =5 )

if(@montant > 1000)
   print convert(char(10),@montant)+ 'est un commande speciale'
ELSE
   print convert(char(10),@montant)+ 'est un commande normal'
   
 
   
-- programmme supprimant le produit numero 8 de la commande 5 et met le stock a jour
   
   DELETE FROM DB_LigneCommande.dbo.LigneCommande WHERE num_prd = 8 AND num_cmd = 5
   GO
  UPDATE  DB_LigneCommande.dbo.Produit SET qte_stock=qte_stock+1 WHERE num_produit=8
  GO
  DECLARE @nombre int
  SET @nombre=(SELECT count(*) FROM DB_LigneCommande.dbo.LigneCommande WHERE num_cmd=5)
  if(@nombre=0)
  DELETE FROM DB_LigneCommande.dbo.Commande WHERE num_cmd=5
  GO
  
  -- requete retournant le nombre de produit existant
  
  DECLARE @nombre int
  SET @nombre=(SELECT count(*) FROM DB_LigneCommande.dbo.Produit)
  
  -- requete retournant le nombre total de commande
  
  DECLARE @total int
  SET @total=(SELECT count(*) FROM DB_LigneCommande.dbo.Commande)
  
  -- le nombre de produit commande par une commande donne
  
  DECLARE @nombre_produit int
  SET @nombre_produit =(SELECT count(*) FROM DB_LigneCommande.dbo.Commande WHERE num_cmd = 5)
  
  -- commande qui retourne le prix total d'une commande donnee
  
  DECLARE @prix float
  SET @prix = (SELECT sum(pu_prod*qte_cmdee) FROM DB_LigneCommande.dbo.Produit AS P,DB_LigneCommande.dbo.LigneCommande AS L
WHERE   P.num_produit=L.num_prd WHERE num_cmd = 1
  
  
  print 'le prix total de la commande:1 est'+ CAST (@prix,CHAR(10))
  
  -- une requete qui affiche l'etat d'une commande selon un nombre
  
  SELECT num_cmd, COUNT(*) as nbr_produit , 'etat'=
  CASE 
  WHEN  count(*)<3
  THEN 'petite'
  WHEN count (*) >3 and COUNT(*)<5
  THEN 
  'moyenne'
  ELSE 
  'grande'
  END 
  FROM LigneCommande lc GROUP BY num_cmd 
  



















