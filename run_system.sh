#!/bin/bash

echo "🏥 Hospital Readmission Prediction System Setup"
echo "=============================================="

# Check Python version
echo "📋 Checking Python environment..."
if ! python3 test_environment.py; then
    echo "❌ Python environment check failed. Please ensure Python 3 is properly installed."
    echo "   Make sure you have Python 3.7+ installed and accessible via 'python3' command."
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
if ! pip install -r requirements.txt; then
    echo "❌ Failed to install dependencies. Please check your pip installation."
    echo "   Try running: pip install --upgrade pip"
    echo "   Or use: python3 -m pip install -r requirements.txt"
    exit 1
fi

# Create data directories
echo "📁 Creating data directories..."
mkdir -p data/raw data/interim data/processed models

# Validate FastAPI application structure
echo "🔍 Validating FastAPI application structure..."
if [ ! -f "app/main.py" ]; then
    echo "❌ FastAPI application not found at app/main.py"
    echo "   Expected structure:"
    echo "   app/"
    echo "   ├── __init__.py"
    echo "   └── main.py"
    echo "   Please ensure the application follows the correct structure."
    exit 1
fi

if [ ! -f "app/__init__.py" ]; then
    echo "❌ Missing app/__init__.py - required for Python package structure"
    echo "   Creating app/__init__.py..."
    touch app/__init__.py
fi

# Check if model exists and provide guidance
if [ ! -f "models/xgb_model.pkl" ]; then
    echo "⚠️  No trained model found at models/xgb_model.pkl"
    echo "   The API will start but predictions will return errors until model is available."
    echo "   To train a model:"
    echo "   1. Add your hospital data to data/raw/"
    echo "   2. Run: make data (or python src/data/make_dataset.py)"
    echo "   3. Run: python src/models/train_model.py"
    echo "   4. Restart the server to load the new model"
    echo ""
    echo "🚀 Starting FastAPI server without model..."
else
    echo "✅ Model found at models/xgb_model.pkl"
    echo "🚀 Starting API server with prediction capabilities..."
fi

echo ""
echo "🌐 Server will be available at:"
echo "   • Web UI: http://localhost:8000 (Main Interface)"
echo "   • API docs: http://localhost:8000/docs"
echo "   • OpenAPI schema: http://localhost:8000/openapi.json"
echo ""
echo "💡 Use the Web UI for easy predictions with a user-friendly interface!"
echo ""
echo "🛑 Press Ctrl+C to stop the server"
echo ""

# Validate the import path before starting
echo "🔍 Validating FastAPI application import..."
if python3 -c "
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
    print('   1. Ensure app/main.py exists and contains: app = FastAPI(...)')
    print('   2. Ensure app/__init__.py exists (Python package marker)')
    print('   3. Check that FastAPI is installed: pip install fastapi')
    print('   4. Verify current directory structure matches expected layout')
    sys.exit(1)
except Exception as e:
    print(f'⚠️  Warning during import validation: {e}')
    print('   This may be due to missing model dependencies.')
    print('   The app structure appears correct, proceeding with startup...')
"; then
    echo "✅ FastAPI application import path validated successfully"
else
    echo "❌ FastAPI application validation failed"
    echo ""
    echo "   Expected import configuration:"
    echo "   • Import path: app.main:app"
    echo "   • File location: app/main.py"
    echo "   • Package marker: app/__init__.py"
    echo ""
    echo "   Please fix the application structure before starting the server."
    exit 1
fi

# Start the server with enhanced error handling and validation
echo "🚀 Starting uvicorn server..."
echo "   Using import path: app.main:app"
echo "   Server configuration:"
echo "   • Host: 0.0.0.0 (accessible from all interfaces)"
echo "   • Port: 8000"
echo "   • Reload: enabled (development mode)"
echo ""

# Test server startup with timeout to validate it starts successfully
echo "🔄 Validating server startup..."

# Start uvicorn in background to test startup
timeout 10s uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 &
SERVER_PID=$!

# Wait a moment for server to start
sleep 3

# Check if server is responding
if curl -s -f http://localhost:8000/docs > /dev/null 2>&1; then
    echo "✅ Server startup validation successful - API is responding"
    # Kill the test server
    kill $SERVER_PID 2>/dev/null
    wait $SERVER_PID 2>/dev/null
    
    echo ""
    echo "🎉 All validations passed! Starting production server..."
    echo ""
    
    # Start the actual server using exec for proper signal handling
    exec uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
else
    echo "❌ Server startup validation failed"
    echo "   The server did not respond within the expected time."
    echo "   This could indicate:"
    echo "   • Port 8000 is already in use"
    echo "   • Missing dependencies"
    echo "   • Application configuration errors"
    echo ""
    echo "   Try running manually: uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"
    
    # Clean up background process
    kill $SERVER_PID 2>/dev/null
    wait $SERVER_PID 2>/dev/null
    exit 1
fi