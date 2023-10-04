CREATE DATABASE MagicChoc
GO

USE MagicChoc 
GO

CREATE TABLE BackOrders (
    BackOrderManufacturingID          INT    NOT NULL    IDENTITY    PRIMARY KEY,
    ProductNextManufactureDate        DATE   NOT NULL,
    ProductNextManufactureQuantity    INT    NOT NULL
) ;

CREATE TABLE ProductCategories (
    ProductCategoryID             SMALLINT         NOT NULL    IDENTITY    PRIMARY KEY,
    ProductCategoryName           NVARCHAR(64)     NOT NULL,
    ProductCategoryDescription    NVARCHAR(256)    NULL
) ;

CREATE TABLE ProductSubcategories (
    ProductSubcategoryID             SMALLINT         NOT NULL    IDENTITY    PRIMARY KEY,
    ProductCategoryID                SMALLINT         NOT NULL    REFERENCES ProductCategories(ProductCategoryID),
    ProductSubcategoryName           NVARCHAR(64)     NOT NULL,
    ProductSubcategoryDescription    NVARCHAR(256)    NULL
) ;

CREATE TABLE ProductTypes (
    ProductTypeID             SMALLINT        NOT NULL    IDENTITY    PRIMARY KEY,
    ProductTypeName           NVARCHAR(64)    NOT NULL,
    ProductTypeDescription    NVARCHAR(256)   NOT NULL
) ;

CREATE TABLE Products (
    ProductID                   INT             NOT NULL    IDENTITY    PRIMARY KEY,
    ProductName                 NVARCHAR(64)    NOT NULL,
    ProductStockLevel           INT             NOT NULL,
    BackOrderManufacturingID    INT             NULL    REFERENCES BackOrders(BackOrderManufacturingID),
    ProductTypeID               SMALLINT        NOT NULL    REFERENCES ProductTypes(ProductTypeID),
    ProductSubcategoryID        SMALLINT        NOT NULL    REFERENCES ProductSubcategories(ProductSubcategoryID)
) ;

CREATE TABLE Addresses (
    AddressID    INT              NOT NULL    IDENTITY    PRIMARY KEY,
    Street       NVARCHAR(128)    NOT NULL,
    Area         NVARCHAR(64)     NULL,
    City         NVARCHAR(64)     NOT NULL,
    ZipCode      NVARCHAR(10)     NOT NULL
) ;

CREATE TABLE SupplierContacts (
    SupplierContactID           INT              NOT NULL    IDENTITY    PRIMARY KEY,
    SupplierContactFirstName    NVARCHAR(32)     NOT NULL,
    SupplierContactLastName     NVARCHAR(32)     NOT NULL,
    SupplierContactEmail        NVARCHAR(256)    NOT NULL
) ;

CREATE TABLE Suppliers (
    SupplierID           INT             NOT NULL    IDENTITY    PRIMARY KEY,
    SupplierName         NVARCHAR(32)    NOT NULL,
    SupplierContactID    INT             NOT NULL    REFERENCES SupplierContacts(SupplierContactID),
    SupplierAddressID    INT             NOT NULL    REFERENCES Addresses(AddressID)
) ;

CREATE TABLE PurchaseOrderHeaders (
    PurchaseOrderNumber    INT     NOT NULL    PRIMARY KEY,
    SupplierID             INT     NOT NULL    REFERENCES Suppliers(SupplierID),
    PurchaseOrderDate      DATE    NOT NULL
) ;

CREATE TABLE PurchaseOrderDetails (
    PurchaseOrderDetailsID    INT    NOT NULL    IDENTITY    PRIMARY KEY,
    ProductID                 INT    NOT NULL    REFERENCES Products(ProductID),
    Quantity                  INT    NOT NULL,
    PurchaseOrderNumber       INT    NOT NULL
) ;

CREATE TABLE CustomerContacts (
    CustomerContactID           INT              NOT NULL    IDENTITY    PRIMARY KEY,
    CustomerContactFirstName    NVARCHAR(32)     NOT NULL,
    CustomerContactLastName     NVARCHAR(32)     NOT NULL,
    CustomerContactEmail        NVARCHAR(256)    NOT NULL
) ;

CREATE TABLE Customers (
    CustomerID             INT             NOT NULL    IDENTITY    PRIMARY KEY,
    CustomerCompanyName    NVARCHAR(32)    NOT NULL,
    CustomerContactID      INT             NOT NULL    REFERENCES CustomerContacts(CustomerContactID),
    InvoiceAddressID       INT             NOT NULL    REFERENCES Addresses(AddressID),
    DeliveryAddressID      INT             NOT NULL    REFERENCES Addresses(AddressID)
) ;

CREATE TABLE SalesAreas (
    SalesAreaID                  SMALLINT        NOT NULL    IDENTITY    PRIMARY KEY,
    SalesAreaName                NVARCHAR(32)    NOT NULL,
    SalesAreaManagerFirstName    NVARCHAR(32)    NOT NULL,
    SalesAreaManagerLastName     NVARCHAR(32)    NOT NULL
) ;

CREATE TABLE SalesPersons (
    SalesPersonID           SMALLINT         NOT NULL    IDENTITY    PRIMARY KEY,
    SalesPersonFirstName    NVARCHAR(32)     NOT NULL,
    SalesPersonLastName     NVARCHAR(32)     NOT NULL,
    SalesPersonEmail        NVARCHAR(256)    NOT NULL
) ;

CREATE TABLE SalesOrderHeaders (
    SalesOrderNumber               NCHAR(12)       NOT NULL    PRIMARY KEY,
    SalesOrderDate                 DATE            NOT NULL,
    SalesPersonID                  SMALLINT        NOT NULL    REFERENCES SalesPersons(SalesPersonID),
    SalesAreaID                    SMALLINT        NOT NULL    REFERENCES SalesAreas(SalesAreaID),
    CustomerID                     INT             NOT NULL    REFERENCES Customers(CustomerID),
    SalesOrderDeliveryDueDate      DATE            NOT NULL,
    SalesOrderDeliveryActualDate   DATE            NULL,
    CurrierUsedforDelivery         NVARCHAR(32)    NOT NULL
) ;

CREATE TABLE SalesOrderDetails (
    SalesOrderDetailsID    INT          NOT NULL    IDENTITY    PRIMARY KEY,
    ProductID              INT          NOT NULL    REFERENCES Products(ProductID),
    Quantity               INT          NOT NULL,
    SalesOrderNumber       NCHAR(12)    NOT NULL    REFERENCES SalesOrderHeaders(SalesOrderNumber)
) ;
GO
