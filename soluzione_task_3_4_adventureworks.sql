/*
====================================================================
SOLUZIONE — Task 3 e Task 4 (a, b, c, d, e)
Database: AdventureWorksDW
DBMS: MySQL 8+

NOTE IMPORTANTI
1) Le tabelle reali usate sono: dimproduct, dimproductsubcategory,
   dimproductcategory, dimcustomer, dimgeography, dimsalesterritory,
   factinternetsales e factresellersales.
2) Le colonne chiave reali sono ProductKey, SalesTerritoryKey e OrderDate.
3) Eseguire l'intero script in MySQL Workbench. Le sezioni di controllo
   restituiscono dati e servono a verificare chiavi e risultati.
====================================================================
*/

USE AdventureWorksDW;

/* ==================================================================
   TASK 3 — POPOLAMENTO DATI
   ================================================================== */

/*
3.1 — Verifica dei prodotti disponibili.
La tabella dimproduct e' gia' popolata nel dataset AdventureWorksDW.
Questa query mostra almeno quattro prodotti diversi che possono essere
usati nelle vendite di test senza inventare ProductKey.
*/
SELECT
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    ProductSubcategoryKey,
    StandardCost,
    ListPrice
FROM dimproduct
ORDER BY ProductKey
LIMIT 4;

/*
3.2 — Verifica delle regioni/territori disponibili.
La consegna richiede almeno 3 stati distribuiti in almeno 2 regioni.
In questo modello, SalesTerritoryCountry rappresenta lo Stato/Paese e
SalesTerritoryRegion rappresenta la regione di vendita.
*/
SELECT
    SalesTerritoryKey,
    SalesTerritoryRegion,
    SalesTerritoryCountry,
    SalesTerritoryGroup
FROM dimsalesterritory
ORDER BY SalesTerritoryKey;

/*
3.3 — Verifica delle chiavi obbligatorie per inserire vendite Internet.
Se vuoi inserire nuove vendite, seleziona valori esistenti da queste tabelle.
*/
SELECT CustomerKey
FROM dimcustomer
ORDER BY CustomerKey
LIMIT 10;

SELECT PromotionKey
FROM dimpromotion
ORDER BY PromotionKey
LIMIT 10;

SELECT CurrencyKey
FROM dimcurrency
ORDER BY CurrencyKey
LIMIT 10;

/*
3.4 — Inserimento di almeno 10 vendite in periodi diversi.

IMPORTANTE:
- Prima di lanciare gli INSERT, controlla che ProductKey, CustomerKey,
  PromotionKey, CurrencyKey e SalesTerritoryKey usati qui esistano davvero.
- I ProductKey 680-683, CustomerKey 11000-11009, PromotionKey 1,
  CurrencyKey 100 e SalesTerritoryKey 1/2/4/6 sono valori di esempio.
- Se una chiave non esiste, sostituiscila con una chiave mostrata nelle
  query di verifica sopra.
- SalesOrderNumber + SalesOrderLineNumber costituiscono la chiave primaria
  composta: i valori devono essere nuovi e non gia' presenti.
*/

