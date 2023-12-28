from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customer = Blueprint('manager', __name__)

# The first three routes are for Manager Appsmith 

# Shows all of the managers with their IDs, names, store names, inventoryDataIDs and salesInfoIDs
@manager.route('/manager', methods=['GET'])
def get_managers():
    cursor = db.get_db().cursor()
    cursor.execute('select managerID, firstName, lastName, inventoryDataID, salesInfoID from upperManagement natural join employee')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
  
# Shows the inventory data and sales info of a given manager - in appsmith this will be seen when a manager is selected
@manager.route('/manager/<managerID>', methods=['GET'])
def get_manager_data():
    cursor = db.get_db().cursor()
    cursor.execute('select totalSales, avgSalesPerDay, productsSoldByRegion, estimatedSales, estimatedArrival, materialsCost from upperManagement natural join inventoryData natural join salesInfo where managerID = {0}'.format(managerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Allows for an employee to be promoted to management 
@customers.route('/manager', methods=['POST'])
def add_manager():
  current_app.logger.info(request.form)
  cursor = db.get_db().cursor()
  managerID = request.form['New Manager ID:']
  employeeID = request.form['Employee ID:']
  inventoryDataID = request.form['Inventory Data ID:']
  salesInfoID = request.form['Sales Information ID:']
  query = f'insert into upperManagement(managerID, employeeID, inventoryDataID, salesInfoID) values(\"{managerID}\", \"{employeeID}\", \"{inventoryDataID}\", \"{salesInfoID}\")'
  cursor.execute(query)
  db.get_db().commit()
  return "Success"
                
