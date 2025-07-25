# 🏥 Hospital Readmission Prediction System


An AI-powered web application that predicts the likelihood of hospital readmission within 30 days based on patient data and medical history. Built with machine learning (XGBoost) and deployed as a modern web interface using FastAPI.

## 🎯 **Project Overview**

This system helps healthcare providers identify high-risk patients who may require readmission within 30 days, enabling proactive care management and resource planning. The application combines machine learning predictions with an intuitive web interface designed for healthcare professionals.

### **Key Features**
- 🧠 **AI-Powered Predictions** - XGBoost machine learning model trained on hospital records
- 🌐 **Modern Web Interface** - Responsive UI for easy patient data entry and results visualization
- 📊 **Risk Factor Analysis** - Detailed breakdown of factors contributing to readmission risk
- 🔄 **Real-time API** - RESTful API for integration with existing hospital systems
- 📱 **Mobile-Friendly** - Works seamlessly on desktop, tablet, and mobile devices
- 🛡️ **Robust Error Handling** - Graceful handling of missing models and invalid data

### **Target Users**
- Healthcare providers and hospitals
- Discharge planning teams
- Quality improvement departments
- Healthcare data scientists and researchers

## 🚀 **Quick Start**

### **Option 1: Automated Setup (Recommended)**

#### For Unix/Linux/macOS:
```bash
bash run_system.sh
```

#### For Windows:
```cmd
# Simple startup
run_windows.cmd

# Or comprehensive setup
startup.bat

# Or PowerShell (advanced)
powershell -ExecutionPolicy Bypass -File startup.ps1
```

### **Option 2: Manual Setup**
```bash
# Install dependencies
pip install -r requirements.txt

# Start the server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### **Access the Application**
Once started, open your browser to:
- **🌐 Web UI**: http://localhost:8000 (Main Interface)
- **📚 API Documentation**: http://localhost:8000/docs
- **📋 OpenAPI Schema**: http://localhost:8000/openapi.json

## 🏗️ **System Architecture**

```
┌─────────────────┐    HTTP/JSON    ┌──────────────────┐    joblib    ┌─────────────────┐
│   Web Frontend  │ ──────────────► │   FastAPI        │ ───────────► │   ML Model      │
│   (HTML/JS/CSS) │                 │   Backend        │              │   (XGBoost)     │
└─────────────────┘                 └──────────────────┘              └─────────────────┘
        │                                   │                                  │
        │                                   │                                  │
        ▼                                   ▼                                  ▼
┌─────────────────┐                 ┌──────────────────┐              ┌─────────────────┐
│ Static Assets   │                 │ Pydantic Models  │              │ Trained Model   │
│ Bootstrap/FA    │                 │ Data Validation  │              │ (.pkl file)     │
└─────────────────┘                 └──────────────────┘              └─────────────────┘
```

## 📁 **Project Structure**

```
hospital_readmission_prediction/
├── 📱 Frontend & API
│   ├── app/
│   │   ├── __init__.py
│   │   └── main.py              # FastAPI application & API endpoints
│   └── static/
│       ├── index.html           # Web UI interface
│       ├── script.js            # Frontend JavaScript logic
│       └── style.css            # Custom styling
│
├── 🧠 Machine Learning
│   ├── models/                  # Trained model files (.pkl)
│   ├── notebooks/               # Jupyter notebooks for development
│   │   ├── exploration.ipynb    # Data exploration
│   │   ├── feature_eng.ipynb    # Feature engineering
│   │   └── model.ipynb          # Model training & evaluation
│   └── src/
│       ├── data/                # Data processing scripts
│       ├── features/            # Feature engineering
│       ├── models/              # Model training & prediction
│       └── visualization/       # Plotting and analysis
│
├── 📊 Data Management
│   ├── data/
│   │   ├── raw/                 # Original hospital data
│   │   ├── interim/             # Intermediate processed data
│   │   └── processed/           # Final datasets for modeling
│   └── references/              # Data dictionaries & documentation
│
├── 🛠️ Configuration & Setup
│   ├── requirements.txt         # Python dependencies
│   ├── setup.py                 # Package configuration
│   ├── run_system.sh           # Unix/Linux startup script
│   ├── startup.bat             # Windows batch startup
│   ├── startup.ps1             # Windows PowerShell startup
│   ├── run_windows.cmd         # Simple Windows startup
│   └── test_environment.py     # Environment validation
│
└── 📚 Documentation
    ├── README.md               # This file
    ├── WINDOWS_SETUP.md        # Windows-specific setup guide
    ├── UI_README.md            # Web interface documentation
    ├── docs/                   # Sphinx documentation
    └── reports/                # Generated analysis reports