INSERT INTO factinternetsales (
    SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate,
    DueDate,
    ShipDate,
    ProductKey,
    CustomerKey,
    PromotionKey,
    CurrencyKey,
    SalesTerritoryKey,
    OrderQuantity,
    UnitPrice,
    ExtendedAmount,
    UnitPriceDiscountPct,
    DiscountAmount,
    ProductStandardCost,
    TotalProductCost,
    SalesAmount,
    TaxAmt,
    Freight,
    CarrierTrackingNumber,
    CustomerPONumber
)
VALUES
('SO-DEMO-1001', 1, '2022-02-15', '2022-02-27', '2022-02-20', 680, 11000, 1, 100, 1, 2, 120.00, 240.00, 0.0000, 0.00, 80.00, 160.00, 240.00, 19.20, 5.00, NULL, 'PO-1001'),
('SO-DEMO-1002', 1, '2022-06-10', '2022-06-22', '2022-06-15', 681, 11001, 1, 100, 2, 1, 250.00, 250.00, 0.0000, 0.00, 170.00, 170.00, 250.00, 20.00, 5.00, NULL, 'PO-1002'),
('SO-DEMO-1003', 1, '2022-11-05', '2022-11-17', '2022-11-10', 682, 11002, 1, 100, 4, 3, 90.00, 270.00, 0.0000, 0.00, 60.00, 180.00, 270.00, 21.60, 5.00, NULL, 'PO-1003'),
('SO-DEMO-1004', 1, '2023-01-20', '2023-02-01', '2023-01-25', 683, 11003, 1, 100, 6, 1, 500.00, 500.00, 0.0000, 0.00, 350.00, 350.00, 500.00, 40.00, 5.00, NULL, 'PO-1004'),
('SO-DEMO-1005', 1, '2023-04-12', '2023-04-24', '2023-04-17', 680, 11004, 1, 100, 1, 2, 120.00, 240.00, 0.0000, 0.00, 80.00, 160.00, 240.00, 19.20, 5.00, NULL, 'PO-1005'),
('SO-DEMO-1006', 1, '2023-08-30', '2023-09-11', '2023-09-04', 681, 11005, 1, 100, 2, 1, 250.00, 250.00, 0.0000, 0.00, 170.00, 170.00, 250.00, 20.00, 5.00, NULL, 'PO-1006'),
('SO-DEMO-1007', 1, '2024-01-15', '2024-01-27', '2024-01-20', 682, 11006, 1, 100, 4, 2, 90.00, 180.00, 0.0000, 0.00, 60.00, 120.00, 180.00, 14.40, 5.00, NULL, 'PO-1007'),
('SO-DEMO-1008', 1, '2024-05-18', '2024-05-30', '2024-05-23', 683, 11007, 1, 100, 6, 1, 500.00, 500.00, 0.0000, 0.00, 350.00, 350.00, 500.00, 40.00, 5.00, NULL, 'PO-1008'),
('SO-DEMO-1009', 1, '2024-09-25', '2024-10-07', '2024-09-30', 680, 11008, 1, 100, 1, 3, 120.00, 360.00, 0.0000, 0.00, 80.00, 240.00, 360.00, 28.80, 5.00, NULL, 'PO-1009'),
('SO-DEMO-1010', 1, '2025-02-10', '2025-02-22', '2025-02-15', 681, 11009, 1, 100, 2, 2, 250.00, 500.00, 0.0000, 0.00, 170.00, 340.00, 500.00, 40.00, 5.00, NULL, 'PO-1010');

/* Controllo delle vendite demo appena inserite. */
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate,
    ProductKey,
    CustomerKey,
    SalesTerritoryKey,
    OrderQuantity,
    SalesAmount
FROM factinternetsales
WHERE SalesOrderNumber LIKE 'SO-DEMO-%'
ORDER BY OrderDate;


/* ==================================================================
   TASK 4a — INTEGRITA' E JOIN
   ================================================================== */

/*
4a.1 — Verifica dell'unicita' delle chiavi primarie.
Ogni query deve restituire zero righe: se restituisce righe, sono duplicati.
*/

/* Chiave primaria di dimproduct. */
SELECT
    ProductKey,
    COUNT(*) AS Occorrenze
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1;

/* Chiave primaria di dimproductsubcategory. */
SELECT
    ProductSubcategoryKey,
    COUNT(*) AS Occorrenze
FROM dimproductsubcategory
GROUP BY ProductSubcategoryKey
HAVING COUNT(*) > 1;

/* Chiave primaria di dimproductcategory. */
SELECT
    ProductCategoryKey,
    COUNT(*) AS Occorrenze
FROM dimproductcategory
GROUP BY ProductCategoryKey
HAVING COUNT(*) > 1;

/* Chiave primaria di dimsalesterritory. */
SELECT
    SalesTerritoryKey,
    COUNT(*) AS Occorrenze
FROM dimsalesterritory
GROUP BY SalesTerritoryKey
HAVING COUNT(*) > 1;

/*
Chiave primaria composta di factinternetsales:
SalesOrderNumber + SalesOrderLineNumber.
*/
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS Occorrenze
FROM factinternetsales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING COUNT(*) > 1;

