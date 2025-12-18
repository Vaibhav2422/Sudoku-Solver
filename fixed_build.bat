@echo off
echo Assembling and linking Sudoku Solver...

REM Set paths directly without quotes in the variable
set NASM_PATH=C:\Program Files\NASM\nasm.exe

REM Assemble the source files
"%NASM_PATH%" -f win64 solver.asm -o solver.obj
if errorlevel 1 (
    echo Failed to assemble solver.asm
    goto build_failed
)

"%NASM_PATH%" -f win64 puzzles.asm -o puzzles.obj
if errorlevel 1 (
    echo Failed to assemble puzzles.asm
    goto build_failed
)

REM Link the object files
gcc solver.obj puzzles.obj -o solver.exe
if errorlevel 1 (
    echo Failed to link object files
    goto build_failed
)

echo Build successful!
echo Run solver.exe to see the Sudoku solution
goto end

:build_failed
echo Build failed.

:end
pause