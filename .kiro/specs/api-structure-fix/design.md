# Design Document

## Overview

This design addresses the FastAPI application structure issues by reorganizing the module layout to follow Python packaging best practices. The current nested `app/app/` structure will be flattened to a simple `app/` package with a `main.py` module, making the import path straightforward and eliminating the module resolution errors.

## Architecture

### Current Structure (Problematic)
```
app/
├── __init__.py
├── app/
│   └── __init__.py
└── app.main.py  # Wrong location
```

### Target Structure (Fixed)
```
app/
├── __init__.py
└── main.py      # Correct location
```

### Import Path Changes
- **Current (broken):** `app.app.main:app` 
- **Target (working):** `app.main:app`

## Components and Interfaces

### FastAPI Application Module (`app/main.py`)
- **Purpose:** Main FastAPI application with prediction endpoint
- **Dependencies:** FastAPI, Pydantic, Pandas, Joblib, Pathlib
- **Key Components:**
  - FastAPI app instance with metadata
  - Model loading with error handling
  - PatientData Pydantic model for request validation
  - `/predict` POST endpoint

### Model Loading Strategy
- **Location:** `models/xgb_model.pkl`
- **Loading:** At application startup using joblib
- **Error Handling:** Graceful degradation when model file is missing
- **Fallback:** Continue running with clear error messages

### Startup Script (`run_system.sh`)
- **Updated Command:** `uvicorn app.main:app --reload --host 0.0.0.0 --port 8000`
- **Error Handling:** Check for model existence and provide guidance
- **User Feedback:** Clear status messages throughout the process

## Data Models

### PatientData (Pydantic Model)
```python
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
```

### API Response Models
- **Prediction Response:** `{"readmission_prediction": int}`
- **Error Response:** `{"error": str, "message": str}` (for missing model scenarios)

## Error Handling

### Model Loading Errors
- **Scenario:** Model file doesn't exist
- **Response:** Log warning, set model to None, continue startup
- **User Guidance:** Display instructions for model training

### Prediction Errors
- **Scenario:** Prediction request when model is None
- **Response:** HTTP 503 Service Unavailable with clear error message
- **Message:** "Model not loaded. Please train the model first."

### Import Errors
- **Prevention:** Correct module structure eliminates import path issues
- **Validation:** Ensure `app/main.py` exists and contains FastAPI app instance

## Testing Strategy

### Manual Testing
1. **Structure Validation:** Verify file locations match expected paths
2. **Import Testing:** Test `from app.main import app` works correctly
3. **Server Startup:** Confirm uvicorn starts without module errors
4. **API Functionality:** Test prediction endpoint with sample data

### Error Scenario Testing
1. **Missing Model:** Remove model file and verify graceful handling
2. **Malformed Requests:** Send invalid data to prediction endpoint
3. **Server Restart:** Verify hot reload works with new structure

### Integration Testing
1. **End-to-End:** Full workflow from startup script to API response
2. **Model Loading:** Test both successful and failed model loading scenarios
3. **Documentation:** Verify API docs are accessible at `/docs` endpoint