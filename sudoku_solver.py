def print_board(board):
    """Print the Sudoku board with grid separators"""
    for i in range(9):
        if i % 3 == 0 and i != 0:
            print("+-------+-------+-------+")
        
        for j in range(9):
            if j % 3 == 0 and j != 0:
                print("| ", end="")
            print(f"{board[i][j]} " if board[i][j] != 0 else ". ", end="")
        print("|")
    print("+-------+-------+-------+")

def find_empty(board):
    """Find the next empty cell in the board"""
    for i in range(9):
        for j in range(9):
            if board[i][j] == 0:
                return (i, j)
    return None

def is_valid(board, num, pos):
    """Check if placing num at pos is valid"""
    # Check row
    for j in range(9):
        if board[pos[0]][j] == num and pos[1] != j:
            return False
    
    # Check column
    for i in range(9):
        if board[i][pos[1]] == num and pos[0] != i:
            return False
    
    # Check 3x3 box
    box_x = pos[1] // 3
    box_y = pos[0] // 3
    
    for i in range(box_y * 3, box_y * 3 + 3):
        for j in range(box_x * 3, box_x * 3 + 3):
            if board[i][j] == num and (i, j) != pos:
                return False
    
    return True

def solve(board):
    """Solve the Sudoku puzzle using backtracking"""
    find = find_empty(board)
    if not find:
        return True
    else:
        row, col = find
    
    for i in range(1, 10):
        if is_valid(board, i, (row, col)):
            board[row][col] = i
            
            if solve(board):
                return True
            
            board[row][col] = 0
    
    return False

# Sample puzzles
puzzle1 = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]

puzzle2 = [
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

if __name__ == "__main__":
    print("Solving Puzzle 1:")
    print_board(puzzle1)
    
    # Create a copy to solve
    puzzle1_copy = [row[:] for row in puzzle1]
    
    if solve(puzzle1_copy):
        print("\nSolved Sudoku:")
        print_board(puzzle1_copy)
    else:
        print("\nNo solution found.")
    
    print("\n\nSolving Puzzle 2:")
    print_board(puzzle2)
    
    # Create a copy to solve
    puzzle2_copy = [row[:] for row in puzzle2]
    
    if solve(puzzle2_copy):
        print("\nSolved Sudoku:")
        print_board(puzzle2_copy)
    else:
        print("\nNo solution found.")