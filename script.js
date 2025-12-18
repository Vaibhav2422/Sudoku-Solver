// Sample puzzles
const samplePuzzles = {
    puzzle1: [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ],
    puzzle2: [
        [0, 0, 3, 0, 2, 0, 6, 0, 0],
        [9, 0, 0, 3, 0, 5, 0, 0, 1],
        [0, 0, 1, 8, 0, 6, 4, 0, 0],
        [0, 0, 8, 1, 0, 2, 9, 0, 0],
        [7, 0, 0, 0, 0, 0, 0, 0, 8],
        [0, 0, 6, 7, 0, 8, 2, 0, 0],
        [0, 0, 2, 6, 0, 9, 5, 0, 0],
        [8, 0, 0, 2, 0, 3, 0, 0, 9],
        [0, 0, 5, 0, 1, 0, 3, 0, 0]
    ]
};

// Initialize the Sudoku grid
function initializeGrid() {
    const gridContainer = document.getElementById('sudoku-grid');
    gridContainer.innerHTML = '';
    
    for (let row = 0; row < 9; row++) {
        for (let col = 0; col < 9; col++) {
            const cell = document.createElement('div');
            cell.className = 'cell';
            cell.dataset.row = row;
            cell.dataset.col = col;
            
            const input = document.createElement('input');
            input.type = 'number';
            input.min = '0';
            input.max = '9';
            input.addEventListener('input', function() {
                if (this.value.length > 1) {
                    this.value = this.value.slice(0, 1);
                }
                if (this.value !== '' && (this.value < 0 || this.value > 9)) {
                    this.value = '';
                }
            });
            
            cell.appendChild(input);
            gridContainer.appendChild(cell);
        }
    }
}

// Load a sample puzzle
function loadSamplePuzzle(puzzle) {
    clearPuzzle();
    const gridContainer = document.getElementById('sudoku-grid');
    const cells = gridContainer.querySelectorAll('.cell input');
    
    for (let row = 0; row < 9; row++) {
        for (let col = 0; col < 9; col++) {
            const index = row * 9 + col;
            if (puzzle[row][col] !== 0) {
                cells[index].value = puzzle[row][col];
                cells[index].readOnly = true;
                cells[index].classList.add('pre-filled');
            }
        }
    }
}

// Clear the puzzle
function clearPuzzle() {
    const gridContainer = document.getElementById('sudoku-grid');
    const cells = gridContainer.querySelectorAll('.cell input');
    
    cells.forEach(cell => {
        cell.value = '';
        cell.readOnly = false;
        cell.classList.remove('pre-filled');
    });
    
    // Hide solution container
    document.getElementById('solution-container').style.display = 'none';
    document.getElementById('message').className = 'message';
    document.getElementById('message').textContent = '';
}

// Get puzzle from grid
function getPuzzleFromGrid() {
    const gridContainer = document.getElementById('sudoku-grid');
    const cells = gridContainer.querySelectorAll('.cell input');
    const puzzle = [];
    
    for (let row = 0; row < 9; row++) {
        const puzzleRow = [];
        for (let col = 0; col < 9; col++) {
            const index = row * 9 + col;
            const value = cells[index].value === '' ? 0 : parseInt(cells[index].value);
            puzzleRow.push(value);
        }
        puzzle.push(puzzleRow);
    }
    
    return puzzle;
}

// Validate puzzle
function validatePuzzle(puzzle) {
    // Check if puzzle is a 9x9 grid
    if (puzzle.length !== 9) return false;
    for (let row = 0; row < 9; row++) {
        if (puzzle[row].length !== 9) return false;
    }
    
    // Check if all values are between 0 and 9
    for (let row = 0; row < 9; row++) {
        for (let col = 0; col < 9; col++) {
            if (puzzle[row][col] < 0 || puzzle[row][col] > 9) return false;
        }
    }
    
    return true;
}

