@echo off
REM Simple Windows startup script for Hospital Readmission Prediction System

title Hospital Readmission Prediction System

echo.
echo ========================================
echo  Hospital Readmission Prediction System
echo ========================================
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.7+ and add it to your PATH
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Install requirements if needed
if not exist "hospital_ml_env" (
    echo Installing dependencies...
    pip install -r requirements.txt
)

REM Create necessary directories
if not exist "models" mkdir models
if not exist "data\raw" mkdir data\raw
if not exist "data\processed" mkdir data\processed

REM Check if app exists
if not exist "app\main.py" (
    echo ERROR: FastAPI application not found at app\main.py
    echo Please ensure the project structure is correct
    pause
    exit /b 1
)

echo.
echo Starting Hospital Readmission Prediction System...
echo.
echo Web UI will be available at: http://localhost:8000
echo API Documentation at: http://localhost:8000/docs
echo.
echo Press Ctrl+C to stop the server
echo.

REM Start the server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

echo.
echo Server stopped.
pause