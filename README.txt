Sudoku Solver in Assembly (NASM x86-64, Windows)
=================================================

Author: Onkar Gawade
Language: Assembly (NASM)
Platform: Windows 10/11 x64

Description:
------------
A Sudoku solver implemented using recursive backtracking in Assembly.
It reads hardcoded 9x9 Sudoku puzzles and prints the solved boards.

Features:
---------
- Solves multiple Sudoku puzzles in one run
- Formatted output with grid separators for better visualization
- Recursive backtracking algorithm implementation
- Validity checking for rows, columns, and 3x3 boxes
- Support for multiple puzzle inputs
- Web-based frontend interface
- Python alternative implementation

Folder Contents:
----------------
solver.asm              - Main program logic and functions.
puzzles.asm             - Contains sample Sudoku puzzles.
build.bat               - Main build script with comprehensive tool detection.
quick_build.bat         - Simplified build script for quick builds.
run_assembly.bat        - Build script using Microsoft Linker.
run_solver.bat          - Script that creates a C program to display puzzles.
rebuild.bat             - Alternative build script.
index.html              - Web frontend interface.
styles.css              - Styling for the web frontend.
script.js               - JavaScript logic for the web frontend.
server.js               - Node.js server to serve the frontend.
package.json            - Node.js project configuration.
start_server.bat        - Batch file to start the Node.js web server.
start_frontend.py       - Python server to serve the frontend.
start_frontend.bat      - Batch file to start the Python web server.
start_frontend.ps1      - PowerShell script to start the Python web server.
test_frontend.py        - Test script for frontend.
sudoku_solver.py        - Python implementation of the Sudoku solver.
run_python.bat          - Batch file to run the Python solver.
404.html                - Error page for missing files.
README.txt              - Project documentation.
PROJECT_SUMMARY.md      - High-level project overview.

Tools Required:
---------------
1. NASM assembler (Netwide Assembler) - for assembly version
2. MinGW-w64 (Minimalist GNU for Windows) or GCC for Windows - for assembly version
3. Python 3.x (for the web frontend and Python alternative - comes pre-installed on Windows 11)

Installation of Required Tools:
-------------------------------
Option 1 - Using winget (Windows Package Manager):
1. Open PowerShell as Administrator
2. Install NASM: winget install NASM.NASM
3. Install MinGW-w64: winget install mingw-w64

Option 2 - Manual Installation:
1. Download and install NASM from https://www.nasm.us/
2. Download and install MinGW-w64 from http://mingw-w64.org/

Note: Python 3.x is already installed on Windows 11. For older Windows versions, download from https://python.org/

Verifying Installation:
-----------------------
After installation, verify the tools are available:
1. Open a new Command Prompt or PowerShell
2. Run: nasm -v
3. Run: gcc -v
4. Run: python --version

To Build and Run the Assembly Version:
--------------------------------------
Method 1 - Automated (Recommended):
1. Open PowerShell or CMD in this folder.
2. Run: .\build.bat
3. The solver will assemble, link, and execute automatically.

Method 2 - Quick Build:
1. Run: .\quick_build.bat
2. This will quickly assemble, link, and run the solver.

Method 3 - Using Microsoft Linker:
1. Run: .\run_assembly.bat
2. This uses Microsoft's linker instead of GCC.

Method 4 - Using C program to display:
1. Run: .\run_solver.bat
2. This creates and runs a C program to display the puzzle.

Method 5 - Alternative build:
1. Run: .\rebuild.bat
2. This is an alternative build script.

To Run the Python Version:
--------------------------
1. Run: .\run_python.bat
2. This runs the Python implementation of the Sudoku solver.

To Run the Web Frontend:
------------------------
Method 1 - Using Python (Recommended):
1. Run: .\start_frontend.bat or .\start_frontend.ps1
2. Open your browser and go to http://localhost:8001
3. Use the web interface to solve Sudoku puzzles

Method 2 - Using Node.js (Alternative):
1. Make sure Node.js is installed (node -v should work)
2. Run: .\start_server.bat
3. Open your browser and go to http://localhost:3000
4. Use the web interface to solve Sudoku puzzles

Web Frontend Features:
----------------------
- Interactive Sudoku grid for puzzle input
- Sample puzzles to try
- Solution display with formatted grid
- Clear puzzle functionality
- Responsive design that works on different screen sizes

