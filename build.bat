@echo off
echo Assembling and linking Sudoku Solver...

REM ------------------ Resolve NASM ------------------
set NASM_EXE=nasm
where nasm >nul 2>&1
if errorlevel 1 goto try_nasm_default
goto have_nasm

:try_nasm_default
if exist "C:\Program Files\NASM\nasm.exe" (
    set NASM_EXE="C:\Program Files\NASM\nasm.exe"
    goto have_nasm
)
if exist "C:\ProgramData\chocolatey\lib\nasm\tools\nasm.exe\tools" (
    set NASM_EXE=C:\ProgramData\chocolatey\lib\nasm\tools\nasm.exe\tools
    goto have_nasm
)
goto no_nasm

:have_nasm

REM ------------------ Resolve CC (prefer MinGW GCC, fallback to Clang) ------------------
set CC=

REM 1) Prefer MinGW-w64 GCC if available
where x86_64-w64-mingw32-gcc >nul 2>&1
if not errorlevel 1 set CC=x86_64-w64-mingw32-gcc

if "%CC%"=="" (
    where gcc >nul 2>&1
    if not errorlevel 1 set CC=gcc
)

REM 2) Fallback to LLVM Clang (works if MSVC/WinSDK available)
if "%CC%"=="" (
    if exist "C:\Program Files\LLVM\bin\clang.exe" set CC=C:\Program Files\LLVM\bin\clang.exe
)

if "%CC%"=="" (
    where clang >nul 2>&1
    if not errorlevel 1 set CC=clang
)

if "%CC%"=="" (
    echo.
    echo ERROR: Neither GCC nor Clang found.
    echo - Option A: Install MinGW ^(recommended^): MSYS2 + mingw-w64 toolchain
    echo - Option B: Install LLVM ^(Clang^) + MSVC/Windows SDK
    goto end
)

REM If CC is a full path, accept it; otherwise verify it's on PATH
if exist "%CC%" goto have_cc
where %CC% >nul 2>&1
if errorlevel 1 goto no_cc

:have_cc

REM ------------------ Assemble ------------------
"%NASM_EXE%" -f win64 solver.asm -o solver.obj
if errorlevel 1 goto build_fail
"%NASM_EXE%" -f win64 puzzles.asm -o puzzles.obj
if errorlevel 1 goto build_fail

REM ------------------ Link ------------------
set ARCH_FLAG=
if /I "%CC%"=="x86_64-w64-mingw32-gcc" set ARCH_FLAG=-m64
if /I "%CC%"=="gcc" set ARCH_FLAG=-m64

REM Link
"%CC%" %ARCH_FLAG% solver.obj puzzles.obj -o solver.exe
if errorlevel 1 goto build_fail

echo.
echo Running Sudoku Solver...
echo -------------------------------------
solver.exe
echo -------------------------------------
goto end

:no_nasm
echo.
echo ERROR: NASM assembler not found.
echo - Install NASM: winget install NASM.NASM
goto end

:no_cc
echo.
echo ERROR: Neither GCC nor Clang found.
echo - Install LLVM (Clang): winget install LLVM.LLVM
goto end

:build_fail
echo Build failed.
goto end

:end
pause
