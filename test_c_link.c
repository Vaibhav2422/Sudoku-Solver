#include <stdio.h>

// Declare the external assembly functions
extern unsigned char puzzle1[81];
extern unsigned char puzzle2[81];
int solve(unsigned char* board);
int find_empty(unsigned char* board);
int is_valid(unsigned char* board, int index, int num);

void print_board(unsigned char* board) {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            printf("%d ", board[i * 9 + j]);
        }
        printf("\n");
    }
}

int main() {
    printf("Testing Sudoku Solver...\n");
    
    // Print the first puzzle
    printf("Puzzle 1:\n");
    print_board(puzzle1);
    
    // Try to solve it
    int result = solve(puzzle1);
    if (result == 1) {
        printf("Solved!\n");
        print_board(puzzle1);
    } else {
        printf("No solution found.\n");
    }
    
    return 0;
}