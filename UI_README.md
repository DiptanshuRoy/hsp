# Hospital Readmission Prediction UI

A modern, responsive web interface for the hospital readmission prediction system.

## Features

### 🎨 Modern Design
- Clean, professional healthcare-focused design
- Responsive layout that works on desktop, tablet, and mobile
- Bootstrap 5 styling with custom healthcare theme
- Font Awesome icons for better visual communication

### 📋 Comprehensive Form
- **Demographics**: Age and gender input
- **Hospital Stay**: Length of stay, lab procedures, visit history
- **Medical Information**: Number of diagnoses, A1C results
- **Medication Details**: Diabetes medication, changes, insulin status
- **Diagnosis Codes**: Primary diagnosis code indicators

### 🧠 Smart Predictions
- Real-time API integration with the ML model
- Clear risk assessment display (High Risk / Low Risk)
- Risk factor analysis and explanation
- Error handling for model unavailability

### 🔧 User Experience
- Form validation with visual feedback
- Loading states during prediction
- Sample data button for testing
- Responsive design for all devices
- Print-friendly result pages

## Usage

### Starting the Application
```bash
# Start the FastAPI server with UI
bash run_system.sh

# Or manually
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Accessing the UI
1. Open your browser to: http://localhost:8000
2. Fill in the patient information form
3. Click "Predict Readmission Risk"
4. View the results and risk factors

### Sample Data
Click the "Load Sample Data" button to populate the form with example patient data for testing.

## File Structure

```
static/
├── index.html      # Main UI page
├── script.js       # JavaScript functionality
└── style.css       # Additional custom styles
```

## API Integration

The UI communicates with the FastAPI backend through:
- `GET /` - Serves the main UI page
- `POST /predict` - Submits patient data for prediction
- `GET /docs` - API documentation (still available)

## Form Fields Mapping

| UI Field | API Field | Description |
|----------|-----------|-------------|
| Age | age | Patient age in years |
| Gender | gender_Male | 1 for Male, 0 for Female |
| Time in Hospital | time_in_hospital | Days spent in hospital |
| Lab Procedures | num_lab_procedures | Number of lab procedures performed |
| Outpatient Visits | number_outpatient | Number of outpatient visits |
| Emergency Visits | number_emergency | Number of emergency visits |
| Inpatient Visits | number_inpatient | Number of inpatient visits |
| Number of Diagnoses | num_diagnoses | Total number of diagnoses |
| A1C Result >7 | A1Cresult_7 | 1 if A1C > 7, 0 otherwise |
| Diabetes Medication | diabetesMed_Yes | 1 if on diabetes medication |
| Medication Change | change_Ch | 1 if medication changed |
| Insulin Steady | insulin_Steady | 1 if insulin dosage steady |
| Diagnosis 1 (250.83) | diag_1_250_83 | Primary diagnosis code presence |
| Diagnosis 2 (401.9) | diag_2_401_9 | Secondary diagnosis code presence |
| Diagnosis 3 (414.01) | diag_3_414_01 | Tertiary diagnosis code presence |

## Error Handling

The UI handles various error scenarios:
- **Model Not Available**: Shows service unavailable message
- **Network Errors**: Displays connection error information
- **Validation Errors**: Highlights invalid form fields
- **Server Errors**: Shows detailed error messages

## Customization

### Styling
- Modify `static/style.css` for custom styles
- Update Bootstrap theme variables in the HTML
- Change color scheme in the CSS custom properties

### Functionality
- Edit `static/script.js` to modify form behavior
- Add new form fields by updating both HTML and JavaScript
- Customize risk factor analysis in the `generateRiskFactors` function

## Browser Compatibility

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Security Considerations

- All form data is validated client-side and server-side
- No sensitive data is stored in browser storage
- HTTPS recommended for production deployment
- Input sanitization prevents XSS attacks

## Accessibility

- Semantic HTML structure
- ARIA labels for screen readers
- Keyboard navigation support
- High contrast color scheme
- Responsive text sizing