@echo off
echo Activating NewProject Virtual Environment...
echo.

REM Check if virtual environment exists
if not exist "venv\Scripts\activate.bat" (
    echo Virtual environment not found!
    echo Please run setup.py first to create the virtual environment.
    echo.
    pause
    exit /b 1
)

REM Activate virtual environment
call venv\Scripts\activate.bat

echo.
echo Virtual environment activated successfully!
echo You can now run Django commands like:
echo   python manage.py runserver
echo   python manage.py makemigrations
echo   python manage.py migrate
echo.
echo To deactivate, type: deactivate
echo.

REM Keep the command prompt open
cmd /k

