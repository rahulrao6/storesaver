# GENERAL
- StoreSavers would provide an e-commerce store management system that would be accessible to three main user personas: Customers, Employees, and Upper Management. The main functions of the database for customers will include inventory management (ability to see available products), shopping list functionality, and a customer profile. The main functions for employees will be to check available products and the quantity of in-stock products. In addition, they will be able to add/change product information, locate products within the store, and add inventory. Finally, the third archetype is the store’s upper management. They will be able to see data trends related to the sales, in addition to forecasts related to inventory management. This product should allow users to store product and sales information and allow particular access to the main entities. 
- Store management system 

# STORESAVER.SQL 
- Our product is a database that contains all information necessary for a store. This includes the personas of the customer, employee, and upper management. 
- This database contains the following tables:
- employee - represents a store employee - each employee belongs to a store, has an inventory, and is supervised by a manager
- inventory - represents an inventory which has inventory data 
- inventoryItem - represents an inventory item that is an item and belongs to an inventory 
- inventoryData - represents a variety of inventory data - estimated sales, estimated arrival, and materials cost 
- upperManagement - represents a manager that is an employee and has inventory data and sales info 
- manageStore - connects a manager with a store using manager, employee, and store ID
- item - represents a store item that has a brand and belongs to a category 
- category - represents an item category 
- brand - represents an item brand 
- listItem - connects an item to a list 
- salesInfo - represents sales information 
- store - represents a store 
- customer - represents a customer that has a shopping list and invoice 
- shoppingList - represents a shopping list that has an invoice and is bought from a store 
- invoice - represents an invoice that belongs to a customer and store 
- invoiceItem - connects an item to an invoice 

## EMPLOYEE ROUTES:
1. /employee - gets all of the customers with their corresponding invoice ids 
2. /employee/<customerID> - gets information on a customer with the given customerID - name, customerID, contact, invoice date, bill, and address, and store name
3. POST - allows employee to update the seen information about a customer 
4. /employee/<employeeID> - gets information on an employee with the given employeeID - name, employeeID, start date, hours, employment date, contacts, date of birth, and store name
5. POST - allows employee to update their weekly hours 

## CUSTOMER ROUTES:
1. /customer/<userID> - gets all of a customer’s details given a customer ID
2. /customer/list/<customerID> - gets the shopping list of a customer given a customer ID 
3. /customer/invoice/<customerID> - gets the invoice of a customer’s shopping list given a customer ID

## MANAGER ROUTES:
1. /manager - gets all of the managers with their IDs, names, store names, inventory data ID, and sales information ID
2. /manager/<managerID> - gets a manager’s inventory data and sales information given a manager ID 
3. POST - allows for an employee to be promoted to management by adding an existing employee to upperManagement