/*
4a.2 — Elenco transazioni tramite INNER JOIN.
Espone codice prodotto, categoria, stato, regione, data e importo.
La colonna Oltre180Giorni vale TRUE se dalla vendita sono trascorsi piu'
di 180 giorni, FALSE altrimenti.
*/
SELECT
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber,
    fis.OrderDate AS DataVendita,
    fis.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    pc.EnglishProductCategoryName AS Categoria,
    g.StateProvinceName AS Stato,
    st.SalesTerritoryRegion AS RegioneVendita,
    fis.SalesAmount AS Fatturato,
    CASE
        WHEN DATEDIFF(CURDATE(), fis.OrderDate) > 180 THEN TRUE
        ELSE FALSE
    END AS Oltre180Giorni
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
4a.3 — Controllo di completezza.
Il conteggio delle righe dopo gli INNER JOIN deve coincidere con il numero
complessivo delle righe in factinternetsales.
*/
SELECT COUNT(*) AS RigheInFactInternetSales
FROM factinternetsales;

SELECT COUNT(*) AS RigheDopoInnerJoin
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
    ON st.SalesTerritoryKey = fis.SalesTerritoryKey;


/* ==================================================================
   TASK 4b — AGGREGAZIONI E RAGGRUPPAMENTI
   ================================================================== */

/*
4b.1 — Fatturato totale per prodotto e per anno.
YEAR(OrderDate) estrae l'anno dalla data di vendita.
*/
SELECT
    fis.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    YEAR(fis.OrderDate) AS Anno,
    SUM(fis.SalesAmount) AS FatturatoTotale
FROM factinternetsales AS fis
INNER JOIN dimproduct AS p
    ON p.ProductKey = fis.ProductKey
GROUP BY
    fis.ProductKey,
    p.EnglishProductName,
    YEAR(fis.OrderDate)
ORDER BY
    fis.ProductKey,
    Anno;

/*
4b.2 — Fatturato totale per stato e per anno.
Il risultato e' ordinato per data/anno crescente e fatturato decrescente.
*/
SELECT
    g.StateProvinceName AS Stato,
    YEAR(fis.OrderDate) AS Anno,
    SUM(fis.SalesAmount) AS FatturatoTotale
FROM factinternetsales AS fis
INNER JOIN dimcustomer AS c
    ON c.CustomerKey = fis.CustomerKey
INNER JOIN dimgeography AS g
    ON g.GeographyKey = c.GeographyKey
GROUP BY
    g.StateProvinceName,
    YEAR(fis.OrderDate)
ORDER BY
    Anno ASC,
    FatturatoTotale DESC;

/*
4b.3 — Categoria di prodotto piu' venduta per fatturato.
LIMIT 1 restituisce solo la categoria con il fatturato totale piu' alto.
*/
SELECT
    pc.ProductCategoryKey AS CodiceCategoria,
    pc.EnglishProductCategoryName AS Categoria,
    SUM(fis.SalesAmount) AS FatturatoTotale
FROM factinternetsales AS fis
INNER JOIN dimproduct AS p
    ON p.ProductKey = fis.ProductKey
INNER JOIN dimproductsubcategory AS ps
    ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN dimproductcategory AS pc
    ON pc.ProductCategoryKey = ps.ProductCategoryKey
GROUP BY
    pc.ProductCategoryKey,
    pc.EnglishProductCategoryName
ORDER BY FatturatoTotale DESC
LIMIT 1;

/*
Esempio richiesto di HAVING: filtra i gruppi dopo l'aggregazione.
Modifica 100000 se vuoi una soglia differente.
*/
SELECT
    YEAR(OrderDate) AS Anno,
    SUM(SalesAmount) AS FatturatoTotale
FROM factinternetsales
GROUP BY YEAR(OrderDate)
HAVING SUM(SalesAmount) > 100000
ORDER BY Anno;


/* ==================================================================
   TASK 4c — SUBQUERY E CTE
   Obiettivo: prodotti con quantita'/fatturato totale superiore alla media
   nell'ultimo anno censito. La traccia dice 'quantita totale'; pertanto
   il confronto e' eseguito sulla somma di OrderQuantity.
   ================================================================== */

