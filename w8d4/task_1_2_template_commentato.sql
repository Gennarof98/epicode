/*
====================================================================
TASK 1a, TASK 1b e TASK 2 — TEMPLATE COMMENTATO
Database: AdventureWorksDW
DBMS: MySQL 8+

ATTENZIONE
Nei materiali caricati in questa conversazione sono visibili soltanto
le consegne dei Task 3 e 4. Per Task 1a, 1b e 2 non e' stata fornita
la traccia originale: questo file contiene una base corretta e utile
per esplorare il database, fare SELECT, WHERE, ORDER BY, JOIN e
calcoli. Non presentarlo come soluzione definitiva finche' non invii
le slide/foto dei Task 1a, 1b e 2.
====================================================================
*/

USE AdventureWorksDW;

/* ==================================================================
   TASK 1a — ESPLORAZIONE DELLE TABELLE E SELECT DI BASE
   ================================================================== */

/* Mostra tutte le tabelle disponibili nello schema selezionato. */
SHOW TABLES;

/* Visualizza la struttura delle principali tabelle usate nelle analisi. */
DESCRIBE dimproduct;
DESCRIBE dimproductsubcategory;
DESCRIBE dimproductcategory;
DESCRIBE dimcustomer;
DESCRIBE dimgeography;
DESCRIBE dimsalesterritory;
DESCRIBE factinternetsales;
DESCRIBE factresellersales;

/* Elenco di prodotti: codice, nome, colore, costo e prezzo di listino. */
SELECT
    ProductKey AS CodiceProdotto,
    EnglishProductName AS NomeProdotto,
    Color AS Colore,
    StandardCost AS CostoStandard,
    ListPrice AS PrezzoListino
FROM dimproduct
ORDER BY ProductKey;

/* Elenco delle categorie prodotto. */
SELECT
    ProductCategoryKey AS CodiceCategoria,
    EnglishProductCategoryName AS NomeCategoria
FROM dimproductcategory
ORDER BY EnglishProductCategoryName;

/* Elenco delle sotto-categorie prodotto. */
SELECT
    ProductSubcategoryKey AS CodiceSottocategoria,
    ProductCategoryKey AS CodiceCategoria,
    EnglishProductSubcategoryName AS NomeSottocategoria
FROM dimproductsubcategory
ORDER BY ProductCategoryKey, EnglishProductSubcategoryName;

/* Elenco dei territori di vendita disponibili. */
SELECT
    SalesTerritoryKey AS CodiceTerritorio,
    SalesTerritoryRegion AS Regione,
    SalesTerritoryCountry AS Paese,
    SalesTerritoryGroup AS GruppoTerritorio
FROM dimsalesterritory
ORDER BY SalesTerritoryGroup, SalesTerritoryCountry, SalesTerritoryRegion;

/* Prime 20 vendite Internet ordinate dalla piu' recente alla meno recente. */
SELECT
    SalesOrderNumber AS NumeroOrdine,
    SalesOrderLineNumber AS RigaOrdine,
    OrderDate AS DataOrdine,
    ProductKey AS CodiceProdotto,
    CustomerKey AS CodiceCliente,
    SalesTerritoryKey AS CodiceTerritorio,
    OrderQuantity AS Quantita,
    SalesAmount AS Fatturato
FROM factinternetsales
ORDER BY OrderDate DESC, SalesOrderNumber DESC
LIMIT 20;


/* ==================================================================
   TASK 1b — FILTRI, ORDINAMENTI E CAMPI CALCOLATI
   ================================================================== */

/*
Prodotti con prezzo di listino maggiore di 1.000.
WHERE filtra le singole righe prima dell'ordinamento.
*/
SELECT
    ProductKey AS CodiceProdotto,
    EnglishProductName AS NomeProdotto,
    Color AS Colore,
    StandardCost AS CostoStandard,
    ListPrice AS PrezzoListino
FROM dimproduct
WHERE ListPrice > 1000
ORDER BY ListPrice DESC, EnglishProductName;

/*
Prodotti neri con un prezzo di listino non nullo.
IS NOT NULL si usa per controllare correttamente i valori NULL.
*/
SELECT
    ProductKey AS CodiceProdotto,
    EnglishProductName AS NomeProdotto,
    Color AS Colore,
    ListPrice AS PrezzoListino
FROM dimproduct
WHERE Color = 'Black'
  AND ListPrice IS NOT NULL
ORDER BY ListPrice DESC;

/*
Vendite Internet di un intervallo di date.
BETWEEN include entrambi gli estremi dell'intervallo.
*/
SELECT
    SalesOrderNumber AS NumeroOrdine,
    SalesOrderLineNumber AS RigaOrdine,
    OrderDate AS DataOrdine,
    ProductKey AS CodiceProdotto,
    OrderQuantity AS Quantita,
    SalesAmount AS Fatturato