```

## 🔧 **Technology Stack**

### **Core Technologies**
- **🐍 Python 3.7+** - Primary programming language
- **🤖 XGBoost** - Machine learning framework for classification
- **⚡ FastAPI** - Modern web framework for the prediction API
- **🐼 Pandas** - Data manipulation and analysis
- **🔬 Scikit-learn** - ML utilities and model evaluation
- **📓 Jupyter** - Interactive development and experimentation

### **Web Technologies**
- **🎨 Bootstrap 5** - Responsive UI framework
- **✨ Font Awesome** - Icons and visual elements
- **📱 Responsive Design** - Mobile-first approach
- **🔄 AJAX/Fetch API** - Real-time predictions without page reload

### **Development Tools**
- **🖱️ Click** - Command-line interface creation
- **📏 Flake8** - Code linting and quality assurance
- **📖 Sphinx** - Documentation generation
- **🧪 Tox** - Testing automation across environments
- **💾 Joblib** - Model serialization and loading

## 🎯 **Features in Detail**

### **Web Interface Features**
- **📋 Comprehensive Patient Form** - Organized sections for demographics, hospital stay details, medical information, medications, and diagnosis codes
- **🎨 Professional Healthcare Design** - Clean, medical-focused interface with intuitive navigation
- **⚡ Real-time Predictions** - Instant risk assessment without page reloads
- **📊 Risk Factor Analysis** - Detailed explanation of factors contributing to readmission risk
- **🔄 Sample Data Loading** - One-click sample data for testing and demonstration
- **✅ Form Validation** - Client-side and server-side validation with helpful error messages
- **📱 Mobile Responsive** - Optimized for use on tablets and smartphones
- **🖨️ Print-Friendly** - Clean printing of prediction results

### **API Features**
- **🔌 RESTful API** - Standard HTTP methods and JSON responses
- **📚 Interactive Documentation** - Auto-generated Swagger UI at `/docs`
- **🛡️ Data Validation** - Pydantic models ensure data integrity
- **⚠️ Error Handling** - Comprehensive error responses with helpful messages
- **🔄 Hot Reload** - Development server with automatic code reloading
- **📈 Scalable Architecture** - Designed for production deployment

### **Machine Learning Features**
- **🎯 Binary Classification** - Predicts readmission (Yes/No) with confidence
- **🔍 Feature Engineering** - 15 key features derived from hospital records
- **⚖️ Model Validation** - Cross-validation and performance metrics
- **💾 Model Persistence** - Serialized models for fast loading
- **🔄 Retraining Pipeline** - Easy model updates with new data

## 📊 **Model Information**

### **Input Features (15 total)**
| Category | Features | Description |
|----------|----------|-------------|
| **Demographics** | Age, Gender | Basic patient information |
| **Hospital Stay** | Time in hospital, Lab procedures, Visit history | Length and intensity of care |
| **Medical** | Number of diagnoses, A1C results | Medical complexity |
| **Medications** | Diabetes medication, Changes, Insulin status | Medication management |
| **Diagnoses** | Primary diagnosis codes (250.83, 401.9, 414.01) | Specific medical conditions |

### **Model Performance**
- **Algorithm**: XGBoost Classifier
- **Training Data**: Hospital readmission records
- **Features**: 15 engineered features from patient records
- **Output**: Binary classification (0 = Low Risk, 1 = High Risk)
- **Validation**: Cross-validation with performance metrics

### **Prediction Output**
```json
{
  "readmission_prediction": 0,  // 0 = Low Risk, 1 = High Risk
}
```

## 🛠️ **Development Guide**

### **Prerequisites**
- **Python 3.7+** with pip
- **Git** (for version control)
- **Modern web browser** (Chrome, Firefox, Safari, Edge)

### **Development Setup**
```bash
# Clone the repository
git clone <repository-url>
cd hospital_readmission_prediction

# Create virtual environment (recommended)
python -m venv hospital_ml_env
source hospital_ml_env/bin/activate  # Unix/Linux/macOS
# or
hospital_ml_env\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

# Start development server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### **Development Workflow**

#### **For API Development:**
1. Edit `app/main.py` for backend changes
2. Server automatically reloads on file changes
3. Test at http://localhost:8000/docs

#### **For UI Development:**
1. Edit `static/index.html` for layout changes
2. Edit `static/script.js` for functionality
3. Edit `static/style.css` for styling
4. Changes reflect immediately (no restart needed)

#### **For Model Development:**
1. Use `notebooks/` for experimentation
2. Run `python src/models/train_model.py` for training
3. New models saved to `models/xgb_model.pkl`
4. Restart server to load new model

### **Adding New Features**

#### **New API Endpoint:**
```python
# In app/main.py
@app.post("/new-endpoint")
def new_endpoint(data: NewDataModel):
    # Implementation here
    return {"result": "success"}
```

#### **New Form Field:**
```html
<!-- In static/index.html -->
<input type="number" id="new_field" required>
```

```javascript
// In static/script.js
function collectFormData() {
    return {
        // existing fields...
        new_field: parseFloat(document.getElementById('new_field').value),
    }
}
```

## 🧪 **Testing**

