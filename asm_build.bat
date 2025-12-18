@echo off
echo Building Sudoku Solver in Assembly...

REM Use the full path to NASM
set NASM_PATH="C:\Program Files\NASM\nasm.exe"

REM Assemble the source files
echo Assembling solver.asm...
%NASM_PATH% -f win64 solver.asm -o solver.obj
if %errorlevel% neq 0 (
    echo Failed to assemble solver.asm
    goto end
)

echo Assembling puzzles.asm...
%NASM_PATH% -f win64 puzzles.asm -o puzzles.obj
if %errorlevel% neq 0 (
    echo Failed to assemble puzzles.asm
    goto end
)

REM Link the object files
echo Linking object files...
gcc solver.obj puzzles.obj -o solver.exe
if %errorlevel% neq 0 (
    echo Failed to link object files
    goto end
)

echo Build successful!
echo Running solver.exe...
solver.exe

:end
pause