@echo off
echo Simple Build - Sudoku Solver

REM Check if NASM exists in the system
where nasm >nul 2>&1
if %errorlevel% == 0 (
    set NASM_EXE=nasm
    goto nasm_found
)

REM Check if NASM exists in Program Files
if exist "C:\Program Files\NASM\nasm.exe" (
    set NASM_EXE="C:\Program Files\NASM\nasm.exe"
    goto nasm_found
)

REM Check if we have a local copy
if exist "nasm.exe" (
    set NASM_EXE=nasm.exe
    goto nasm_found
)

echo NASM not found. Please install NASM or place nasm.exe in this directory.
pause
exit /b 1

:nasm_found
echo Using NASM: %NASM_EXE%

REM Assemble
%NASM_EXE% -f win64 solver.asm -o solver.obj
if errorlevel 1 (
    echo Assembly failed!
    pause
    exit /b 1
)

%NASM_EXE% -f win64 puzzles.asm -o puzzles.obj
if errorlevel 1 (
    echo Assembly failed!
    pause
    exit /b 1
)

REM Check if GCC exists
where gcc >nul 2>&1
if %errorlevel% == 0 (
    set CC=gcc
    goto cc_found
)

echo GCC not found. Please install MinGW-w64.
pause
exit /b 1

:cc_found
echo Using GCC: %CC%

REM Link
%CC% -m64 solver.obj puzzles.obj -o solver.exe
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