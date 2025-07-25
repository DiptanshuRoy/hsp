# Hospital Readmission Prediction System Setup - PowerShell Version
# Run with: powershell -ExecutionPolicy Bypass -File startup.ps1

Write-Host "🏥 Hospital Readmission Prediction System Setup" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

# Function to check if command exists
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Check Python version
Write-Host "📋 Checking Python environment..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Python found: $pythonVersion" -ForegroundColor Green
        
        # Run environment test
        python test_environment.py
        if ($LASTEXITCODE -ne 0) {
            throw "Python environment test failed"
        }
    } else {
        throw "Python not found or not accessible"
    }
} catch {
    Write-Host "❌ Python environment check failed. Please ensure Python 3 is properly installed." -ForegroundColor Red
    Write-Host "   Make sure you have Python 3.7+ installed and accessible via 'python' command." -ForegroundColor Red
    Write-Host "   Try: python --version" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
try {
    pip install -r requirements.txt --quiet
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install dependencies"
    }
    Write-Host "✅ Dependencies installed successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to install dependencies. Please check your pip installation." -ForegroundColor Red
    Write-Host "   Try running: pip install --upgrade pip" -ForegroundColor Yellow
    Write-Host "   Or use: python -m pip install -r requirements.txt" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Create data directories
Write-Host "📁 Creating data directories..." -ForegroundColor Yellow
$directories = @("data\raw", "data\interim", "data\processed", "models")
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "   Created: $dir" -ForegroundColor Gray
    }
}
Write-Host "✅ Data directories ready" -ForegroundColor Green

# Validate FastAPI application structure
Write-Host "🔍 Validating FastAPI application structure..." -ForegroundColor Yellow
if (!(Test-Path "app\main.py")) {
    Write-Host "❌ FastAPI application not found at app\main.py" -ForegroundColor Red
    Write-Host "   Expected structure:" -ForegroundColor Red
    Write-Host "   app\" -ForegroundColor Red
    Write-Host "   ├── __init__.py" -ForegroundColor Red
    Write-Host "   └── main.py" -ForegroundColor Red
    Write-Host "   Please ensure the application follows the correct structure." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

if (!(Test-Path "app\__init__.py")) {
    Write-Host "❌ Missing app\__init__.py - required for Python package structure" -ForegroundColor Red
    Write-Host "   Creating app\__init__.py..." -ForegroundColor Yellow
    New-Item -ItemType File -Path "app\__init__.py" -Force | Out-Null
}
Write-Host "✅ FastAPI application structure validated" -ForegroundColor Green

# Check if model exists and provide guidance
if (!(Test-Path "models\xgb_model.pkl")) {
    Write-Host "⚠️  No trained model found at models\xgb_model.pkl" -ForegroundColor Yellow
    Write-Host "   The API will start but predictions will return errors until model is available." -ForegroundColor Yellow
    Write-Host "   To train a model:" -ForegroundColor Yellow
    Write-Host "   1. Add your hospital data to data\raw\" -ForegroundColor Yellow
    Write-Host "   2. Run: python src\data\make_dataset.py" -ForegroundColor Yellow
    Write-Host "   3. Run: python src\models\train_model.py" -ForegroundColor Yellow
    Write-Host "   4. Restart the server to load the new model" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🚀 Starting FastAPI server without model..." -ForegroundColor Cyan
} else {
    Write-Host "✅ Model found at models\xgb_model.pkl" -ForegroundColor Green
    Write-Host "🚀 Starting API server with prediction capabilities..." -ForegroundColor Cyan
}

Write-Host ""
Write-Host "🌐 Server will be available at:" -ForegroundColor Cyan
Write-Host "   • Web UI: http://localhost:8000 (Main Interface)" -ForegroundColor White
Write-Host "   • API docs: http://localhost:8000/docs" -ForegroundColor White
Write-Host "   • OpenAPI schema: http://localhost:8000/openapi.json" -ForegroundColor White
Write-Host ""
Write-Host "💡 Use the Web UI for easy predictions with a user-friendly interface!" -ForegroundColor Green
Write-Host ""
Write-Host "🛑 Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Validate the import path before starting
Write-Host "🔍 Validating FastAPI application import..." -ForegroundColor Yellow
try {
    $validationScript = @"
import sys
import os
sys.path.insert(0, os.getcwd())

try:
    from app.main import app
    from fastapi import FastAPI
    if isinstance(app, FastAPI):
        print('✅ Import validation successful - FastAPI app instance found')
        print(f'   App title: {app.title}')
        print(f'   App version: {app.version}')
    else:
        print('❌ app.main.app is not a FastAPI instance')
        print(f'   Found type: {type(app)}')
        sys.exit(1)
except ImportError as e:
    print(f'❌ Import error: {e}')
    print('   Troubleshooting steps:')
    print('   1. Ensure app\\main.py exists and contains: app = FastAPI(...)')
    print('   2. Ensure app\\__init__.py exists (Python package marker)')
    print('   3. Check that FastAPI is installed: pip install fastapi')
    print('   4. Verify current directory structure matches expected layout')
    sys.exit(1)
except Exception as e:
    print(f'⚠️  Warning during import validation: {e}')
    print('   This may be due to missing model dependencies.')
    print('   The app structure appears correct, proceeding with startup...')
"@
    
    python -c $validationScript
    if ($LASTEXITCODE -ne 0) {
        throw "Import validation failed"
    }
    Write-Host "✅ FastAPI application import path validated successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ FastAPI application validation failed" -ForegroundColor Red
    Write-Host ""
    Write-Host "   Expected import configuration:" -ForegroundColor Red
    Write-Host "   • Import path: app.main:app" -ForegroundColor Red
    Write-Host "   • File location: app\main.py" -ForegroundColor Red
    Write-Host "   • Package marker: app\__init__.py" -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if uvicorn is available
if (!(Test-Command "uvicorn")) {
    Write-Host "❌ uvicorn not found. Installing..." -ForegroundColor Red
    pip install uvicorn
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install uvicorn" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Check if port 8000 is already in use
$portInUse = Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue
if ($portInUse) {
    Write-Host "⚠️  Warning: Port 8000 appears to be in use" -ForegroundColor Yellow
    Write-Host "   You may need to stop other services or use a different port" -ForegroundColor Yellow
    Write-Host ""
}

# Start the server
Write-Host "🚀 Starting uvicorn server..." -ForegroundColor Cyan
Write-Host "   Using import path: app.main:app" -ForegroundColor Gray
Write-Host "   Server configuration:" -ForegroundColor Gray
Write-Host "   • Host: 0.0.0.0 (accessible from all interfaces)" -ForegroundColor Gray
Write-Host "   • Port: 8000" -ForegroundColor Gray
Write-Host "   • Reload: enabled (development mode)" -ForegroundColor Gray
Write-Host ""

Write-Host "🔄 Starting server..." -ForegroundColor Yellow
Write-Host ""
Write-Host "🎉 All validations passed! Starting server..." -ForegroundColor Green
Write-Host ""

# Start the actual server
try {
    uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
} catch {
    Write-Host ""
    Write-Host "❌ Server failed to start: $_" -ForegroundColor Red
    Write-Host "   Try running manually: uvicorn app.main:app --reload --host 0.0.0.0 --port 8000" -ForegroundColor Yellow
} finally {
    Write-Host ""
    Write-Host "🛑 Server has stopped." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
}