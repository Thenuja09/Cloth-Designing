@echo off
echo ===============================================
echo     NewProject Django Quick Setup
echo ===============================================
echo.

echo Checking Python installation...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Python is available!
    goto :setup_project
) else (
    echo Python not found. Installing Python...
    goto :install_python
)

:install_python
echo.
echo Installing Python using winget...
winget install Python.Python.3.11 --accept-source-agreements --accept-package-agreements
if %errorlevel% equ 0 (
    echo ✓ Python installed successfully!
    echo.
    echo Please restart this command prompt and run the script again.
    echo This ensures Python is available in the PATH.
    pause
    exit /b 0
) else (
    echo ✗ Failed to install Python with winget
    echo.
    echo Manual installation required:
    echo 1. Go to https://www.python.org/downloads/
    echo 2. Download Python 3.8 or higher
    echo 3. Run installer and CHECK 'Add Python to PATH'
    echo 4. Restart command prompt and run this script again
    echo.
    set /p choice="Would you like to open the Python download page? (y/n): "
    if /i "%choice%"=="y" (
        start https://www.python.org/downloads/
    )
    pause
    exit /b 1
)

:setup_project
echo.
echo Setting up Django project...

echo Creating virtual environment...
python -m venv venv
if %errorlevel% neq 0 (
    echo ✗ Failed to create virtual environment
    pause
    exit /b 1
)
echo ✓ Virtual environment created

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ✗ Failed to install dependencies
    echo You can try manually: pip install -r requirements.txt
    pause
    exit /b 1
)
echo ✓ Dependencies installed

echo.
echo ===============================================
echo           Setup Complete!
echo ===============================================
echo.
echo Next steps:
echo 1. Install MariaDB from https://mariadb.org/download/
echo 2. Update database settings in newProject/settings.py
echo 3. Activate virtual environment: venv\Scripts\activate.bat
echo 4. Run migrations:
echo    python manage.py makemigrations
echo    python manage.py migrate
echo 5. Create superuser: python manage.py createsuperuser
echo 6. Run server: python manage.py runserver
echo.
echo For detailed instructions, see README.md
echo.
echo Happy coding! 🚀
echo.
pause

