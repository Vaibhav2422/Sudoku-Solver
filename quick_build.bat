@echo off
echo Quick Build - Sudoku Solver

REM Assemble
nasm -f win64 solver.asm -o solver.obj
if errorlevel 1 (
    echo Assembly failed!
    pause
    exit /b 1
)

nasm -f win64 puzzles.asm -o puzzles.obj
if errorlevel 1 (
    echo Assembly failed!
    pause
    exit /b 1
)

REM Link
gcc solver.obj puzzles.obj -o solver.exe
if errorlevel 1 (
    echo Linking failed!
    pause
    exit /b 1
)

echo Build successful!
echo Running solver...
echo ==================
solver.exe
echo ==================
pause