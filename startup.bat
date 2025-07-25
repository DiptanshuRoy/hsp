@echo off
setlocal enabledelayedexpansion

echo 🏥 Hospital Readmission Prediction System Setup
echo ==============================================

REM Check Python version
echo 📋 Checking Python environment...
python test_environment.py >nul 2>&1
if errorlevel 1 (
    echo ❌ Python environment check failed. Please ensure Python 3 is properly installed.
    echo    Make sure you have Python 3.7+ installed and accessible via 'python' command.
    echo    Try: python --version
    pause
    exit /b 1
)

REM Install dependencies
echo 📦 Installing dependencies...
pip install -r requirements.txt >nul 2>&1
if errorlevel 1 (
    echo ❌ Failed to install dependencies. Please check your pip installation.
    echo    Try running: pip install --upgrade pip
    echo    Or use: python -m pip install -r requirements.txt
    pause
    exit /b 1
)

REM Create data directories
echo 📁 Creating data directories...
if not exist "data\raw" mkdir data\raw
if not exist "data\interim" mkdir data\interim
if not exist "data\processed" mkdir data\processed
if not exist "models" mkdir models

REM Validate FastAPI application structure
echo 🔍 Validating FastAPI application structure...
if not exist "app\main.py" (
    echo ❌ FastAPI application not found at app\main.py
    echo    Expected structure:
    echo    app\
    echo    ├── __init__.py
    echo    └── main.py
    echo    Please ensure the application follows the correct structure.
    pause
    exit /b 1
)

if not exist "app\__init__.py" (
    echo ❌ Missing app\__init__.py - required for Python package structure
    echo    Creating app\__init__.py...
    type nul > app\__init__.py
)

REM Check if model exists and provide guidance
if not exist "models\xgb_model.pkl" (
    echo ⚠️  No trained model found at models\xgb_model.pkl
    echo    The API will start but predictions will return errors until model is available.
    echo    To train a model:
    echo    1. Add your hospital data to data\raw\
    echo    2. Run: python src\data\make_dataset.py
    echo    3. Run: python src\models\train_model.py
    echo    4. Restart the server to load the new model
    echo.
    echo 🚀 Starting FastAPI server without model...
) else (
    echo ✅ Model found at models\xgb_model.pkl
    echo 🚀 Starting API server with prediction capabilities...
)

echo.
echo 🌐 Server will be available at:
echo    • Web UI: http://localhost:8000 ^(Main Interface^)
echo    • API docs: http://localhost:8000/docs
echo    • OpenAPI schema: http://localhost:8000/openapi.json
echo.
echo 💡 Use the Web UI for easy predictions with a user-friendly interface!
echo.
echo 🛑 Press Ctrl+C to stop the server
echo.

REM Validate the import path before starting
echo 🔍 Validating FastAPI application import...
python -c "import sys; import os; sys.path.insert(0, os.getcwd()); from app.main import app; from fastapi import FastAPI; print('✅ Import validation successful - FastAPI app instance found') if isinstance(app, FastAPI) else print('❌ app.main.app is not a FastAPI instance'); print(f'   App title: {app.title}'); print(f'   App version: {app.version}')" 2>nul
if errorlevel 1 (
    echo ❌ FastAPI application validation failed
    echo.
    echo    Expected import configuration:
    echo    • Import path: app.main:app
    echo    • File location: app\main.py
    echo    • Package marker: app\__init__.py
    echo.
    echo    Troubleshooting steps:
    echo    1. Ensure app\main.py exists and contains: app = FastAPI^(...)
    echo    2. Ensure app\__init__.py exists ^(Python package marker^)
    echo    3. Check that FastAPI is installed: pip install fastapi
    echo    4. Verify current directory structure matches expected layout
    echo.
    pause
    exit /b 1
)

echo ✅ FastAPI application import path validated successfully

REM Start the server
echo 🚀 Starting uvicorn server...
echo    Using import path: app.main:app
echo    Server configuration:
echo    • Host: 0.0.0.0 ^(accessible from all interfaces^)
echo    • Port: 8000
echo    • Reload: enabled ^(development mode^)
echo.

REM Check if port 8000 is already in use
netstat -an | findstr ":8000" >nul 2>&1
if not errorlevel 1 (
    echo ⚠️  Warning: Port 8000 appears to be in use
    echo    You may need to stop other services or use a different port
    echo.
)

echo 🔄 Starting server...
echo.
echo 🎉 All validations passed! Starting server...
echo.

REM Start the actual server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

REM If we reach here, the server has stopped
echo.
echo 🛑 Server has stopped.
pause