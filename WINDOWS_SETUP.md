# Windows Setup Guide - Hospital Readmission Prediction System

This guide provides multiple ways to run the Hospital Readmission Prediction System on Windows.

## 🚀 Quick Start Options

### Option 1: Simple Command Script (Recommended for Beginners)
```cmd
run_windows.cmd
```
**What it does:**
- Basic validation and startup
- Minimal output, fast startup
- Good for daily development use

### Option 2: Full Batch Script (Comprehensive)
```cmd
startup.bat
```
**What it does:**
- Complete environment validation
- Detailed error messages and troubleshooting
- Creates all necessary directories
- Validates FastAPI application structure

### Option 3: PowerShell Script (Advanced)
```powershell
powershell -ExecutionPolicy Bypass -File startup.ps1
```
**What it does:**
- Modern PowerShell with colored output
- Advanced error handling
- Network port checking
- Comprehensive validation

### Option 4: Manual Startup (For Developers)
```cmd
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

## 📋 Prerequisites

### Required Software
1. **Python 3.7+** - Download from [python.org](https://www.python.org/downloads/)
   - ✅ Make sure to check "Add Python to PATH" during installation
   - ✅ Verify with: `python --version`

2. **pip** (usually comes with Python)
   - ✅ Verify with: `pip --version`

### Optional (for development)
3. **Git** - For version control
4. **VS Code** - For code editing
5. **Jupyter** - For notebook development

## 🛠️ Installation Steps

### Step 1: Download/Clone Project
```cmd
git clone <repository-url>
cd hospital-readmission-prediction
```

### Step 2: Choose Your Startup Method
Pick one of the startup options above based on your needs.

### Step 3: Access the Application
Once started, open your browser to:
- **Web UI**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs

## 🔧 Troubleshooting

### Common Issues

#### "Python is not recognized"
**Problem**: Python not in PATH
**Solution**: 
1. Reinstall Python with "Add to PATH" checked
2. Or manually add Python to PATH in System Environment Variables

#### "pip is not recognized"
**Problem**: pip not in PATH
**Solution**:
```cmd
python -m pip install -r requirements.txt
```

#### "uvicorn is not recognized"
**Problem**: uvicorn not installed
**Solution**:
```cmd
pip install uvicorn
```

#### Port 8000 already in use
**Problem**: Another service using port 8000
**Solutions**:
1. Stop other services using port 8000
2. Use different port: `uvicorn app.main:app --port 8001`
3. Find process: `netstat -ano | findstr :8000`

#### Import errors
**Problem**: Missing dependencies
**Solution**:
```cmd
pip install -r requirements.txt --force-reinstall
```

### Windows-Specific Issues

#### PowerShell Execution Policy
If PowerShell script won't run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Long Path Issues
If you get path too long errors:
1. Enable long paths in Windows 10/11
2. Or move project to shorter path like `C:\hsp\`

#### Antivirus Blocking
Some antivirus software may block Python scripts:
1. Add project folder to antivirus exclusions
2. Temporarily disable real-time protection during setup

## 📁 File Descriptions

| File | Purpose | When to Use |
|------|---------|-------------|
| `run_windows.cmd` | Simple startup | Daily development |
| `startup.bat` | Full validation | First-time setup, troubleshooting |
| `startup.ps1` | Advanced PowerShell | Modern Windows, advanced users |
| `run_system.sh` | Unix/Linux version | WSL, Git Bash |

## 🎯 Development Workflow

### For Daily Development:
1. Use `run_windows.cmd` for quick startup
2. Edit files in your preferred editor
3. Server auto-reloads on file changes
4. Test at http://localhost:8000

### For Model Training:
1. Add data to `data/raw/`
2. Run: `python src/data/make_dataset.py`
3. Run: `python src/models/train_model.py`
4. Restart server to load new model

### For UI Development:
1. Edit `static/index.html` for layout
2. Edit `static/script.js` for functionality
3. Edit `static/style.css` for styling
4. Changes reflect immediately (no restart needed)

## 🔍 Testing Your Setup

### Quick Test Commands:
```cmd
REM Test Python
python --version

REM Test pip
pip --version

REM Test FastAPI import
python -c "from app.main import app; print('FastAPI app loaded successfully')"

REM Test server manually
uvicorn app.main:app --host 127.0.0.1 --port 8001
```

### Test the Web UI:
1. Start server with any startup script
2. Open http://localhost:8000
3. Fill out the patient form
4. Click "Predict Readmission Risk"
5. Should see prediction results

## 📞 Getting Help

### If startup scripts fail:
1. Check the error messages carefully
2. Ensure all prerequisites are installed
3. Try the manual startup method
4. Check the troubleshooting section above

### For development issues:
1. Check `app/main.py` for API errors
2. Check browser console for JavaScript errors
3. Check server logs for detailed error messages

## 🎉 Success Indicators

You'll know everything is working when:
- ✅ Startup script completes without errors
- ✅ Browser opens to http://localhost:8000
- ✅ Web UI loads with the hospital prediction form
- ✅ API docs accessible at http://localhost:8000/docs
- ✅ Sample prediction returns results

## 🔄 Next Steps

Once running successfully:
1. Explore the web UI interface
2. Try the API documentation at `/docs`
3. Load sample data and make predictions
4. Review the code in `app/main.py` and `static/` files
5. Experiment with model training in the `notebooks/` directory

Happy coding! 🏥💻