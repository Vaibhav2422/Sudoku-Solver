@echo off
echo Running Sudoku Solver...

REM Create a simple test program to display the puzzle
echo #include ^<stdio.h^> > display.c
echo extern unsigned char puzzle1[81]; >> display.c
echo int main() { >> display.c
echo     printf("Sudoku Puzzle:\n"); >> display.c
echo     for (int i = 0; i ^< 9; i++) { >> display.c
echo         for (int j = 0; j ^< 9; j++) { >> display.c
echo             printf("%%d ", puzzle1[i*9 + j]); >> display.c
echo         } >> display.c
echo         printf("\n"); >> display.c
echo     } >> display.c
echo     return 0; >> display.c
echo } >> display.c

REM Compile and run the display program
gcc display.c puzzles.obj -o display.exe
display.exe

echo.
echo Done!