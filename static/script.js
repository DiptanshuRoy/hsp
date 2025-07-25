// Hospital Readmission Prediction UI JavaScript

document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('predictionForm');
    const resultCard = document.getElementById('resultCard');
    const resultContent = document.getElementById('resultContent');
    const loadingSpan = document.querySelector('.loading');
    const normalSpan = document.querySelector('.normal');

    // Form submission handler
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        // Show loading state
        showLoading(true);
        
        // Collect form data
        const formData = collectFormData();
        
        try {
            // Make prediction request
            const response = await fetch('/predict', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            });

            const result = await response.json();
            
            if (response.ok) {
                displayResult(result.readmission_prediction, formData);
            } else {
                displayError(result.detail || 'An error occurred during prediction');
            }
        } catch (error) {
            console.error('Error:', error);
            displayError('Network error: Unable to connect to the prediction service');
        } finally {
            showLoading(false);
        }
    });

    function collectFormData() {
        return {
            age: parseFloat(document.getElementById('age').value),
            gender_Male: parseFloat(document.getElementById('gender').value),
            num_lab_procedures: parseFloat(document.getElementById('num_lab_procedures').value),
            time_in_hospital: parseFloat(document.getElementById('time_in_hospital').value),
            number_outpatient: parseFloat(document.getElementById('number_outpatient').value),
            number_emergency: parseFloat(document.getElementById('number_emergency').value),
            number_inpatient: parseFloat(document.getElementById('number_inpatient').value),
            num_diagnoses: parseFloat(document.getElementById('num_diagnoses').value),
            A1Cresult_7: parseFloat(document.getElementById('A1Cresult_7').value),
            diabetesMed_Yes: parseFloat(document.getElementById('diabetesMed_Yes').value),
            change_Ch: parseFloat(document.getElementById('change_Ch').value),
            insulin_Steady: parseFloat(document.getElementById('insulin_Steady').value),
            diag_1_250_83: parseFloat(document.getElementById('diag_1_250_83').value),
            diag_2_401_9: parseFloat(document.getElementById('diag_2_401_9').value),
            diag_3_414_01: parseFloat(document.getElementById('diag_3_414_01').value)
        };
    }

    function showLoading(isLoading) {
        if (isLoading) {
            loadingSpan.style.display = 'inline';
            normalSpan.style.display = 'none';
            form.querySelector('button[type="submit"]').disabled = true;
        } else {
            loadingSpan.style.display = 'none';
            normalSpan.style.display = 'inline';
            form.querySelector('button[type="submit"]').disabled = false;
        }
    }

    function displayResult(prediction, patientData) {
        const isHighRisk = prediction === 1;
        const riskLevel = isHighRisk ? 'High Risk' : 'Low Risk';
        const riskColor = isHighRisk ? 'danger' : 'success';
        const riskIcon = isHighRisk ? 'fas fa-exclamation-triangle' : 'fas fa-check-circle';
        
        resultContent.innerHTML = `
            <div class="mb-3">
                <i class="${riskIcon} fa-3x text-${riskColor}"></i>
            </div>
            <h4 class="text-${riskColor} mb-3">${riskLevel}</h4>
            <p class="mb-3">
                ${isHighRisk 
                    ? 'This patient has a higher likelihood of readmission within 30 days.' 
                    : 'This patient has a lower likelihood of readmission within 30 days.'}
            </p>
            <div class="alert alert-${riskColor} alert-dismissible fade show" role="alert">
                <strong>Prediction:</strong> ${prediction === 1 ? 'Readmission Likely' : 'Readmission Unlikely'}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            ${generateRiskFactors(patientData, isHighRisk)}
            <div class="mt-3">
                <small class="text-muted">
                    <i class="fas fa-clock me-1"></i>
                    Prediction made on ${new Date().toLocaleString()}
                </small>
            </div>
        `;
        
        // Update card styling
        resultCard.className = `card ${isHighRisk ? 'result-card high-risk' : 'result-card'}`;
        resultCard.style.display = 'block';
        
        // Scroll to result
        resultCard.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }

    function generateRiskFactors(data, isHighRisk) {
        const factors = [];
        
        // Age factor
        if (data.age > 65) {
            factors.push('Advanced age (>65 years)');
        }
        
        // Hospital stay length
        if (data.time_in_hospital > 7) {
            factors.push('Extended hospital stay (>7 days)');
        }
        
        // Multiple visits
        if (data.number_emergency > 0) {
            factors.push('Recent emergency visits');
        }
        
        // Diabetes management
        if (data.diabetesMed_Yes === 1 && data.A1Cresult_7 === 1) {
            factors.push('Diabetes with elevated A1C');
        }
        
        // Medication changes
        if (data.change_Ch === 1) {
            factors.push('Recent medication changes');
        }
        
        // Multiple diagnoses
        if (data.num_diagnoses > 5) {
            factors.push('Multiple diagnoses (>5)');
        }

        if (factors.length === 0) {
            return '';
        }

        const factorType = isHighRisk ? 'Risk Factors' : 'Protective Factors';
        const factorIcon = isHighRisk ? 'fas fa-exclamation-circle text-warning' : 'fas fa-shield-alt text-success';
        
        return `
            <div class="mt-3">
                <h6><i class="${factorIcon} me-2"></i>${factorType} Identified:</h6>
                <ul class="list-unstyled small">
                    ${factors.map(factor => `<li><i class="fas fa-chevron-right me-2"></i>${factor}</li>`).join('')}
                </ul>
            </div>
        `;
    }

    function displayError(message) {
        resultContent.innerHTML = `
            <div class="mb-3">
                <i class="fas fa-exclamation-triangle fa-3x text-warning"></i>
            </div>
            <h4 class="text-warning mb-3">Prediction Error</h4>
            <div class="alert alert-warning" role="alert">
                <strong>Error:</strong> ${message}
            </div>
            <p class="small text-muted">
                Please check that the prediction service is running and try again.
            </p>
        `;
        
        resultCard.className = 'card';
        resultCard.style.display = 'block';
        resultCard.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }

    // Add form validation feedback
    const inputs = form.querySelectorAll('input, select');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.checkValidity()) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        });
    });

    // Sample data button for testing
    const sampleButton = document.createElement('button');
    sampleButton.type = 'button';
    sampleButton.className = 'btn btn-outline-secondary btn-sm me-2';
    sampleButton.innerHTML = '<i class="fas fa-flask me-1"></i>Load Sample Data';
    sampleButton.onclick = loadSampleData;
    
    const submitButton = form.querySelector('button[type="submit"]');
    submitButton.parentNode.insertBefore(sampleButton, submitButton);

    function loadSampleData() {
        // High-risk sample patient
        document.getElementById('age').value = '75';
        document.getElementById('gender').value = '1';
        document.getElementById('num_lab_procedures').value = '8';
        document.getElementById('time_in_hospital').value = '10';
        document.getElementById('number_outpatient').value = '2';
        document.getElementById('number_emergency').value = '1';
        document.getElementById('number_inpatient').value = '1';
        document.getElementById('num_diagnoses').value = '9';
        document.getElementById('A1Cresult_7').value = '1';
        document.getElementById('diabetesMed_Yes').value = '1';
        document.getElementById('change_Ch').value = '1';
        document.getElementById('insulin_Steady').value = '0';
        document.getElementById('diag_1_250_83').value = '1';
        document.getElementById('diag_2_401_9').value = '1';
        document.getElementById('diag_3_414_01').value = '0';
        
        // Trigger validation styling
        inputs.forEach(input => {
            input.classList.add('is-valid');
        });
    }
});