### **Manual Testing**
```bash
# Test environment
python test_environment.py

# Test API directly
curl -X POST "http://localhost:8000/predict" \
     -H "Content-Type: application/json" \
     -d '{"age": 65.0, "gender_Male": 1.0, ...}'

# Test web interface
# Open http://localhost:8000 and fill the form
```

### **Automated Testing**
```bash
# Run linting
flake8 src/ app/

# Run tests (if implemented)
python -m pytest tests/

# Test with tox
tox
```

## 📈 **Usage Examples**

### **Web Interface Usage**
1. **Start the application** using any startup script
2. **Open browser** to http://localhost:8000
3. **Fill patient information**:
   - Demographics: Age, gender
   - Hospital stay: Length, procedures, visits
   - Medical info: Diagnoses, A1C results
   - Medications: Diabetes meds, changes
   - Diagnosis codes: Primary conditions
4. **Click "Predict Readmission Risk"**
5. **Review results** with risk factors and recommendations

### **API Usage**
```python
import requests

# Patient data
patient_data = {
    "age": 72.0,
    "gender_Male": 1.0,
    "num_lab_procedures": 8.0,
    "time_in_hospital": 7.0,
    "number_outpatient": 2.0,
    "number_emergency": 1.0,
    "number_inpatient": 0.0,
    "num_diagnoses": 9.0,
    "A1Cresult_7": 1.0,
    "diabetesMed_Yes": 1.0,
    "change_Ch": 1.0,
    "insulin_Steady": 0.0,
    "diag_1_250_83": 1.0,
    "diag_2_401_9": 1.0,
    "diag_3_414_01": 0.0
}

# Make prediction
response = requests.post(
    "http://localhost:8000/predict",
    json=patient_data
)

result = response.json()
print(f"Readmission Risk: {'High' if result['readmission_prediction'] == 1 else 'Low'}")
```

### **Jupyter Notebook Usage**
```bash
# Start Jupyter
jupyter notebook

# Open notebooks/exploration.ipynb for data analysis
# Open notebooks/model.ipynb for model development
```

## 🔧 **Configuration**

### **Environment Variables**
Create a `.env` file for configuration:
```env
# Server configuration
HOST=0.0.0.0
PORT=8000
DEBUG=True

# Model configuration
MODEL_PATH=models/xgb_model.pkl
MODEL_RETRAIN_INTERVAL=24h

# Logging
LOG_LEVEL=INFO
```

### **Model Configuration**
```python
# In src/models/train_model.py
model_params = {
    'n_estimators': 200,
    'max_depth': 5,
    'learning_rate': 0.1,
    'random_state': 42
}
```

## 🚨 **Troubleshooting**

### **Common Issues**

#### **"Model not loaded" Error**
```bash
# Train a model first
python src/models/train_model.py

# Or use existing model
cp models/xg.pkl models/xgb_model.pkl

# Restart server
```

#### **Port 8000 in Use**
```bash
# Use different port
uvicorn app.main:app --port 8001

# Or find and kill process using port 8000
lsof -ti:8000 | xargs kill -9  # Unix/Linux/macOS
netstat -ano | findstr :8000   # Windows
```

#### **Import Errors**
```bash
# Reinstall dependencies
pip install -r requirements.txt --force-reinstall

# Check Python path
python -c "import sys; print(sys.path)"
```

#### **JavaScript Not Loading**
- Check browser console for errors
- Ensure static files are properly served
- Clear browser cache

### **Windows-Specific Issues**
See [WINDOWS_SETUP.md](WINDOWS_SETUP.md) for detailed Windows troubleshooting.

## 📚 **Documentation**

- **[WINDOWS_SETUP.md](WINDOWS_SETUP.md)** - Windows-specific setup and troubleshooting
- **[UI_README.md](UI_README.md)** - Detailed web interface documentation
- **`docs/`** - Sphinx-generated API documentation
- **`notebooks/`** - Jupyter notebooks with examples and analysis

## 🤝 **Contributing**

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes** following the coding standards
4. **Add tests** for new functionality
5. **Run linting** (`flake8 src/ app/`)
6. **Commit changes** (`git commit -m 'Add amazing feature'`)
7. **Push to branch** (`git push origin feature/amazing-feature`)
8. **Open a Pull Request**

### **Coding Standards**
- Follow PEP 8 with 79 character line limit
- Maximum cyclomatic complexity of 10
- Use type hints where appropriate
- Include docstrings for functions and classes


## 🙏 **Acknowledgments**

- Built using the [Cookiecutter Data Science](https://drivendata.github.io/cookiecutter-data-science/) project template
- FastAPI framework for modern API development
- XGBoost team for the machine learning framework
- Bootstrap team for the responsive UI framework
- Healthcare professionals who provided domain expertise

## 📞 **Support**

For support and questions:
- **Issues**: Open an issue on GitHub
- **Documentation**: Check the `docs/` directory
- **Examples**: See `notebooks/` for usage examples

---

**🏥 Making healthcare predictions accessible and actionable through modern technology.**