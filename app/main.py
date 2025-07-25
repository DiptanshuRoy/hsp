# app/main.py

from fastapi import FastAPI, HTTPException
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from pydantic import BaseModel
import pandas as pd
import joblib
import logging
from pathlib import Path

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="Hospital Readmission Prediction API", version="1.0.0")

# Mount static files
app.mount("/static", StaticFiles(directory="static"), name="static")

# Enhanced model loading with proper error handling
model = None
model_path = Path("models/xgb_model.pkl")

try:
    if model_path.exists():
        logger.info(f"Loading model from {model_path}")
        model = joblib.load(model_path)
        logger.info("✅ Model loaded successfully and ready for predictions")
    else:
        logger.warning(f"⚠️  Model file not found at {model_path}")
        logger.warning("Please train the model first using the notebooks or training scripts")
        model = None
except Exception as e:
    logger.error(f"❌ Failed to load model from {model_path}: {str(e)}")
    logger.error("The application will continue running but predictions will not be available")
    model = None

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

@app.get("/")
async def read_index():
    """Serve the main UI page"""
    return FileResponse('static/index.html')

@app.post("/predict")
def predict(data: PatientData):
    # Check if model is loaded before making predictions
    if model is None:
        logger.error("Prediction request received but model is not loaded")
        raise HTTPException(
            status_code=503, 
            detail="Model not loaded. Please train the model first and restart the server."
        )
    
    try:
        input_df = pd.DataFrame([data.dict()])
        prediction = model.predict(input_df)
        logger.info("Prediction made successfully")
        return {"readmission_prediction": int(prediction[0])}
    except Exception as e:
        logger.error(f"Error during prediction: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=f"Prediction failed: {str(e)}"
        )