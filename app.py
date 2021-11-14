from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from sqlalchemy import create_engine
import pandas as pd
import sqlalchemy
import pyodbc
import os
app = Flask(__name__)

server = "103.91.90.200,33002"
database = "MRTC_V1"
#driver = "SQL Server Native Client 11.0"
username = "sa"
password = "AsdFZx@#213"
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
para = '0703168'
query = f'SET NOCOUNT ON; EXEC USP_GetAppEnquiry @cnmt = {para}'
df = pd.read_sql_query(query, cnxn)
print(df)
list = df.values.tolist()
print(list)
print(type(df))
@app.route('/<para>', methods=['GET'])
def get_data(para):
    #parameter = para
    query = f'SET NOCOUNT ON; EXEC USP_GetAppEnquiry @cnmt = {para}'
    df = pd.read_sql_query(query, cnxn)
    list = df.values.tolist()
    final_list = jsonify(list)
    return final_list

if __name__ == '__main__':
    app.run(debug=False, port=8000)
