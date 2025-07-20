# app/main.py

from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import joblib

app = FastAPI()
model = joblib.load("models/xgb_model.pkl")

class PatientData(BaseModel):
    age: float
    gender_Male: float
    num_lab_procedures: float
    time_in_hospital: float
    number_outpatient: float
    number_emergency: float
    number_inpatient: float
    num_diagnoses: float
    A1Cresult_7: float
    diabetesMed_Yes: float
    change_Ch: float
    insulin_Steady: float
    diag_1_250_83: float
    diag_2_401_9: float
    diag_3_414_01: float

@app.post("/predict")
def predict(data: PatientData):
    input_df = pd.DataFrame([data.dict()])
    prediction = model.predict(input_df)
    return {"readmission_prediction": int(prediction[0])}
