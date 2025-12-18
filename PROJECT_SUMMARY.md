# Sudoku Solver in Assembly Language with Web Frontend

## Project Overview

This project implements a Sudoku puzzle solver using x86-64 assembly language for Windows, with an added web-based frontend interface. The solver uses a recursive backtracking algorithm to find solutions for 9x9 Sudoku puzzles, and the frontend provides a user-friendly interface for interacting with the solver.

## Features

- **Recursive Backtracking Algorithm**: Efficiently solves Sudoku puzzles using proven algorithm
- **Multiple Puzzle Support**: Can solve multiple puzzles in a single run
- **Formatted Output**: Displays solved puzzles with grid separators for better visualization
- **Complete Implementation**: Includes all necessary functions for solving Sudoku puzzles
- **Cross-Platform Build Scripts**: Batch files for easy building and running on Windows
- **Web-Based Frontend**: Interactive HTML interface for puzzle input and solution display

## Technical Details

### Assembly Implementation

The solver implements the following key functions in x86-64 assembly:

1. **solve()**: Main recursive function that implements backtracking
2. **find_empty()**: Locates the next empty cell in the puzzle
3. **is_valid()**: Checks if a number can be placed in a cell without violating Sudoku rules
4. **print_board_formatted()**: Displays the puzzle with grid separators
5. **print_board()**: Displays the puzzle in simple format

### Sudoku Rules Enforcement

The [is_valid](file:///C:/Users/Onkar%20Gawade/OneDrive/FOID-CP/SudokuSolver/solver.asm#L180-L274) function ensures that each number placement follows all Sudoku rules:
- No duplicate numbers in any row
- No duplicate numbers in any column
- No duplicate numbers in any 3x3 box

### Web Frontend Implementation

The frontend implements the same recursive backtracking algorithm in JavaScript, making it possible to solve puzzles directly in the browser without needing to compile the assembly code.

### File Structure

```
SudokuSolver/
├── solver.asm              # Main solver implementation
├── puzzles.asm             # Sample puzzle data
├── build.bat               # Main build script
├── fixed_build.bat         # Fixed build script
├── my_build.bat            # Alternative build script
├── simple_build.bat        # Simple build script
├── quick_build.bat         # Quick build and run
├── run.bat                 # Run executable
├── index.html              # Web frontend interface
├── styles.css              # Styling for web frontend
├── script.js               # JavaScript logic for web frontend
├── server.js               # Node.js server
├── package.json            # Node.js project configuration
├── start_server.bat        # Batch file to start Node.js web server
├── start_frontend.py       # Python server to serve frontend
├── start_frontend.bat      # Batch file to start Python web server
├── test_frontend.py        # Test script for frontend
├── 404.html                # Error page
├── README.txt              # Documentation
└── PROJECT_SUMMARY.md      # This file
```

## How to Use

### Prerequisites

1. NASM (Netwide Assembler) - for assembling the code
2. MinGW-w64 or GCC for Windows - for linking the object files
3. Python 3.x (for the web frontend - comes pre-installed on Windows 11)

### Building and Running the Assembly Version

1. Install the required tools:
   ```cmd
   winget install NASM.NASM
   winget install mingw-w64
   ```

2. Build and run:
   ```cmd
   .\build.bat
   ```

### Running the Web Frontend

Method 1 - Using Python (Recommended):
```cmd
.\start_frontend.bat
```
Then open your browser and go to http://localhost:8000

Method 2 - Using Node.js (Alternative):
```cmd
.\start_server.bat
```
Then open your browser and go to http://localhost:3000

### Adding Custom Puzzles

1. Edit `puzzles.asm`
2. Add your puzzle data in the same format as existing puzzles
3. Update the main function in `solver.asm` to solve your new puzzle

## Web Frontend Features

The web frontend provides:

- Interactive 9x9 Sudoku grid for puzzle input
- Sample puzzles to try (same as in the assembly version)
- Solution display with formatted grid
- Clear puzzle functionality
- Responsive design that works on different screen sizes
- Real-time validation of puzzle input

## Learning Value

This project demonstrates:
- Low-level programming concepts
- Recursion implementation in assembly
- Memory management and addressing modes
- Algorithm implementation without high-level language constructs
- Windows x64 calling conventions
- Assembly language optimization techniques
- Full-stack development (assembly backend with web frontend)
- Client-server architecture
- Cross-platform development considerations

## Troubleshooting

Common issues and solutions:
- **NASM not found**: Ensure NASM is installed and in PATH
- **GCC not found**: Ensure MinGW-w64 is installed and in PATH
- **Assembly errors**: Ensure using NASM 2.14 or later
- **Web server issues**: Ensure Python is installed and port 8000 is available

## Future Enhancements

Potential improvements:
- Add puzzle validation before solving
- Implement difficulty level detection
- Add timing measurements for performance analysis
- Create a puzzle generator
- Add support for different puzzle sizes
- Connect the web frontend to the assembly backend through a REST API
- Add puzzle saving/loading functionality
- Implement hints and step-by-step solving