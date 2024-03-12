USE DB_LigneCommande

-- UTILISATION DE PROCEDURE STOCKEE
DROP  PROCEDURE IF EXISTS  prod_list 
CREATE  PROCEDURE prod_list 
AS 
SELECT num_produit, libele FROM Produit

EXEC DB_LigneCommande.dbo.prod_list 

-- afficher le nombre de produit par commande
DROP PROC IF EXISTS afficher 
GO 
CREATE  PROC  afficher
AS 
SELECT num_cmd, COUNT(*) AS nombre_produit
FROM DB_LigneCommande.dbo.LigneCommande GROUP BY num_cmd 

EXEC afficher 


-- procedure avec parametre 
-- procedure qui affiche le nombre de commande effectue entre deux date 

CREATE  PROC affiche_prod(@date1 DATE ,@date2 DATE)
AS 
SELECT num_cmd, date_cmd FROM DB_LigneCommande.dbo.Commande c WHERE date_cmd BETWEEN @date1 AND  @date2

EXEC DB_LigneCommande.dbo.affiche_prod '2019-10-11','2020-12-1'


--UTILISATION  DES FONCTIONS

-- fonction qui return le nombre de produit existant
CREATE  FUNCTION nombre_produit() RETURNS  int 
AS 
BEGIN 
	DECLARE @nombre int 
	SET @nombre= (SELECT COUNT(*) FROM DB_LigneCommande.dbo.Produit)
	RETURN @nombre 
END 

DECLARE @nombre int 
SET @nombre = DB_LigneCommande.dbo.nombre_produit()
PRINT 'le nombre de produit est '+CONVERT(CHAR(10),@nombre)

-- on recree cette fonction mais cette fois ci on renvois la liste des produits

CREATE FUNCTION list_produit() RETURNS TABLE 
AS 
	RETURN SELECT * FROM DB_LigneCommande.dbo.Produit

SELECT * FROM DB_LigneCommande.dbo.list_produit()

-- function  qui return la commande  du prix eleve

DROP FUNCTION IF EXISTS commande_prix 
CREATE FUNCTION commande_prix(@n integer) RETURNS TABLE 
AS 
	RETURN 
	      SELECT TOP @n num_cmd, prix FROM 
	      (
	      SELECT num_cmd,SUM(pu_prod*qte_cmdee) AS prix FROM DB_LigneCommande.dbo.Produit AS P 
	      INNER JOIN DB_LigneCommande.dbo.LigneCommande AS L ON 
	      P.num_produit=L.num_prod GROUP BY num_cmd  
	      ) AS resutl ORDER BY prix DESC 
	    
	      
SELECT * FROM DB_LigneCommande.dbo.commande_prix(1)


-- UTILISATION  DES CURSEURS

DECLARE  curseur CURSOR  FOR SELECT * FROM DB_LigneCommande.dbo.Commande


OPEN curseur 

DECLARE @num_cmd int
DECLARE @date1 date 
FETCH NEXT   FROM  curseur  INTO @num_cmd,@date1

while(@@fetch_status=0)
BEGIN 
	PRINT 'Commande numero'+CONVERT(char(4),@num_cmd)+'a ete fait le '+ CONVERT(char(10),@date1)
	FETCH NEXT FROM  curseur INTO  @num_cmd,@date1
END

CLOSE curseur 
DEALLOCATE curseur 

-- UTILISATION DES TRIGGERS

-- un declencheur qui empeche la modification d'une commande

DROP  TRIGGER empeche 
CREATE TRIGGER empeche ON DB_LigneCommande.dbo.Commande 
AFTER UPDATE 
AS 
BEGIN
	ROLLBACK 
	SELECT * FROM DB_LigneCommande.dbo.Commande
	SELECT * FROM INSERTED
    SELECT * FROM DELETED 
	PRINT 'La modification est interdite'
END
GO 

UPDATE DB_LigneCommande.dbo.Commande SET date_cmd='2021-10-10' WHERE num_cmd = 2
GO 

SELECT  * FROM Commande 

-- empeche la suppression des commande qui on des articles associe

DROP  TRIGGER IF EXISTS cmd_associe
GO 

CREATE  TRIGGER cmd_associe ON DB_LigneCommande.dbo.Commande 
AFTER DELETE 
AS 
BEGIN 
	DECLARE @ct int 
	SET @ct = (SELECT COUNT(*) FROM DB_LigneCommande.dbo.LigneCommande WHERE num_prod = 2)
	IF @ct > 0 
	    ROLLBACK 
END
GO 

DELETE  FROM DB_LigneCommande.dbo.Commande WHERE num_cmd = 2

