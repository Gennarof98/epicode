/*
====================================================================
TASK 1a, TASK 1b e TASK 2 — SOLUZIONE COMPLETA COMMENTATA
Scenario: ToysGroup
DBMS: MySQL 8+

Le entita' richieste dalla traccia sono:
- Product
- Region
- Sales

Relazioni:
- Product 1:N Sales
- Region 1:N Sales
- Sales e' la tabella associativa/fatto che registra le vendite.
====================================================================
*/

/* ==================================================================
   TASK 1a — PROGETTAZIONE CONCETTUALE
   ==================================================================

   1) Entita' e attributi descrittivi

   PRODUCT
   - ProductID: identificatore univoco del prodotto.
   - ProductName: nome del prodotto.
   - Category: categoria del prodotto.
   - UnitPrice: prezzo unitario del prodotto.

   REGION
   - RegionID: identificatore univoco della regione.
   - RegionName: nome della regione.
   - Country: Paese della regione.

   SALES
   - SaleID: identificatore univoco della vendita.
   - ProductID: prodotto venduto.
   - RegionID: regione in cui e' avvenuta la vendita.
   - SalesDate: data della vendita.
   - Quantity: quantita' venduta.
   - SalesAmount: importo totale della vendita.

   2) Cardinalita'

   PRODUCT 1:N SALES
   - Un prodotto puo' comparire in molte vendite.
   - Ogni vendita riguarda un solo prodotto.

   REGION 1:N SALES
   - Una regione puo' contenere molte vendite.
   - Ogni vendita avviene in una sola regione.

   3) Schema concettuale testuale

   PRODUCT (1) -------- (N) SALES (N) -------- (1) REGION

   SALES collega quindi Product e Region e contiene i dati specifici
   della transazione, come data, quantita' e importo.
   ================================================================== */


/* ==================================================================
   TASK 1b — PROGETTAZIONE LOGICA
   ==================================================================

   PRODUCT(
       ProductID PK,
       ProductName,
       Category,
       UnitPrice
   )

   REGION(
       RegionID PK,
       RegionName,
       Country
   )

   SALES(
       SaleID PK,
       ProductID FK -> PRODUCT(ProductID),
       RegionID FK -> REGION(RegionID),
       SalesDate,
       Quantity,
       SalesAmount
   )

   Chiavi esterne:
   - Sales.ProductID riferisce Product.ProductID.
   - Sales.RegionID riferisce Region.RegionID.

   In questo modo le vendite non possono riferirsi a prodotti o regioni
   inesistenti, se i vincoli FOREIGN KEY sono attivi.
   ================================================================== */


/* ==================================================================
   TASK 2 — DDL: CREAZIONE DELLE TABELLE
   ================================================================== */

/* Se lo script viene rieseguito, elimina prima le tabelle figlie. */
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Region;

/*
Creazione della tabella Product.
- ProductID e' la chiave primaria.
- ProductName e Category sono obbligatori.
- UnitPrice non puo' essere negativo.
*/
CREATE TABLE Product (
    ProductID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(60) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Product PRIMARY KEY (ProductID),
    CONSTRAINT CK_Product_UnitPrice CHECK (UnitPrice >= 0)
);

/*
Creazione della tabella Region.
- RegionID e' la chiave primaria.
- RegionName e Country sono obbligatori.
*/
CREATE TABLE Region (
    RegionID INT NOT NULL,
    RegionName VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Region PRIMARY KEY (RegionID)
);

/*
Creazione della tabella Sales.
- SaleID e' la chiave primaria.
- ProductID e RegionID sono chiavi esterne.
- SalesDate, Quantity e SalesAmount descrivono la vendita.
- Quantity deve essere maggiore di zero.
- SalesAmount non puo' essere negativo.
*/
CREATE TABLE Sales (
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    RegionID INT NOT NULL,
    SalesDate DATE NOT NULL,
    Quantity INT NOT NULL,
    SalesAmount DECIMAL(12,2) NOT NULL,
    CONSTRAINT PK_Sales PRIMARY KEY (SaleID),
    CONSTRAINT FK_Sales_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID),
    CONSTRAINT FK_Sales_Region
        FOREIGN KEY (RegionID)
        REFERENCES Region(RegionID),
    CONSTRAINT CK_Sales_Quantity CHECK (Quantity > 0),
    CONSTRAINT CK_Sales_SalesAmount CHECK (SalesAmount >= 0)
);

/*
Verifica della struttura delle tabelle create.
*/
DESCRIBE Product;
DESCRIBE Region;
DESCRIBE Sales;

/*
Verifica dei vincoli e delle chiavi esterne tramite metadata MySQL.
*/
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('Product', 'Region', 'Sales')
ORDER BY TABLE_NAME, CONSTRAINT_NAME;

/*
Verifica delle relazioni tra chiavi esterne e chiavi primarie.
*/
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Sales'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

/*
Controllo finale: le CREATE TABLE devono terminare senza errori.
Le query seguenti mostrano che le tabelle sono vuote e pronte per il
Task 3, che inserira' i dati rispettando ProductID e RegionID esistenti.
*/
SELECT COUNT(*) AS NumeroProdotti FROM Product;
SELECT COUNT(*) AS NumeroRegioni FROM Region;
SELECT COUNT(*) AS NumeroVendite FROM Sales;
