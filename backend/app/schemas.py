from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# Hospital admissions associated with an ICU stay.
# Госпитализации в отделение интенсивной терапии.
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

# Events occuring on a patient chart. (Записи в карте пациента)
# Есть побочные таблицы Chartevents_1 - Chartevents_10, не вызываются напрямую
class Chartevents(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int # Foreign key. Identifies the patient. (parent: patients)
    hadm_id: Optional[int] = None # Foreign key. Identifies the hospital stay. (parent: admissions)
    icustay_id: Optional[int] = None # Foreign key. Identifies the ICU stay. (parent: icustays)
    itemid: Optional[int] = None # Foreign key. Identifies the charted item. (parent: d_items)
    charttime: Optional[datetime] = None # Time when the event occured.
    storetime: Optional[datetime] = None # Time when the event was recorded in the system.
    cgid: Optional[int] = None # Foreign key. Identifies the caregiver. (parent: caregivers)
    value: Optional[str] = None # Value of the event as a text string.
    valuenum: Optional[float] = None # Value of the event as a number.
    valueuom: Optional[str] = None # Unit of measurement.
    warning: Optional[int] = None # Flag to highlight that the value has triggered a warning.
    error: Optional[int] = None # Flag to highlight an error with the event.
    resultstatus: Optional[str] = None # Result status of lab data.
    stopped: Optional[str] = None # Text string indicating the stopped status of an event (i.e. stopped, not stopped).
    class Config:
            orm_mode = True

# Events recorded in Current Procedural Terminology.
class Cptevents(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int # Foreign key. Identifies the patient. (parent: patients)
    hadm_id: int # Foreign key. Identifies the hospital stay. (parent: admissions)
    costcenter: str # Center recording the code, for example the ICU or the respiratory unit.
    chartdate: Optional[datetime] = None # Date when the event occured, if available.
    cpt_cd: str # Current Procedural Terminology code.
    cpt_number: Optional[int] = None # Numerical element of the Current Procedural Terminology code.
    cpt_suffix: Optional[str] = None # Text element of the Current Procedural Terminology, if any. Indicates code category.
    ticket_id_seq: Optional[int] = None # Sequence number of the event, derived from the ticket ID.
    sectionheader: Optional[str] = None # High-level section of the Current Procedural Terminology code.
    subsectionheader: Optional[str] = None # Subsection of the Current Procedural Terminology code.
    description: Optional[str] = None # Description of the Current Procedural Terminology, if available.
    class Config:
        orm_mode = True

# High-level dictionary of the Current Procedural Terminology.
class D_cpt(BaseModel):
    row_id: int # Unique row identifier.
    category: int # Code category
    sectionrange: str # Range of codes within the high-level section.
    sectionheader: str # Section header.
    subsectionrange: str # Range of codes within the subsection.
    subsectionheader: str # Subsection header.
    codesuffix: Optional[str] = None # Text element of the Current Procedural Terminology, if any.
    mincodeinsubsection: int # Minimum code within the subsection.
    maxcodeinsubsection: int # Maximum code within the subsection.
    class Config:
        orm_mode = True
    
# Dictionary of the International Classification of Diseases, 9th Revision (Diagnoses).
# МКБ-9 словарь диагнозов
class D_icd_diagnoses(BaseModel):
    row_id: int # Unique row identifier.
    icd9_code: str # ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.
    short_title: str # Short title associated with the code.
    long_title: str # Long title associated with the code.
    class Config:
        orm_mode = True

# Dictionary of the International Classification of Diseases, 9th Revision (Procedures).
# МКБ-9 словарь процедур
class D_icd_procedures(BaseModel):
    row_id: int # Unique row identifier.
    icd9_code: str # ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.
    short_title: str # Short title associated with the code.
    long_title: str # Long title associated with the code.
    class Config:
        orm_mode = True

# Dictionary of non-laboratory-related charted items.
class D_items(BaseModel):
    row_id: int # Unique row identifier.
    itemid: int # Primary key. Identifies the charted item.
    label: Optional[str] = None # Label identifying the item.
    abbreviation: Optional[str] = None # Abbreviation associated with the item.
    dbsource: Optional[str] = None # Source database of the item.
    linksto: Optional[str] = None # Table which contains data for the given ITEMID.
    category: Optional[str] = None # Category of data which the concept falls under.
    unitname: Optional[str] = None # Unit associated with the item.
    param_type: Optional[str] = None # Type of item, for example solution or ingredient.
    conceptid: Optional[int] = None # Identifier used to harmonize concepts identified by multiple ITEMIDs. CONCEPTIDs are planned but not yet implemented (all values are NULL).
    class Config:
        orm_mode = True

# Dictionary of laboratory-related items.
class D_labitems(BaseModel):
    row_id: int # Unique row identifier.
    itemid: int # Foreign key. Identifies the charted item.
    label: str # Label identifying the item.
    fluid: str # Fluid associated with the item, for example blood or urine.
    category: str # Category of item, for example chemistry or hematology.
    loinc_code: Optional[str] = None # Logical Observation Identifiers Names and Codes (LOINC) mapped to the item, if available.
    class Config:
        orm_mode = True

# Events relating to a datetime.
class Datetimeevents(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int # Foreign key. Identifies the patient. (parent: patients)
    hadm_id: Optional[int] = None # Foreign key. Identifies the hospital stay. (parent: admissions)
    icustay_id: Optional[int] = None # Foreign key. Identifies the ICU stay. (parent: icustays)
    itemid: int # Foreign key. Identifies the charted item. (parent: d_items)
    charttime: datetime # Time when the event occured.
    storetime: datetime # Time when the event was recorded in the system.
    cgid: int # Foreign key. Identifies the caregiver. (parent: caregivers)
    value: Optional[str] = None # Value of the event as a text string.
    valueuom: str # Unit of measurement.
    warning: Optional[int] = None # Flag to highlight that the value has triggered a warning.
    error: Optional[int] = None # Flag to highlight an error with the event.
    resultstatus: Optional[str] = None # Result status of lab data.
    stopped: Optional[str] = None # Event was explicitly marked as stopped. Infrequently used by caregivers.
    class Config:
            orm_mode = True

# Patients associated with an admission to the ICU.
class Patient(BaseModel):
    row_id: int # Unique row identifier.
    subject_id: int # Primary key. Identifies the patient.
    gender: str # Gender M or F
    dob: datetime # Date of birth.
    dod: Optional[datetime] = None # Date of death. Null if the patient was alive at least 90 days post hospital discharge.
    dod_hosp: Optional[datetime] = None # Date of death recorded in the hospital records.
    dod_ssn: Optional[datetime] = None # Date of death recorded in the social security records.
    expire_flag: int = 0 # Flag indicating that the patient has died. (0 or 1)
    class Config:
        orm_mode = True