Expected Output (Assembly Version):
-----------------------------------
Solving Puzzle 1:
Solved Sudoku:
+-------+-------+-------+
| 5 3 4 | 6 7 8 | 9 1 2 |
| 6 7 2 | 1 9 5 | 3 4 8 |
| 1 9 8 | 3 4 2 | 5 6 7 |
+-------+-------+-------+
| 8 5 9 | 7 6 1 | 4 2 3 |
| 4 2 6 | 8 5 3 | 7 9 1 |
| 7 1 3 | 9 2 4 | 8 5 6 |
+-------+-------+-------+
| 9 6 1 | 5 3 7 | 2 8 4 |
| 2 8 7 | 4 1 9 | 6 3 5 |
| 3 4 5 | 2 8 6 | 1 7 9 |
+-------+-------+-------+

Solving Puzzle 2:
Solved Sudoku:
+-------+-------+-------+
| 4 8 3 | 9 2 1 | 6 5 7 |
| 9 6 7 | 3 4 5 | 8 2 1 |
| 2 5 1 | 8 7 6 | 4 9 3 |
+-------+-------+-------+
| 5 4 8 | 1 3 2 | 9 7 6 |
| 7 2 9 | 5 6 4 | 1 3 8 |
| 1 3 6 | 7 9 8 | 2 4 5 |
+-------+-------+-------+
| 3 7 2 | 6 8 9 | 5 1 4 |
| 8 1 4 | 2 5 3 | 7 6 9 |
| 6 9 5 | 4 1 7 | 3 8 2 |
+-------+-------+-------+

Project Structure:
------------------
SudokuSolver/
│
├── solver.asm              ; main assembly source with solver logic
├── puzzles.asm             ; puzzle data definitions
├── build.bat               ; automated build & run script
├── quick_build.bat         ; simplified build script
├── run_assembly.bat        ; build script using Microsoft Linker
├── run_solver.bat          ; script that creates C program to display puzzles
├── rebuild.bat             ; alternative build script
├── index.html              ; web frontend interface
├── styles.css              ; styling for web frontend
├── script.js               ; JavaScript logic for web frontend
├── server.js               ; Node.js server
├── package.json            ; Node.js project configuration
├── start_server.bat        ; batch file to start Node.js web server
├── start_frontend.py       ; Python server to serve frontend
├── start_frontend.bat      ; batch file to start Python web server
├── start_frontend.ps1      ; PowerShell script to start Python web server
├── test_frontend.py        ; test script for frontend
├── sudoku_solver.py        ; Python implementation of Sudoku solver
├── run_python.bat          ; batch file to run Python solver
├── 404.html                ; error page
├── README.txt              ; documentation
└── PROJECT_SUMMARY.md      ; project overview

Algorithm Used:
---------------
- Recursive backtracking
- Functions:
  * solve() - recursive solver using backtracking
  * find_empty() - finds next empty cell (value = 0)
  * is_valid() - checks if a number can be placed in a cell
  * print_board_formatted() - displays the board with grid separators
  * print_board() - displays the board in simple format

How the Algorithm Works:
------------------------
1. Find an empty cell (represented by 0)
2. Try numbers 1-9 in that cell
3. For each number, check if it's valid (doesn't violate Sudoku rules)
4. If valid, place the number and recursively solve the rest of the puzzle
5. If the recursive call returns success, we're done
6. If not, backtrack (remove the number) and try the next number
7. If all numbers have been tried and none work, return failure

Adding Your Own Puzzles:
------------------------
1. Open puzzles.asm (for assembly version)
2. Add a new global declaration at the top (e.g., global puzzle3)
3. Add your puzzle data in the same format as the existing puzzles
4. Modify solver.asm to solve your new puzzle

For the Python version:
1. Open sudoku_solver.py
2. Add your puzzle to the list of sample puzzles
3. Modify the main function to solve your new puzzle

Troubleshooting:
----------------
1. If you get "nasm is not recognized":
   - Make sure NASM is installed
   - Add NASM to your PATH environment variable
   - Or use the full path to nasm.exe

2. If you get "gcc is not recognized":
   - Make sure MinGW-w64 or GCC is installed
   - Add GCC to your PATH environment variable
   - Or use the full path to gcc.exe

3. If you get assembly errors:
   - Make sure you're using NASM 2.14 or later
   - Check that the source files are not corrupted

4. If the web frontend doesn't start:
   - Make sure Python is installed (comes with Windows 11)
   - Check that all required files are present
   - Ensure port 8001 is not being used by another application
   - Try using the Node.js server instead (port 3000)

5. If the assembly version doesn't build:
   - Try using the Python version as an alternative
   - Run: .\run_python.bat

License:
--------
For academic use and learning purposes.