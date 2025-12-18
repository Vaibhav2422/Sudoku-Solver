@echo off
echo Running Sudoku Solver...
echo.

REM Run the solver and pause to see output
solver.exe
echo.
echo If you don't see output above, the solver may be using Windows API functions
echo that don't display properly in this environment.
echo.
pause