@echo off
echo Starting Sudoku Solver Frontend Server...
echo =======================================

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed or not in PATH
    echo Please install Python from https://python.org/
    echo.
    pause
    exit /b 1
)

REM Check if start_frontend.py exists
if not exist "start_frontend.py" (
    echo start_frontend.py not found
    echo.
    pause
    exit /b 1
)

REM Start the Python server
echo.
echo Starting server on http://localhost:8000
echo Press Ctrl+C to stop the server
echo.
python "start_frontend.py"