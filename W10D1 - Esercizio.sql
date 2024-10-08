/*Interrogare e filtrare le tabelle
Connettiti al db aziendale o esegui il restore del db
Esplora la tabelle dei prodotti (DimProduct)
Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color
, StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.
Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo 
FinishedGoodsFlag è uguale a 1.
Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK. 
Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il
 prezzo di listino (ListPrice).
Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)
Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
Esplora la tabella degli impiegati aziendali (DimEmployee)
Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo
 SalespersonFlag è uguale a 1.
Interroga la tabella delle vendite (FactResellerSales). Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio
 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).*/
SELECT COUNT(*), COUNT(DISTINCT ProductKey) -- per fare check su primary key
FROM dimproduct;

/*Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color
, StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.*/

SELECT
ProductKey AS 'Product Key',
ProductAlternateKey AS 'Alternate Key',
EnglishProductName AS 'Product Name',
Color,
StandardCost AS 'Standard Cost',
FinishedGoodsFlag AS 'Finished Good Flag'
FROM dimproduct;

/* Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo 
FinishedGoodsFlag è uguale a 1.*/

SELECT
ProductKey AS 'Product Key',
ProductAlternateKey AS 'Alternate Key',
EnglishProductName AS 'Product Name',
Color,
StandardCost AS 'Standard Cost',
FinishedGoodsFlag AS 'Finished Good Flag'
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK. 
Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il
 prezzo di listino (ListPrice).*/
 
SELECT
ProductKey AS 'codice prodotto',
ModelName AS 'modello',
ProductAlternateKey AS 'codice modello',
EnglishProductName AS 'nome prodotto',
StandardCost AS 'costo standard',
ListPrice AS 'prezzo di listino'
FROM dimproduct
WHERE LEFT (ProductAlternateKey, 2) IN ('FR', 'BK');-- alternativa WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)


SELECT
ProductKey AS 'codice prodotto',
ModelName AS 'modello',
ProductAlternateKey AS 'codice modello',
EnglishProductName AS 'nome prodotto',
StandardCost AS 'costo standard',
ListPrice AS 'prezzo di listino',
ListPrice - StandardCost AS Markup
FROM dimproduct
WHERE LEFT (ProductAlternateKey, 2) IN ('FR', 'BK');

-- Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.

SELECT 
    ProductKey AS 'codice prodotto',
    ModelName AS 'modello',
    ProductAlternateKey AS 'codice modello',
    EnglishProductName AS 'nome prodotto',
    StandardCost AS 'costo standard',
    ListPrice AS 'prezzo di listino'
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1
        AND ListPrice BETWEEN 1000 AND 2000


/* la tabella degli impiegati aziendali (DimEmployee)
Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo
 SalespersonFlag è uguale a 1.*/


SELECT
EmployeeKey,
FirstName,
MiddleName,
LastName,
Title,
SalesPersonFlag
FROM dimemployee
WHERE SalesPersonFlag=1

/*Interroga la tabella delle vendite (FactResellerSales). Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio
 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).*/
 
SELECT
SalesOrderNumber,
SalesOrderLineNumber,
OrderDate,
ProductKey,
SalesAmount-TotalProductCost AS 'profitto'
FROM factresellersales
WHERE ProductKey IN (597, 598, 477, 214) AND OrderDate>='2020-01-01'
ORDER BY OrderDate
