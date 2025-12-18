@echo off
echo Building and running Sudoku Solver in Assembly...

REM Set paths
set NASM_PATH="C:\Program Files\NASM\nasm.exe"

REM Clean up any existing files
del solver.obj puzzles.obj solver.exe 2>nul

REM Assemble the files
%NASM_PATH% -f win64 solver.asm
%NASM_PATH% -f win64 puzzles.asm

REM Link with Microsoft Linker (available with Visual Studio)
link /subsystem:console /entry:main solver.obj puzzles.obj /out:solver.exe

REM Run the executable if it was created successfully
if exist solver.exe (
    echo Running solver.exe...
    solver.exe
) else (
    echo Failed to create solver.exe
)

pause