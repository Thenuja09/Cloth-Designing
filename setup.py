#!/usr/bin/env python3
"""
Setup script for NewProject Django application.
This script helps set up the project environment and dependencies.
"""

import os
import sys
import subprocess
import platform

def print_banner():
    """Print project setup banner"""
    print("=" * 60)
    print("           NewProject Django Setup")
    print("=" * 60)
    print("Setting up your Django project with MariaDB integration...")
    print()

def check_python():
    """Check if Python is installed and accessible"""
    print("Checking Python installation...")
    try:
        result = subprocess.run([sys.executable, '--version'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print(f"✓ Python found: {result.stdout.strip()}")
            return True
        else:
            print("✗ Python not accessible")
            return False
    except Exception as e:
        print(f"✗ Error checking Python: {e}")
        return False

def create_virtual_environment():
    """Create Python virtual environment"""
    print("\nCreating virtual environment...")
    venv_path = "venv"
    
    if os.path.exists(venv_path):
        print(f"✓ Virtual environment already exists at {venv_path}")
        return True
    
    try:
        subprocess.run([sys.executable, '-m', 'venv', venv_path], check=True)
        print(f"✓ Virtual environment created at {venv_path}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ Failed to create virtual environment: {e}")
        return False

def get_activate_command():
    """Get the appropriate activate command for the current OS"""
    if platform.system() == "Windows":
        return "venv\\Scripts\\activate"
    else:
        return "source venv/bin/activate"

def install_dependencies():
    """Install project dependencies"""
    print("\nInstalling dependencies...")
    
    # Get the appropriate pip command
    if platform.system() == "Windows":
        pip_cmd = "venv\\Scripts\\pip"
    else:
        pip_cmd = "venv/bin/pip"
    
    try:
        # Upgrade pip first
        subprocess.run([pip_cmd, "install", "--upgrade", "pip"], check=True)
        print("✓ Pip upgraded")
        
        # Install requirements
        subprocess.run([pip_cmd, "install", "-r", "requirements.txt"], check=True)
        print("✓ Dependencies installed")
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ Failed to install dependencies: {e}")
        return False

def create_directories():
    """Create necessary directories"""
    print("\nCreating project directories...")
    
    directories = [
        "static",
        "media",
        "media/profile_pics",
        "templates",
        "templates/main"
    ]
    
    for directory in directories:
        if not os.path.exists(directory):
            os.makedirs(directory)
            print(f"✓ Created directory: {directory}")
        else:
            print(f"✓ Directory exists: {directory}")

def print_next_steps():
    """Print next steps for the user"""
    print("\n" + "=" * 60)
    print("                    Setup Complete!")
    print("=" * 60)
    print("\nNext steps:")
    print("1. Install Python 3.8+ if not already installed")
    print("2. Install MariaDB and create a database")
    print("3. Activate virtual environment:")
    print(f"   {get_activate_command()}")
    print("4. Update database settings in newProject/settings.py")
    print("5. Run migrations:")
    print("   python manage.py makemigrations")
    print("   python manage.py migrate")
    print("6. Create superuser:")
    print("   python manage.py createsuperuser")
    print("7. Run development server:")
    print("   python manage.py runserver")
    print("\nFor detailed instructions, see README.md")
    print("\nHappy coding! 🚀")

def main():
    """Main setup function"""
    print_banner()
    
    # Check Python
    if not check_python():
        print("\nPlease install Python 3.8+ and try again.")
        print("Download from: https://www.python.org/downloads/")
        return
    
    # Create virtual environment
    if not create_virtual_environment():
        print("\nFailed to create virtual environment.")
        return
    
    # Create directories
    create_directories()
    
    # Install dependencies
    if not install_dependencies():
        print("\nFailed to install dependencies.")
        print("Please activate virtual environment and run:")
        print("pip install -r requirements.txt")
        return
    
    print_next_steps()

if __name__ == "__main__":
    main()

