# Set the working directory to the script's directory
Set-Location -Path "c:\Users\Onkar Gawade\OneDrive\FOID-CP\SudokuSolver"

Write-Host "Starting Sudoku Solver Frontend Server..."
Write-Host "======================================="

# Check if Python is installed
try {
    $pythonVersion = python --version 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Python is not installed or not in PATH"
        Write-Host "Please install Python from https://python.org/"
        Write-Host ""
        pause
        exit 1
    }
} catch {
    Write-Host "Python is not installed or not in PATH"
    Write-Host "Please install Python from https://python.org/"
    Write-Host ""
    pause
    exit 1
}

# Check if start_frontend.py exists
if (-not (Test-Path "start_frontend.py")) {
    Write-Host "start_frontend.py not found"
    Write-Host ""
    pause
    exit 1
}

# Start the Python server
Write-Host ""
Write-Host "Starting server on http://localhost:8001"
Write-Host "Press Ctrl+C to stop the server"
Write-Host ""
python "start_frontend.py"