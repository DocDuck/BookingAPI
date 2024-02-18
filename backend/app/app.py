import psycopg2
from psycopg2.extras import RealDictCursor
from datetime import datetime
from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional, List

class Patient(BaseModel):
    row_id: int #245
    subject_id: int #262
    gender: str #"M"
    dob: datetime # Date of birth.
    dod: Optional[datetime] = None # Date of death. Null if the patient was alive at least 90 days post hospital discharge.
    dod_hosp: Optional[datetime] = None # Date of death recorded in the hospital records.
    dod_ssn: Optional[datetime] = None # Date of death recorded in the social security records.
    expire_flag: int = 0 # Flag indicating that the patient has died. (0 or 1)
    class Config:
        orm_mode = True

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

@app.get("/admissions")
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


