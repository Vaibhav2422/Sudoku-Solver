@echo off
echo Building Sudoku Solver in Assembly...

REM Set the path to NASM
set PATH=%PATH%;C:\Program Files\NASM

REM Clean previous files
del solver.exe 2>nul

REM Assemble and link in one step
nasm -f win64 simple_asm_solver.asm -o simple_asm_solver.obj
if %errorlevel% neq 0 (
    echo Failed to assemble. Make sure NASM is installed correctly.
    goto end
)

gcc simple_asm_solver.obj -o simple_solver.exe
if %errorlevel% neq 0 (
    echo Failed to link. Make sure GCC is installed correctly.
    goto end
)

echo Build successful!
echo Running the Sudoku solver...
simple_solver.exe

:end
pause