FROM factinternetsales
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-31'
ORDER BY OrderDate, SalesOrderNumber, SalesOrderLineNumber;

/*
Campo calcolato: margine lordo della riga di vendita.
Il margine e' dato da SalesAmount meno TotalProductCost.
*/
SELECT
    SalesOrderNumber AS NumeroOrdine,
    SalesOrderLineNumber AS RigaOrdine,
    OrderDate AS DataOrdine,
    ProductKey AS CodiceProdotto,
    SalesAmount AS Fatturato,
    TotalProductCost AS CostoTotale,
    SalesAmount - TotalProductCost AS MargineLordo
FROM factinternetsales
ORDER BY MargineLordo DESC;

/*
Classificazione con CASE in base al fatturato della transazione.
*/
SELECT
    SalesOrderNumber AS NumeroOrdine,
    SalesOrderLineNumber AS RigaOrdine,
    SalesAmount AS Fatturato,
    CASE
        WHEN SalesAmount >= 1000 THEN 'Alto'
        WHEN SalesAmount >= 500 THEN 'Medio'
        ELSE 'Basso'
    END AS FasciaFatturato
FROM factinternetsales
ORDER BY SalesAmount DESC;


/* ==================================================================
   TASK 2 — JOIN TRA DIMENSIONI E FATTI
   ================================================================== */

/*
JOIN tra prodotto, sotto-categoria e categoria.
La query costruisce una vista logica del catalogo prodotti.
*/
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    ps.EnglishProductSubcategoryName AS Sottocategoria,
    pc.EnglishProductCategoryName AS Categoria,
    p.StandardCost AS CostoStandard,
    p.ListPrice AS PrezzoListino
FROM dimproduct AS p
LEFT JOIN dimproductsubcategory AS ps
    ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS pc
    ON pc.ProductCategoryKey = ps.ProductCategoryKey
ORDER BY pc.EnglishProductCategoryName, ps.EnglishProductSubcategoryName, p.EnglishProductName;

/*
JOIN tra vendite Internet, prodotti e territori.
Mostra il dettaglio delle transazioni con nome prodotto e area di vendita.
*/
SELECT
    fis.SalesOrderNumber AS NumeroOrdine,
    fis.SalesOrderLineNumber AS RigaOrdine,
    fis.OrderDate AS DataVendita,
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    st.SalesTerritoryRegion AS RegioneVendita,
    st.SalesTerritoryCountry AS PaeseVendita,
    fis.OrderQuantity AS Quantita,
    fis.SalesAmount AS Fatturato
FROM factinternetsales AS fis
INNER JOIN dimproduct AS p
    ON p.ProductKey = fis.ProductKey
INNER JOIN dimsalesterritory AS st
    ON st.SalesTerritoryKey = fis.SalesTerritoryKey
ORDER BY fis.OrderDate, fis.SalesOrderNumber, fis.SalesOrderLineNumber;

/*
JOIN completo per ottenere prodotto, categoria, cliente, stato/provincia
geografica, territorio e fatturato.
*/
SELECT
    fis.SalesOrderNumber AS NumeroOrdine,
    fis.SalesOrderLineNumber AS RigaOrdine,
    fis.OrderDate AS DataVendita,
    p.EnglishProductName AS NomeProdotto,
    pc.EnglishProductCategoryName AS Categoria,
    c.CustomerKey AS CodiceCliente,
    g.City AS Citta,
    g.StateProvinceName AS StatoProvincia,
    g.EnglishCountryRegionName AS Paese,
    st.SalesTerritoryRegion AS RegioneVendita,
    fis.OrderQuantity AS Quantita,
    fis.SalesAmount AS Fatturato
FROM factinternetsales AS fis
INNER JOIN dimproduct AS p
    ON p.ProductKey = fis.ProductKey
INNER JOIN dimproductsubcategory AS ps
    ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN dimproductcategory AS pc
    ON pc.ProductCategoryKey = ps.ProductCategoryKey
INNER JOIN dimcustomer AS c
    ON c.CustomerKey = fis.CustomerKey
INNER JOIN dimgeography AS g
    ON g.GeographyKey = c.GeographyKey
INNER JOIN dimsalesterritory AS st
    ON st.SalesTerritoryKey = fis.SalesTerritoryKey
ORDER BY fis.OrderDate, fis.SalesOrderNumber, fis.SalesOrderLineNumber;

/*
LEFT JOIN per trovare prodotti senza una sotto-categoria associata.
Questo e' un esempio pratico della differenza tra LEFT JOIN e INNER JOIN:
con LEFT JOIN vengono mantenuti anche i prodotti che non hanno match.
*/
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    p.ProductSubcategoryKey AS CodiceSottocategoria
FROM dimproduct AS p
LEFT JOIN dimproductsubcategory AS ps
    ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
WHERE ps.ProductSubcategoryKey IS NULL
ORDER BY p.ProductKey;
