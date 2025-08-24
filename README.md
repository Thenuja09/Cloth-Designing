# NewProject - Django Web Application

This is a Django web application project with MariaDB database integration.

## Prerequisites

Before setting up this project, you need to install:

1. **Python 3.8+** - Download from [python.org](https://www.python.org/downloads/)
2. **MariaDB** - Download from [mariadb.org](https://mariadb.org/download/)
3. **Git** (optional) - Download from [git-scm.com](https://git-scm.com/)

## Installation Steps

### 1. Install Python
- Download Python 3.8+ from [python.org](https://www.python.org/downloads/)
- During installation, make sure to check "Add Python to PATH"
- Verify installation: `python --version`

### 2. Install MariaDB
- Download MariaDB from [mariadb.org](https://mariadb.org/download/)
- Follow the installation wizard
- Note down the root password you set during installation
- Start MariaDB service

### 3. Clone/Download this project
- Extract the project files to your desired location

### 4. Set up Virtual Environment
```bash
# Navigate to project directory
cd "F:\Thenuja\AI Web project"

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate

# On macOS/Linux:
source venv/bin/activate
```

### 5. Install Dependencies
```bash
# Make sure virtual environment is activated
pip install -r requirements.txt
```

### 6. Configure Database
- Open `newProject/settings.py`
- Update database settings with your MariaDB credentials
- Create database: `CREATE DATABASE newproject_db;`

### 7. Run Migrations
```bash
python manage.py makemigrations
python manage.py migrate
```

### 8. Create Superuser
```bash
python manage.py createsuperuser
```

### 9. Run Development Server
```bash
python manage.py runserver
```

## Project Structure

```
newProject/
├── manage.py
├── newProject/
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── requirements.txt
├── README.md
└── venv/
```

## Features

- Django 4.2+ framework
- MariaDB database integration
- Virtual environment setup
- Basic project structure

## Development

- Activate virtual environment before development: `venv\Scripts\activate`
- Install new packages: `pip install package_name`
- Update requirements: `pip freeze > requirements.txt`

## Database Configuration

The project is configured to use MariaDB. Update the database settings in `newProject/settings.py`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'newproject_db',
        'USER': 'your_username',
        'PASSWORD': 'your_password',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

## Troubleshooting

- If Python is not recognized, ensure it's added to PATH
- If MariaDB connection fails, check if the service is running
- For virtual environment issues, try recreating it: `rm -rf venv && python -m venv venv`

## Support

For issues and questions, please refer to:
- [Django Documentation](https://docs.djangoproject.com/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)

