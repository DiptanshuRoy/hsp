# Project Structure

This project follows the Cookiecutter Data Science template structure for ML projects.

## Directory Organization

```
├── app/                   # FastAPI application
│   └── app.main.py       # Main API endpoint for predictions
├── src/                  # Source code modules
│   ├── data/            # Data processing scripts
│   ├── features/        # Feature engineering scripts  
│   ├── models/          # Model training and prediction
│   └── visualization/   # Plotting and visualization
├── notebooks/           # Jupyter notebooks for exploration
├── models/              # Serialized trained models (.pkl files)
├── data/               # Data storage (not in repo)
│   ├── raw/            # Original immutable data
│   ├── interim/        # Intermediate transformed data
│   ├── processed/      # Final datasets for modeling
│   └── external/       # Third-party data sources
├── docs/               # Sphinx documentation
├── reports/            # Generated analysis outputs
│   └── figures/        # Charts and visualizations
└── references/         # Data dictionaries and manuals
```

## Code Organization Patterns

### Module Structure
- Each `src/` subdirectory is a Python package with `__init__.py`
- Use relative imports within packages
- Main entry points use Click for CLI interfaces

### Naming Conventions
- **Notebooks**: `{number}-{initials}-{description}.ipynb` (e.g., `1.0-jqp-initial-data-exploration`)
- **Scripts**: Descriptive names like `make_dataset.py`, `train_model.py`
- **Models**: Save as `.pkl` files in `models/` directory
- **Data**: Organize by processing stage (raw → interim → processed)

### File Paths
- Use `pathlib.Path` for cross-platform compatibility
- Reference project root as `Path(__file__).resolve().parents[2]`
- Store processed data in `data/processed/` as Parquet files
- Load environment variables from `.env` using `python-dotenv`

### API Structure
- FastAPI app in `app/app.main.py`
- Use Pydantic models for request/response validation
- Load models at startup, not per request
- Return simple JSON responses with prediction results