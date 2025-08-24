# PowerShell script to activate NewProject Virtual Environment

Write-Host "Activating NewProject Virtual Environment..." -ForegroundColor Green
Write-Host ""

# Check if virtual environment exists
if (-not (Test-Path "venv\Scripts\Activate.ps1")) {
    Write-Host "Virtual environment not found!" -ForegroundColor Red
    Write-Host "Please run setup.py first to create the virtual environment." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to continue"
    exit 1
}

# Activate virtual environment
try {
    & "venv\Scripts\Activate.ps1"
    Write-Host ""
    Write-Host "Virtual environment activated successfully!" -ForegroundColor Green
    Write-Host "You can now run Django commands like:" -ForegroundColor Cyan
    Write-Host "  python manage.py runserver" -ForegroundColor White
    Write-Host "  python manage.py makemigrations" -ForegroundColor White
    Write-Host "  python manage.py migrate" -ForegroundColor White
    Write-Host ""
    Write-Host "To deactivate, type: deactivate" -ForegroundColor Yellow
    Write-Host ""
} catch {
    Write-Host "Error activating virtual environment: $_" -ForegroundColor Red
    Read-Host "Press Enter to continue"
}

