import psycopg2
from psycopg2.extras import RealDictCursor
from fastapi import FastAPI
from typing import List
from .schemas import Patient, Admission

conn_string="postgresql://mimic:password@localhost:4747/mimic"
app = FastAPI()

@app.get("/")
def hello():
    return "hello, doctor!"

@app.get("/patients", response_model=List[Patient])
def all_patients():
    conn = psycopg2.connect(conn_string, cursor_factory=RealDictCursor)
    cursor = conn.cursor()
    cursor.execute(
            """
            SELECT * FROM mimic.patients
            LIMIT 10
            """
        )
    return cursor.fetchall()

@app.get("/admissions", response_model=List[Admission])
def all_admissions():
    conn = psycopg2.connect(conn_string, cursor_factory=RealDictCursor)
    cursor = conn.cursor()
    cursor.execute(
            """
            SELECT * FROM mimic.admissions
            """
        )
    return cursor.fetchall() 

# def connectdb():
#     # Define our connection string
#     print("Connecting to database: ", conn_string)

#     # get a connection, if a connect cannot be made an exception will be raised here
#     try:
#         conn = psycopg2.connect(conn_string, cursor_factory=RealDictCursor)
#         conn.autocommit = True
#         # psycopg2 creates a server-side cursor, which prevents all of the
#         # records from being downloaded at once from the server.
#         cursor = conn.cursor()
#         print("Successful!\n")
#         cursor.execute("SET search_path TO mimic")
#         return cursor
#     except:
#         print('Cannot connect to database!')
#         return None


# if __name__ == "__main__":
#     c = connectdb()


