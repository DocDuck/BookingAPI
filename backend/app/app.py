from fastapi import FastAPI
from fastapi.responses import FileResponse
import psycopg2

app = FastAPI()

@app.get("/")
def hello():
    return "hello, doctor!"

@app.get("/patients", response_class=FileResponse)
def all_patients():
    try:
        conn = psycopg2.connect(
            dbname="mimic",
            user="mimic",
            password="password",
            host="127.0.0.1",
            port="5432"
        )
        cursor = conn.cursor()
        cursor.execute(
            """
            SELECT * FROM mimic.patients
            """
        )
        cursor.fetchall()
    except Exception as err:
        print(err)

def connectdb():
    # Define our connection string
    conn_string = "dbname='mimic'  user='elsa'"
    print("Connecting to database: ", conn_string)

    # get a connection, if a connect cannot be made an exception will be raised here
    try:
        conn = psycopg2.connect(conn_string)
        conn.autocommit = True
        # psycopg2 creates a server-side cursor, which prevents all of the
        # records from being downloaded at once from the server.
        cursor = conn.cursor()
        print("Successful!\n")
        cursor.execute("SET search_path TO mimiciii")
        return cursor
    except:
        print('Cannot connect to database!')
        return None


if __name__ == "__main__":
    c = connectdb()


