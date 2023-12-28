from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customer = Blueprint('employee', __name__)

# The first three routes are for Employee Appsmith 1 

# Shows the employee all the customers with their invoice id
@customers.route('/employee', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('select firstName, lastName, invoiceID from customer')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
  
# Shows the employee the given customer with details about their invoice 
@customers.route('/employee/<customerID>', methods=['GET'])
def get_customerInvoice():
    cursor = db.get_db().cursor()
    cursor.execute('select firstName, lastName, customerID, phoneNumber, email, totalBill, invoiceDate, billingAddress, storeName from customer natural join invoice natural join store where customerID = {0}'.format(customerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Shows the employee the given customer with details about their invoice and allows employee to make edits to their information
@customers.route('/employee/<customerID>', methods=['POST'])
def edit_invoice():
  current_app.logger.info(request.form)
  cursor = db.get_db().cursor()
  firstName = request.form['First Name:']
  lastName = request.form['Last Name:']
  customerID = request.form['Customer ID:']
  phone = request.form['Customer Phone NUmber:']
  email = request.form['Customer Email:']
  totalBill = request.form['Total Bill ($):']
  invoiceDate = request.form['Invoice Date:']
  billingAddress = request.form['Billing Address:']
  store = request.form['Store Name:']
  query = f'insert into customer natural join invoice natural join store(firstName, lastName, customerID, phoneNumber, email, totalBill, invoiceDate, billingAddress, storeName) values(\"{firstName}\", \"{lastName}\", \"{customerID}\", \"{phone}\", \"{email}\", \"{totalBill}\", \"{invoiceDate}\", \"{billingAddress}\", \"{store}\")'
  cursor.execute(query)
  db.get_db().commit()
  return "Success"
                   
# The last two routes are for Employee Appsmith 2
                   
# Shows an employees information given an employee ID
@customers.route('/employee/<employeeID>', methods=['GET'])
def get_employee():
    cursor = db.get_db().cursor()
    cursor.execute('select employeeID, startDate, weeklyHours, dateEmployed, firstName, lastName, phoneNo, email, address, dateOfBirth, name from employee natural join store where employeeID = {0}'.format(employeeID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
                   
# Adds hours to an employees hours per week given an employee ID 
@customers.route('/employee/<employeeID>', methods=['POST'])
def edit_invoice():
  current_app.logger.info(request.form)
  cursor = db.get_db().cursor()
  firstName = request.form['Hours Per Week:']
  query = f'insert into customer(weeklyHours) values(\"{hours}\" where employeeID = {0}'.format(employeeID))
  cursor.execute(query)
  db.get_db().commit()
  return "Success"                   
