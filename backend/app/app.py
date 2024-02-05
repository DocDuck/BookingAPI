from fastapi import FastAPI
from fastapi.responses import FileResponse
import psycopg2

conn_string="postgresql://mimic:password@localhost:4747/mimic"
app = FastAPI()

@app.get("/")
def hello():
    return "hello, doctor!"

@app.get("/admissions", response_class=FileResponse)
def all_patients():
    cursor = connectdb()
    cursor.execute(
            """
            SELECT * FROM mimic.admissions
            """
        )
    return cursor.fetchall() 

def connectdb():
    # Define our connection string
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


# if __name__ == "__main__":
#     c = connectdb()


