@echo off
echo Starting Sudoku Solver Web Server...
echo ====================================

REM Check if Node.js is installed
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    echo.
    pause
    exit /b 1
)

REM Check if package.json exists
if not exist "package.json" (
    echo package.json not found
    echo.
    pause
    exit /b 1
)

REM Install dependencies (if any)
echo Installing dependencies...
npm install

REM Start the server
echo.
echo Starting server on http://localhost:3000
echo Press Ctrl+C to stop the server
echo.
node server.js