# Technology Stack

## Core Technologies
- **Python 3**: Primary programming language
- **XGBoost**: Machine learning framework for classification
- **FastAPI**: Web framework for prediction API
- **Pandas**: Data manipulation and analysis
- **Scikit-learn**: ML utilities and model evaluation
- **Jupyter**: Interactive development and experimentation

## Development Tools
- **Click**: Command-line interface creation
- **Flake8**: Code linting (max line length: 79, max complexity: 10)
- **Sphinx**: Documentation generation
- **Tox**: Testing automation
- **Joblib**: Model serialization

## Build System & Commands

The project uses a Makefile for common tasks:

```bash
# Environment setup
make requirements          # Install dependencies
make create_environment   # Create conda/virtualenv environment
make test_environment     # Verify Python environment

# Development workflow
make data                 # Process raw data into features
make clean               # Remove compiled Python files
make lint                # Run flake8 linting

# Data management (AWS S3)
make sync_data_to_s3     # Upload data to S3
make sync_data_from_s3   # Download data from S3
```

## Installation
```bash
pip install -e .         # Install project in development mode
pip install -r requirements.txt  # Install dependencies
```

## Code Quality Standards
- Follow PEP 8 with 79 character line limit
- Maximum cyclomatic complexity of 10
- Use type hints where appropriate
- Include docstrings for functions and classes