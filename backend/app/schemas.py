from pydantic import BaseModel
from typing import Optional
from datetime import datetime

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

# Record of when patients were ready for discharge (called out), and the actual time of their discharge (or more generally, their outcome).
class Callout(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int # Foreign key. Identifies the patient.
    hadm_id: int # Primary key. Identifies the hospital stay.
    submit_wardid: Optional[int] = None # Identifies the ward where the call out request was submitted.
    submit_careunit: Optional[str] = None # If the ward where the call was submitted was an ICU, the ICU type is listed here.
    curr_wardid: Optional[int] = None #	Identifies the ward where the patient is currently residing.
    curr_careunit: Optional[str] = None # If the ward where the patient is currently residing is an ICU, the ICU type is listed here.
    callout_wardid: Optional[int] = None # Identifies the ward where the patient is to be discharged to. A value of 1 indicates the first available ward. A value of 0 indicates home.
    request_tele: int # Indicates if special precautions are required.
    request_resp: int # Indicates if special precautions are required.
    request_cdiff: int # Indicates if special precautions are required.
    request_mrsa: int # Indicates if special precautions are required.
    request_vre: int # Indicates if special precautions are required.
    callout_status: str # Current status of the call out request.
    callout_outcome: str # The result of the call out request; either a cancellation or a discharge.
    discharge_wardid: int # The ward to which the patient was discharged.
    acknowledge_status: str # The status of the response to the call out request.
    createtime: datetime # Time at which the call out request was created.
    updatetime : datetime # Last time at which the call out request was updated.
    acknowledgetime: Optional[datetime] = None # Time at which the call out request was acknowledged.
    outcometime: datetime # Time at which the outcome (cancelled or discharged) occurred.
    firstreservationtime: Optional[datetime] = None # First time at which a ward was reserved for the call out request.
    currentreservationtime: Optional[datetime] = None # Latest time at which a ward was reserved for the call out request.
    class Config:
            orm_mode = True

# List of caregivers associated with an ICU stay.
class Caregivers(BaseModel):
    row_id: int # Unique row identifier.
    cgid: int # Unique caregiver identifier.
    label: Optional[str] = None # Title of the caregiver, for example MD or RN.
    description: Optional[str] = None # More detailed description of the caregiver, if available.
    class Config:
        orm_mode = True

# Patients associated with an admission to the ICU.
class Patient(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int #262
    gender: str # Gender M or F
    dob: datetime # Date of birth.
    dod: Optional[datetime] = None # Date of death. Null if the patient was alive at least 90 days post hospital discharge.
    dod_hosp: Optional[datetime] = None # Date of death recorded in the hospital records.
    dod_ssn: Optional[datetime] = None # Date of death recorded in the social security records.
    expire_flag: int = 0 # Flag indicating that the patient has died. (0 or 1)
    class Config:
        orm_mode = True