/* Verifica dell'ultimo anno disponibile nella tabella vendite. */
SELECT MAX(YEAR(OrderDate)) AS UltimoAnnoCensito
FROM factinternetsales;

/*
4c.1 e 4c.2 — Soluzione con subquery.
Calcola la quantita' venduta per prodotto nell'ultimo anno e conserva solo
i prodotti sopra la media delle quantita' aggregate per prodotto.
*/
SELECT
    fis.ProductKey AS CodiceProdotto,
    SUM(fis.OrderQuantity) AS QuantitaTotaleVenduta
FROM factinternetsales AS fis
WHERE YEAR(fis.OrderDate) = (
    SELECT MAX(YEAR(OrderDate))
    FROM factinternetsales
)
GROUP BY fis.ProductKey
HAVING SUM(fis.OrderQuantity) > (
    SELECT AVG(QuantitaPerProdotto)
    FROM (
        SELECT
            ProductKey,
            SUM(OrderQuantity) AS QuantitaPerProdotto
        FROM factinternetsales
        WHERE YEAR(OrderDate) = (
            SELECT MAX(YEAR(OrderDate))
            FROM factinternetsales
        )
        GROUP BY ProductKey
    ) AS quantita_ultimo_anno
)
ORDER BY QuantitaTotaleVenduta DESC;

/*
4c.3 — Stessa soluzione con CTE.
La CTE separa il calcolo delle quantita' e quello della media, rendendo
la query piu' leggibile. Il risultato deve coincidere con la subquery.
*/
WITH quantita_ultimo_anno AS (
    SELECT
        ProductKey,
        SUM(OrderQuantity) AS QuantitaTotaleVenduta
    FROM factinternetsales
    WHERE YEAR(OrderDate) = (
        SELECT MAX(YEAR(OrderDate))
        FROM factinternetsales
    )
    GROUP BY ProductKey
),
media_quantita AS (
    SELECT AVG(QuantitaTotaleVenduta) AS QuantitaMedia
    FROM quantita_ultimo_anno
)
SELECT
    q.ProductKey AS CodiceProdotto,
    q.QuantitaTotaleVenduta
FROM quantita_ultimo_anno AS q
CROSS JOIN media_quantita AS m
WHERE q.QuantitaTotaleVenduta > m.QuantitaMedia
ORDER BY q.QuantitaTotaleVenduta DESC;


/* ==================================================================
   TASK 4d — WINDOW FUNCTIONS
   ================================================================== */

/*
4d.1 — Classifica di ogni prodotto per fatturato totale all'interno
         della propria categoria.
RANK() crea la posizione in classifica e PARTITION BY separa le categorie.
*/
WITH fatturato_per_prodotto AS (
    SELECT
        p.ProductKey,
        p.EnglishProductName AS NomeProdotto,
        pc.ProductCategoryKey,
        pc.EnglishProductCategoryName AS Categoria,
        SUM(fis.SalesAmount) AS FatturatoTotale
    FROM factinternetsales AS fis
    INNER JOIN dimproduct AS p
        ON p.ProductKey = fis.ProductKey
    INNER JOIN dimproductsubcategory AS ps
        ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
    INNER JOIN dimproductcategory AS pc
        ON pc.ProductCategoryKey = ps.ProductCategoryKey
    GROUP BY
        p.ProductKey,
        p.EnglishProductName,
        pc.ProductCategoryKey,
        pc.EnglishProductCategoryName
)
SELECT
    ProductKey AS CodiceProdotto,
    NomeProdotto,
    Categoria,
    FatturatoTotale,
    RANK() OVER (
        PARTITION BY ProductCategoryKey
        ORDER BY FatturatoTotale DESC
    ) AS PosizioneInCategoria
FROM fatturato_per_prodotto
ORDER BY Categoria, PosizioneInCategoria, NomeProdotto;

