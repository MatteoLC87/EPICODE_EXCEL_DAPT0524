
-- Interrogare, filtrare e raggruppare

-- 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
-- Quali considerazioni/ragionamenti è necessario che tu faccia?

SELECT
ProductKey
,COUNT(*) -- (2) conto il numero di record presenti in ogni gruppo. Se tutte le somme sono pari a 1, allora  è PK.
FROM dimproduct
GROUP BY ProductKey; -- (1) creo un gruppo per ogni  ProductKey

-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

SELECT -- esempio di PK
SalesOrderNumber
,SalesOrderLineNumber
,COUNT(*)
FROM factresellersales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING COUNT(*) <> 1;

SELECT -- esempio di NON PK
SalesOrderNumber
, COUNT(*)
FROM factresellersales
GROUP BY SalesOrderNumber
HAVING COUNT(*) <> 1;

-- 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.

SELECT
OrderDate
,COUNT(SalesOrderLineNumber) 'numero transazioni'
FROM factresellersales
GROUP BY OrderDate
HAVING YEAR(OrderDate)>= 2020;

-- 4.Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) 
-- e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e 
-- il prezzo medio di vendita. I campi in output devono essere parlanti!

SELECT
s.ProductKey 'codice prodotto'
,EnglishProductName 'nome prodotto'
,SUM(s.SalesAmount) 'fatturato totale'
,SUM(s.OrderQuantity) 'quantità totale venduta'
,AVG(UnitPrice) 'prezzo medio di vendita'
FROM factresellersales s
LEFT OUTER JOIN dimproduct d
ON s.ProductKey = d.ProductKey
GROUP BY s.ProductKey;

-- 5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta 
-- (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
-- Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
-- I campi in output devono essere parlanti!

SELECT
dpc.ProductCategoryKey 'codice categoria'
,dpc.EnglishProductCategoryName 'nome categoria'
,SUM(s.SalesAmount) 'fatturato totale'
,SUM(s.OrderQuantity) '	quantità totale venduta'
FROM dimproductcategory dpc
INNER JOIN dimproductsubcategory dpsc
ON dpc.ProductCategoryKey = dpsc.ProductCategoryKey
INNER JOIN dimproduct dp
ON dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
INNER JOIN factresellersales s
ON dp.ProductKey = s.ProductKey
GROUP BY dpc.ProductCategoryKey;

-- 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020.
-- Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.

SELECT
g.City città
,SUM(s.SalesAmount) 'fatturato totale per città da 2020, >60k'
FROM dimgeography g
INNER JOIN dimreseller r
ON g.GeographyKey = r.GeographyKey
INNER JOIN factresellersales s
ON r.ResellerKey = s.ResellerKey
WHERE YEAR(s.OrderDate) >= 2020
GROUP BY g.City
HAVING SUM(s.SalesAmount) > 60000;


-- TIP

-- Dove non espressamente indicato è necessario individuare in autonomia le tabelle contenenti i dati utili.

-- In alcuni casi, per maggior chiarezza è stato indicando il percorso NomeTabella.NomeCampo altrimenti la sola indicazione
-- del campo!
