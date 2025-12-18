#include <stdio.h> 
extern unsigned char puzzle1[81]; 
int main() { 
    printf("Sudoku Puzzle:\n"); 
    for (int i = 0; i < 9; i++) { 
        for (int j = 0; j < 9; j++) { 
            printf("%d ", puzzle1[i*9 + j]); 
        } 
        printf("\n"); 
    } 
    return 0; 
} 
