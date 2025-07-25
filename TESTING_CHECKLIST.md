# 🧪 Beta Testing Checklist

## Pre-Testing Setup
- [ ] Successfully cloned the repository
- [ ] Switched to `beta` branch (`git branch` shows `* beta`)
- [ ] Python 3.7+ installed and accessible
- [ ] All dependencies installed without errors

## Startup Testing
- [ ] **Unix/Linux/macOS**: `bash run_system.sh` works without errors
- [ ] **Windows**: `run_windows.cmd` or `startup.bat` works without errors
- [ ] Server starts successfully on port 8000
- [ ] No critical error messages in startup logs

## Web Interface Testing
- [ ] **Main UI**: http://localhost:8000 loads correctly
- [ ] **API Docs**: http://localhost:8000/docs is accessible
- [ ] Web interface displays properly (no broken layout)
- [ ] All form fields are present and functional
- [ ] "Load Sample Data" button works
- [ ] Form validation works (try submitting empty form)

## Prediction Testing
### With Model Present:
- [ ] Fill out patient form with sample data
- [ ] Click "Predict Readmission Risk"
- [ ] Prediction result displays (High Risk or Low Risk)
- [ ] Risk factors analysis shows up
- [ ] No JavaScript errors in browser console

### Without Model (if applicable):
- [ ] Appropriate error message when model is missing
- [ ] System doesn't crash when model unavailable
- [ ] Clear instructions provided for model training

## API Testing (Optional)
- [ ] API documentation at `/docs` works
- [ ] Can make test API calls through Swagger UI
- [ ] API returns proper JSON responses
- [ ] Error handling works for invalid data

## Cross-Platform Testing
### Desktop:
- [ ] Works on Chrome/Chromium
- [ ] Works on Firefox
- [ ] Works on Safari (macOS)
- [ ] Works on Edge (Windows)

### Mobile (if possible):
- [ ] Responsive design works on mobile
- [ ] Form is usable on smaller screens
- [ ] Results display properly on mobile

## Performance Testing
- [ ] Application starts within reasonable time (< 30 seconds)
- [ ] Predictions return quickly (< 5 seconds)
- [ ] No memory leaks during extended use
- [ ] Server remains stable during testing

## Documentation Testing
- [ ] README.md is clear and helpful
- [ ] Setup instructions work as described
- [ ] Troubleshooting section addresses common issues
- [ ] Code examples in documentation work

## Issues Found
**List any issues, bugs, or suggestions here:**

1. Issue: [Description]
   - Steps to reproduce:
   - Expected behavior:
   - Actual behavior:
   - Browser/OS:

2. Issue: [Description]
   - Steps to reproduce:
   - Expected behavior:
   - Actual behavior:
   - Browser/OS:

## Overall Assessment
- [ ] **PASS**: Ready for production/main branch
- [ ] **NEEDS WORK**: Issues need to be addressed before merge
- [ ] **FAIL**: Major problems prevent deployment

## Additional Notes
[Any additional feedback, suggestions, or observations]

---

**Tester**: [Your friend's name]
**Date**: [Testing date]
**Environment**: [OS, Python version, Browser]
**Branch**: beta
**Commit**: [git log --oneline -1]