/*
4d.2 — Totale progressivo del fatturato fino a ogni data.
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW indica di sommare tutte
le righe precedenti, comprese la prima e la riga corrente.
*/
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    OrderDate AS DataVendita,
    ProductKey AS CodiceProdotto,
    SalesAmount AS FatturatoTransazione,
    SUM(SalesAmount) OVER (
        ORDER BY OrderDate, SalesOrderNumber, SalesOrderLineNumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS FatturatoProgressivo
FROM factinternetsales
ORDER BY OrderDate, SalesOrderNumber, SalesOrderLineNumber;

/*
4d.3 — Confronto tra una vendita e la vendita precedente nella stessa regione.
LAG() legge l'importo della riga precedente nel gruppo definito da
SalesTerritoryKey. La prima vendita di ogni regione avra' NULL come
vendita precedente e come differenza.
*/
SELECT
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber,
    fis.OrderDate AS DataVendita,
    st.SalesTerritoryRegion AS Regione,
    fis.SalesAmount AS FatturatoTransazione,
    LAG(fis.SalesAmount) OVER (
        PARTITION BY fis.SalesTerritoryKey
        ORDER BY fis.OrderDate, fis.SalesOrderNumber, fis.SalesOrderLineNumber
    ) AS FatturatoVenditaPrecedente,
    fis.SalesAmount - LAG(fis.SalesAmount) OVER (
        PARTITION BY fis.SalesTerritoryKey
        ORDER BY fis.OrderDate, fis.SalesOrderNumber, fis.SalesOrderLineNumber
    ) AS DifferenzaRispettoPrecedente
FROM factinternetsales AS fis
INNER JOIN dimsalesterritory AS st
    ON st.SalesTerritoryKey = fis.SalesTerritoryKey
ORDER BY
    st.SalesTerritoryRegion,
    fis.OrderDate,
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber;


/* ==================================================================
   TASK 4e — PRODOTTI INVENDUTI E VIEW
   ================================================================== */

/*
4e.1 — Primo approccio: NOT EXISTS.
Un prodotto e' invenduto se non compare ne' nelle vendite Internet,
ne' nelle vendite dei rivenditori.
*/
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto
FROM dimproduct AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM factinternetsales AS fis
    WHERE fis.ProductKey = p.ProductKey
)
AND NOT EXISTS (
    SELECT 1
    FROM factresellersales AS frs
    WHERE frs.ProductKey = p.ProductKey
)
ORDER BY p.ProductKey;

/*
4e.2 — Secondo approccio: LEFT JOIN e confronto con NULL.
La subquery costruisce l'insieme di tutti i ProductKey venduti nelle due
fact table; poi vengono mantenuti solo i prodotti senza corrispondenza.
Il risultato deve essere uguale alla query precedente.
*/
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto
FROM dimproduct AS p
LEFT JOIN (
    SELECT DISTINCT ProductKey
    FROM factinternetsales

    UNION

    SELECT DISTINCT ProductKey
    FROM factresellersales
) AS prodotti_venduti
    ON prodotti_venduti.ProductKey = p.ProductKey
WHERE prodotti_venduti.ProductKey IS NULL
ORDER BY p.ProductKey;

/*
4e.3 — Vista normalizzata dei prodotti con categoria.
DROP VIEW IF EXISTS permette di rieseguire lo script senza errore se
la vista esiste gia'. La vista e' interrogabile con SELECT *.
*/
DROP VIEW IF EXISTS vw_prodotti_categorie_reporting;

CREATE VIEW vw_prodotti_categorie_reporting AS
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    pc.ProductCategoryKey AS CodiceCategoria,
    pc.EnglishProductCategoryName AS NomeCategoria
FROM dimproduct AS p
LEFT JOIN dimproductsubcategory AS ps
    ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS pc
    ON pc.ProductCategoryKey = ps.ProductCategoryKey;

/* Verifica della prima vista. */
SELECT *
FROM vw_prodotti_categorie_reporting;

/*
4e.4 — Vista geografica per analizzare le vendite per area.
Espone campi di vendita, cliente, citta', stato/provincia, Paese e territorio.
*/
DROP VIEW IF EXISTS vw_vendite_geografiche;

