from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# Patients associated with an admission to the ICU.
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

# Hospital admissions associated with an ICU stay.
class Admission(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int # Foreign key. Identifies the patient.
    hadm_id: int # Primary key. Identifies the hospital stay.
    admittime: datetime # Time of admission to the hospital.
    dischtime: datetime # Time of discharge from the hospital.
    deathtime: Optional[datetime] = None # Time of death.
    admission_type: str # Type of admission, for example emergency or elective.
    admission_location: str # Admission location.
    discharge_location: str # Discharge location.
    insurance: str # Insurance type.
    language: Optional[str] = None # Language.
    religion: Optional[str] = None # Religion.
    marital_status: Optional[str] = None # Marital status.
    ethnicity: str # Ethnicity.
    edregtime: Optional[datetime] = None
    edouttime: Optional[datetime] = None
    diagnosis: Optional[str] = None # Diagnosis.
    hospital_expire_flag: Optional[int] = None
    has_chartevents_data: int # Hospital admission has at least one observation in the CHARTEVENTS table.
    class Config:
        orm_mode = True