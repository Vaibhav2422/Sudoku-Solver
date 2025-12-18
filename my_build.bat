@echo off
echo Building Sudoku Solver...

REM Try to assemble using nasm directly
nasm -f win64 solver.asm -o solver.obj
if %errorlevel% neq 0 (
    echo Failed to assemble solver.asm
    echo Trying with full path to NASM...
    "C:\Program Files\NASM\nasm.exe" -f win64 solver.asm -o solver.obj
    if %errorlevel% neq 0 (
        echo Failed to assemble solver.asm with full path
        goto build_failed
    )
)

nasm -f win64 puzzles.asm -o puzzles.obj
if %errorlevel% neq 0 (
    echo Failed to assemble puzzles.asm
    goto build_failed
)

REM Try to link using gcc
gcc solver.obj puzzles.obj -o my_solver.exe
if %errorlevel% neq 0 (
    echo Failed to link with gcc
    echo Trying with mingw32...
    mingw32-gcc solver.obj puzzles.obj -o my_solver.exe
    if %errorlevel% neq 0 (
        echo Failed to link with mingw32-gcc
        goto build_failed
    )
)

echo Build successful!
echo Running the solver...
my_solver.exe
goto end

:build_failed
echo Build failed. Please make sure NASM and GCC are installed.
echo You can download NASM from https://www.nasm.us/
echo You can download MinGW-w64 from http://mingw-w64.org/

:end
pause