@echo off
echo Rebuilding Sudoku Solver...

REM Clean up any existing files
del solver.obj puzzles.obj solver.exe 2>nul

REM Use the full path to NASM
echo Assembling solver.asm...
"C:\Program Files\NASM\nasm.exe" -f win64 solver.asm -o solver.obj
if errorlevel 1 (
    echo Failed to assemble solver.asm
    goto end
)

echo Assembling puzzles.asm...
"C:\Program Files\NASM\nasm.exe" -f win64 puzzles.asm -o puzzles.obj
if errorlevel 1 (
    echo Failed to assemble puzzles.asm
    goto end
)

REM Link the object files
echo Linking object files...
gcc -m64 solver.obj puzzles.obj -o solver.exe
if errorlevel 1 (
    echo Failed to link object files
    goto end
)

echo Build successful!
echo Running solver.exe...
solver.exe

:end
pause