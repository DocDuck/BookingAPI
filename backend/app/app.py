from fastapi import FastAPI
from fastapi.responses import FileResponse

app = FastAPI()

@app.get("/")
def hello():
    return "hello, doctor!"

@app.get("/data", response_class=FileResponse)
async def read_data():
    file_path = "https://storage.googleapis.com/pyhealth/Synthetic_MIMIC-III/DIAGNOSES.csv"
    response = FileResponse(file_path, media_type="text/csv")
    response.headers["Content-Disposition"] = "attachment; filename=downloaded_file.csv"
    return response
