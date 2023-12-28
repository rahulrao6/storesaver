CREATE DATABASE 'storesaver';

SHOW DATABASES;

USE 'storesaver';

GRANT ALL PRIVILEGES ON storesaver.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS 'employee';

CREATE TABLE 'employee' (
    'employeeID' INTEGER(24) NOT NULL,
    'ssn' INTEGER(9) NOT NULL,
    'startDate' DATE NOT NULL,
    'weeklyHours' INTEGER(2) NOT NULL DEFAULT 0,
    'dateEmployed' DATE NOT NULL,
    'firstName' VARCHAR(50) NOT NULL,
    'middleName' VARCHAR(50) DEFAULT NULL,
    'lastName' VARCHAR(50) NOT NULL,
    'phoneNo' VARCHAR(10) NOT NULL,
    'email' VARCHAR(50) NOT NULL,
    'address' VARCHAR(100) NOT NULL,
    'dateOfBirth' DATE NOT NULL,
    'storeID' INTEGER(24) NOT NULL,
    'inventoryID' INTEGER(24) NOT NULL,
    'managerID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('employeeID', 'ssn'),
    KEY 'storeID' ('storeID'),
    KEY 'inventoryID' ('inventoryID'),
    KEY 'managerID' ('managerID'),
    CONSTRAINT 'employee_fk_1' FOREIGN KEY ('storeID') REFERENCES 'store' ('storeID')
                        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'employee_fk_2' FOREIGN KEY ('inventoryID') REFERENCES 'inventory' ('inventoryID')
                        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'employee_fk_3' FOREIGN KEY ('managerID') REFERENCES 'upperManagement' ('managerID')
                        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Data for employee */

DROP TABLE IF EXISTS 'inventory';

CREATE TABLE 'inventory' (
    'inventoryID' INTEGER(24) NOT NULL,
    'inventoryDataID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('inventoryID'),
    KEY 'inventoryDataID' ('inventoryDataID'),
    CONSTRAINT 'inventory_fk_1' FOREIGN KEY ('inventoryDataID') REFERENCES 'inventoryData' ('inventoryDataID')
                         ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Data for inventory */

DROP TABLE IF EXISTS 'inventoryItem';

CREATE TABLE 'inventoryItem' (
    'inventoryItemID' INTEGER(24) NOT NULL,
    'itemQuantity' INTEGER NOT NULL DEFAULT 0,
    'inventoryID' INTEGER(24),
    'itemID' INTEGER(24),
    PRIMARY KEY ('inventoryItemID'),
    KEY 'inventoryID' ('inventoryID'),
    KEY 'itemID' ('itemID'),
    CONSTRAINT 'inventoryItem_fk_1' FOREIGN KEY ('inventoryID') REFERENCES 'inventory' ('inventoryID')
                             ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'inventoryItem_fk_2' FOREIGN KEY ('itemID') REFERENCES 'item' ('itemID')
                             ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'inventoryData';

CREATE TABLE 'inventoryData'(
    'inventoryDataID' INTEGER(24) NOT NULL,
    'estimatedSales' DECIMAL(50,2) NOT NULL,
    'estimatedArrival' INTEGER(50) NOT NULL,
    'materialsCost' DECIMAL(50,2) NOT NULL,
    PRIMARY KEY ('inventoryDataID')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'upperManagement';

CREATE TABLE 'upperManagement' (
    'managerID' INTEGER(24) NOT NULL,
    'employeeID' INTEGER(24) NOT NULL,
    'inventoryDataID' INTEGER(24) NOT NULL,
    'salesInfoID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('managerID', 'employeeID'),
    KEY 'inventoryDataID' ('inventoryDataID'),
    KEY 'salesInfoID' ('salesInfoID'),
    CONSTRAINT 'upperManagement_fk_1' FOREIGN KEY ('inventoryDataID') REFERENCES 'inventoryData' ('inventoryDataID')
                               ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'upperManagement_fk_2' FOREIGN KEY ('salesInfoID') REFERENCES 'salesInfo' ('salesInfoID')
                               ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'manageStore';

CREATE TABLE 'manageStore' (
    'managerID' INTEGER(24) NOT NULL,
    'employeeID' INTEGER(24) NOT NULL,
    'storeID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('managerID', 'employeeID'),
    KEY 'storeID' ('storeID'),
    CONSTRAINT 'manageStore_fk_1' FOREIGN KEY ('storeID') REFERENCES 'store' ('storeID')
                           ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'item';

CREATE TABLE 'item' (
    'itemID' INTEGER(24) NOT NULL,
    'itemName' VARCHAR(50) NOT NULL,
    'unitPrice' DECIMAL(50,2) NOT NULL,
    'materialCost' DECIMAL(50, 2) NOT NULL,
    'brandName' VARCHAR(50) NOT NULL,
    'categoryName' VARCHAR(50) NOT NULL,
    PRIMARY KEY ('itemID'),
    KEY 'brandName' ('brandName'),
    KEY 'categoryName' ('categoryName'),
    CONSTRAINT 'item_fk_1' FOREIGN KEY ('brandName') REFERENCES 'brand' ('brandName')
                    ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'item_fk_2' FOREIGN KEY ('categoryName') REFERENCES 'category' ('categoryName')
                    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'category';

CREATE TABLE 'category' (
    'categoryName' VARCHAR(50) NOT NULL,
    'sectorOfGood' VARCHAR(50) NOT NULL,
    'description' VARCHAR(50) NOT NULL,
    PRIMARY KEY ('categoryName')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'brand';

CREATE TABLE 'brand' (
    'brandName' VARCHAR(50) NOT NULL,
    'country' VARCHAR(50) NOT NULL,
    PRIMARY KEY ('brandName')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'listItem';

CREATE TABLE 'listItem' (
    'itemID' INTEGER(24) NOT NULL,
    'listID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('itemID', 'listID')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'salesInfo';

CREATE TABLE 'salesInfo' (
    'salesInfoID' INTEGER(24) NOT NULL,
    'totalSales' DECIMAL(50,2) NOT NULL,
    'avgSalesPerDay' DECIMAL(50,2) NOT NULL,
    'productsSoldByRegion' INTEGER(50) NOT NULL,
    PRIMARY KEY ('salesInfoID')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'store';

CREATE TABLE 'store' (
    'storeID' INTEGER(24) NOT NULL,
    'name' VARCHAR(50) NOT NULL,
    'address' VARCHAR(50) NOT NULL,
    PRIMARY KEY ('storeID')
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'customer';

CREATE TABLE 'customer' (
    'customerID' INTEGER(24) NOT NULL,
    'username' VARCHAR(50) NOT NULL,
    'password' VARCHAR(50) NOT NULL,
    'firstName' VARCHAR(50) NOT NULL,
    'middleName' VARCHAR(50) DEFAULT NULL,
    'lastName' VARCHAR(50) NOT NULL,
    'dateOfBirth' DATE NOT NULL,
    'phoneNumber' VARCHAR(10) NOT NULL,
    'email' VARCHAR(50) NOT NULL,
    'listID' INTEGER(24) NOT NULL,
    'invoiceID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('customerID'),
    KEY 'listID' ('listID'),
    KEY 'invoiceID' ('invoiceID'),
    CONSTRAINT 'customer_fk_1' FOREIGN KEY ('listID') REFERENCES 'shoppingList' ('listID')
                        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'customer_fk_2' FOREIGN KEY ('invoiceID') REFERENCES 'invoice' ('invoiceID')
                        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'shoppingList';

CREATE TABLE 'shoppingList' (
    'listID' INTEGER(24) NOT NULL,
    'totalBill' DECIMAL(50,2) DEFAULT 0,
    'invoiceID' INTEGER(24) NOT NULL,
    'storeID' INTEGER(24) NOT NULL,
    PRIMARY KEY ('listID'),
    KEY 'invoiceID' ('invoiceID'),
    KEY 'storeID' ('storeID'),
    CONSTRAINT 'list_fk_1' FOREIGN KEY ('invoiceID') REFERENCES 'invoice' ('invoiceID')
                            ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'list_fk_2' FOREIGN KEY ('storeID') REFERENCES 'store' ('storeID')
                            ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'invoice';

CREATE TABLE 'invoice' (
    'invoiceID' INTEGER(24) NOT NULL,
    'invoiceDate' DATE NOT NULL,
    'billingAddress' VARCHAR(50) NOT NULL,
    'customerID'INTEGER(24) NOT NULL,
    'storeID'INTEGER(24) NOT NULL,
    PRIMARY KEY ('invoiceID'),
    KEY 'customerID' ('customerID'),
    KEY 'storeID' ('storeID'),
    CONSTRAINT 'invoice_fk_1' FOREIGN KEY ('customerID') REFERENCES 'customer' ('customerID')
                       ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'invoice_fk_2' FOREIGN KEY ('storeID') REFERENCES 'store' ('storeID')
                       ON UPDATE CASCADE ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS 'invoiceItem';

CREATE TABLE 'invoiceItem' (
    'itemID' INTEGER(24) NOT NULL,
    'invoiceID' INTEGER(24) NOT NULL,
    'unitQuantity' INTEGER(50) NOT NULL,
    'unitPrice' DECIMAL(50,2) NOT NULL,
    CONSTRAINT 'invoiceItem_fk_1' FOREIGN KEY ('invoiceID') REFERENCES 'invoice' ('invoiceID')
                           ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT 'invoiceItem_fk_2' FOREIGN KEY ('itemID') REFERENCES 'item' ('itemID')
                           ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
