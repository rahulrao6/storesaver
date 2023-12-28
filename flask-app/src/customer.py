from flask import Blueprint, request, jsonify, make_response
import json
from src import db


customer = Blueprint('customer', __name__)

# These routes are for the customer appsmith 

# Get customer detail for customer with particular userID
@customer.route('/customer/<customerID>', methods=['GET'])
def get_customer(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from customer where customerID = {0}'.format(customerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
 
# Get customer shopping list data 
@customer.route('/customer/list/<customerID>', methods=['GET'])
def get_list(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from shoppingList where customerID = {0}'.format(customerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer invoice data 
@customer.route('/customer/invoice/<customerID>', methods=['GET'])
def get_list(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from invoice natural join invoiceItem natural join item natural join shoppingList where customerID = {0}'.format(customerID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