CREATE VIEW vw_vendite_geografiche AS
SELECT
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber,
    fis.OrderDate AS DataVendita,
    fis.ProductKey AS CodiceProdotto,
    fis.SalesAmount AS Fatturato,
    c.CustomerKey AS CodiceCliente,
    g.City AS Citta,
    g.StateProvinceCode AS CodiceStatoProvincia,
    g.StateProvinceName AS StatoProvincia,
    g.CountryRegionCode AS CodicePaese,
    g.EnglishCountryRegionName AS Paese,
    st.SalesTerritoryRegion AS RegioneVendita,
    st.SalesTerritoryCountry AS PaeseTerritorio,
    st.SalesTerritoryGroup AS GruppoTerritorio
FROM factinternetsales AS fis
INNER JOIN dimcustomer AS c
    ON c.CustomerKey = fis.CustomerKey
INNER JOIN dimgeography AS g
    ON g.GeographyKey = c.GeographyKey
INNER JOIN dimsalesterritory AS st
    ON st.SalesTerritoryKey = fis.SalesTerritoryKey;

/* Verifica della seconda vista. */
SELECT *
FROM vw_vendite_geografiche;


/* ==================================================================
   GOVERNANCE & PRIVACY APPLICATA
   Le seguenti versioni evitano esposizione superflua di dati personali,
   usano le colonne reali del modello e minimizzano i dati memorizzati.
   ================================================================== */

/*
Caso 1 — Vista pubblica dei prodotti e vendite.
Correzione: usa ProductKey e la catena Product -> Subcategory -> Category.
Non espone dati del cliente.
*/
DROP VIEW IF EXISTS vw_prodotti_pubblici;

CREATE VIEW vw_prodotti_pubblici AS
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    pc.EnglishProductCategoryName AS Categoria,
    fis.OrderDate AS DataVendita,
    fis.SalesAmount AS ImportoVendita
FROM factinternetsales AS fis
INNER JOIN dimproduct AS p
    ON p.ProductKey = fis.ProductKey
LEFT JOIN dimproductsubcategory AS ps
    ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS pc
    ON pc.ProductCategoryKey = ps.ProductCategoryKey;

/*
Caso 2 — Contatti di supporto.
Correzione privacy: non memorizza il numero telefonico completo; conserva
solo le ultime quattro cifre, se davvero necessarie per il supporto.
*/
DROP TABLE IF EXISTS SupportContact;

CREATE TABLE SupportContact (
    SupportContactID INT AUTO_INCREMENT PRIMARY KEY,
    Department VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(255) NOT NULL,
    PhoneLast4 CHAR(4) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*
Caso 3 — Vista commerciale con margine lordo.
Correzione: SalesAmount e TotalProductCost provengono da factinternetsales.
La vista mostra solo campi utili per l'analisi commerciale.
*/
DROP VIEW IF EXISTS vw_sales_margin;

CREATE VIEW vw_sales_margin AS
SELECT
    fis.SalesOrderNumber,
    fis.SalesOrderLineNumber,
    fis.OrderDate AS DataVendita,
    fis.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    fis.SalesAmount AS Fatturato,
    fis.TotalProductCost AS CostoTotaleProdotto,
    fis.SalesAmount - fis.TotalProductCost AS MargineLordo
FROM factinternetsales AS fis
INNER JOIN dimproduct AS p
    ON p.ProductKey = fis.ProductKey;

/*
Caso 4 — Log di accesso/reporting.
Correzione privacy: non salva il testo integrale della query, che potrebbe
contenere dati personali o informazioni riservate. Salva invece un hash.
*/
DROP TABLE IF EXISTS ReportingAccessLog;

CREATE TABLE ReportingAccessLog (
    AccessLogID BIGINT AUTO_INCREMENT PRIMARY KEY,
    UserID VARCHAR(100) NOT NULL,
    QueryType VARCHAR(100) NOT NULL,
    QueryHash CHAR(64) NOT NULL,
    AccessDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* Esempio di inserimento nel log: SHA2 genera l'hash della descrizione query. */
INSERT INTO ReportingAccessLog (
    UserID,
    QueryType,
    QueryHash
)
VALUES (
    'utente_reporting',
    'vendite_per_categoria',
    SHA2('vendite_per_categoria', 256)
);

/* Controlli finali delle viste create. */
SELECT * FROM vw_prodotti_pubblici LIMIT 20;
SELECT * FROM vw_sales_margin LIMIT 20;
SELECT * FROM ReportingAccessLog;