// Display solution
function displaySolution(solution) {
    const solutionContainer = document.getElementById('solution-container');
    const solutionGrid = document.getElementById('solution-grid');
    solutionGrid.innerHTML = '';
    
    for (let row = 0; row < 9; row++) {
        for (let col = 0; col < 9; col++) {
            const cell = document.createElement('div');
            cell.className = 'cell';
            cell.textContent = solution[row][col];
            solutionGrid.appendChild(cell);
        }
    }
    
    solutionContainer.style.display = 'block';
}

// Show message
function showMessage(text, type) {
    const messageElement = document.getElementById('message');
    messageElement.textContent = text;
    messageElement.className = `message ${type}`;
}

// Solve puzzle using backtracking algorithm (JavaScript implementation)
function solveSudoku(puzzle) {
    // Create a copy of the puzzle to avoid modifying the original
    const grid = puzzle.map(row => [...row]);
    
    // Find empty cell
    function findEmptyCell(grid) {
        for (let row = 0; row < 9; row++) {
            for (let col = 0; col < 9; col++) {
                if (grid[row][col] === 0) {
                    return [row, col];
                }
            }
        }
        return null;
    }
    
    // Check if number is valid in position
    function isValid(grid, row, col, num) {
        // Check row
        for (let i = 0; i < 9; i++) {
            if (grid[row][i] === num) return false;
        }
        
        // Check column
        for (let i = 0; i < 9; i++) {
            if (grid[i][col] === num) return false;
        }
        
        // Check 3x3 box
        const boxRow = Math.floor(row / 3) * 3;
        const boxCol = Math.floor(col / 3) * 3;
        for (let i = 0; i < 3; i++) {
            for (let j = 0; j < 3; j++) {
                if (grid[boxRow + i][boxCol + j] === num) return false;
            }
        }
        
        return true;
    }
    
    // Recursive solve function
    function solve() {
        const emptyCell = findEmptyCell(grid);
        if (!emptyCell) return true; // Puzzle solved
        
        const [row, col] = emptyCell;
        
        for (let num = 1; num <= 9; num++) {
            if (isValid(grid, row, col, num)) {
                grid[row][col] = num;
                
                if (solve()) {
                    return true;
                }
                
                // Backtrack
                grid[row][col] = 0;
            }
        }
        
        return false; // No solution found
    }
    
    // Solve the puzzle
    if (solve()) {
        return grid;
    } else {
        return null; // No solution exists
    }
}

// Solve button event handler
function solvePuzzle() {
    try {
        const puzzle = getPuzzleFromGrid();
        
        if (!validatePuzzle(puzzle)) {
            showMessage('Invalid puzzle. Please check your input.', 'error');
            return;
        }
        
        // Check if puzzle has at least one cell filled
        let hasInput = false;
        for (let row = 0; row < 9; row++) {
            for (let col = 0; col < 9; col++) {
                if (puzzle[row][col] !== 0) {
                    hasInput = true;
                    break;
                }
            }
            if (hasInput) break;
        }
        
        if (!hasInput) {
            showMessage('Please enter at least one number in the puzzle.', 'error');
            return;
        }
        
        // Solve the puzzle
        const solution = solveSudoku(puzzle);
        
        if (solution) {
            displaySolution(solution);
            showMessage('Puzzle solved successfully!', 'success');
        } else {
            showMessage('No solution found for this puzzle.', 'error');
        }
    } catch (error) {
        showMessage('An error occurred while solving the puzzle.', 'error');
        console.error(error);
    }
}

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    initializeGrid();
    
    // Event listeners
    document.getElementById('solve-btn').addEventListener('click', solvePuzzle);
    document.getElementById('clear-btn').addEventListener('click', clearPuzzle);
    document.getElementById('sample1-btn').addEventListener('click', () => loadSamplePuzzle(samplePuzzles.puzzle1));
    document.getElementById('sample2-btn').addEventListener('click', () => loadSamplePuzzle(samplePuzzles.puzzle2));
});