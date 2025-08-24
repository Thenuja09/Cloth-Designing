# PowerShell script to install Python and set up NewProject Django application
# Run this script as Administrator for best results

param(
    [switch]$SkipPythonInstall,
    [switch]$Force
)

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "    NewProject Django Setup Script" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if Python is available
function Test-PythonAvailable {
    try {
        $pythonVersion = python --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
            return $true
        }
    } catch {
        # Python not in PATH
    }
    
    try {
        $pythonVersion = py --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
            return $true
        }
    } catch {
        # py launcher not available
    }
    
    return $false
}

# Function to install Python using winget
function Install-PythonWithWinget {
    Write-Host "Installing Python using winget..." -ForegroundColor Yellow
    
    try {
        # Check if winget is available
        $wingetVersion = winget --version 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "✗ winget is not available. Please install App Installer from Microsoft Store." -ForegroundColor Red
            return $false
        }
        
        Write-Host "Installing Python 3.11..." -ForegroundColor Yellow
        winget install Python.Python.3.11 --accept-source-agreements --accept-package-agreements
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Python installed successfully!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "✗ Failed to install Python with winget" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "✗ Error installing Python: $_" -ForegroundColor Red
        return $false
    }
}

# Function to install Python manually
function Install-PythonManually {
    Write-Host "Manual Python installation required:" -ForegroundColor Yellow
    Write-Host "1. Go to https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "2. Download Python 3.8 or higher" -ForegroundColor White
    Write-Host "3. Run installer and CHECK 'Add Python to PATH'" -ForegroundColor White
    Write-Host "4. Restart PowerShell and run this script again" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Would you like to open the Python download page? (y/n)"
    if ($choice -eq 'y' -or $choice -eq 'Y') {
        Start-Process "https://www.python.org/downloads/"
    }
    
    return $false
}

# Function to create virtual environment
function Create-VirtualEnvironment {
    Write-Host "Creating Python virtual environment..." -ForegroundColor Yellow
    
    try {
        if (Test-Path "venv") {
            if ($Force) {
                Remove-Item "venv" -Recurse -Force
                Write-Host "Removed existing virtual environment" -ForegroundColor Yellow
            } else {
                Write-Host "✓ Virtual environment already exists" -ForegroundColor Green
                return $true
            }
        }
        
        python -m venv venv
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Virtual environment created successfully" -ForegroundColor Green
            return $true
        } else {
            Write-Host "✗ Failed to create virtual environment" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "✗ Error creating virtual environment: $_" -ForegroundColor Red
        return $false
    }
}

# Function to install dependencies
function Install-Dependencies {
    Write-Host "Installing project dependencies..." -ForegroundColor Yellow
    
    try {
        # Activate virtual environment
        & ".\venv\Scripts\Activate.ps1"
        
        # Upgrade pip
        python -m pip install --upgrade pip
        
        # Install requirements
        pip install -r requirements.txt
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
            return $true
        } else {
            Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "✗ Error installing dependencies: $_" -ForegroundColor Red
        return $false
    }
}

# Function to create necessary directories
function Create-ProjectDirectories {
    Write-Host "Creating project directories..." -ForegroundColor Yellow
    
    $directories = @(
        "static",
        "media",
        "media/profile_pics",
        "templates",
        "templates/main"
    )
    
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Host "✓ Created directory: $dir" -ForegroundColor Green
        } else {
            Write-Host "✓ Directory exists: $dir" -ForegroundColor Green
        }
    }
}

# Function to show next steps
function Show-NextSteps {
    Write-Host ""
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host "           Setup Complete!" -ForegroundColor Green
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor White
    Write-Host "1. Install MariaDB from https://mariadb.org/download/" -ForegroundColor Yellow
    Write-Host "2. Update database settings in newProject/settings.py" -ForegroundColor Yellow
    Write-Host "3. Activate virtual environment: .\venv\Scripts\Activate.ps1" -ForegroundColor Cyan
    Write-Host "4. Run migrations:" -ForegroundColor Cyan
    Write-Host "   python manage.py makemigrations" -ForegroundColor White
    Write-Host "   python manage.py migrate" -ForegroundColor White
    Write-Host "5. Create superuser: python manage.py createsuperuser" -ForegroundColor Cyan
    Write-Host "6. Run server: python manage.py runserver" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "For detailed instructions, see README.md" -ForegroundColor White
    Write-Host ""
    Write-Host "Happy coding! 🚀" -ForegroundColor Green
}

# Main execution
Write-Host "Checking Python installation..." -ForegroundColor Yellow

if (Test-PythonAvailable) {
    Write-Host "Python is already available!" -ForegroundColor Green
} elseif ($SkipPythonInstall) {
    Write-Host "Skipping Python installation as requested" -ForegroundColor Yellow
} else {
    Write-Host "Python not found. Attempting to install..." -ForegroundColor Yellow
    
    # Try winget first
    if (-not (Install-PythonWithWinget)) {
        # Fall back to manual installation
        Install-PythonManually
        exit 1
    }
    
    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    # Test Python again
    if (-not (Test-PythonAvailable)) {
        Write-Host "Python installation completed but not accessible. Please restart PowerShell and try again." -ForegroundColor Red
        exit 1
    }
}

# Create project directories
Create-ProjectDirectories

# Create virtual environment
if (-not (Create-VirtualEnvironment)) {
    Write-Host "Failed to create virtual environment. Exiting." -ForegroundColor Red
    exit 1
}

# Install dependencies
if (-not (Install-Dependencies)) {
    Write-Host "Failed to install dependencies. You can try manually:" -ForegroundColor Red
    Write-Host "1. Activate virtual environment: .\venv\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host "2. Install requirements: pip install -r requirements.txt" -ForegroundColor Yellow
    exit 1
}

# Show next steps
Show-NextSteps

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

