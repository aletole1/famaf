#include <stdlib.h>  /* exit() y EXIT_FAILURE */
#include <stdio.h>   /* printf(), scanf()     */
#include <stdbool.h> /* Tipo bool             */

#include <assert.h>  /* assert() */

#define N 5
#define CELL_MAX (N * N - 1)

void print_sep(int length) {
    printf("\t ");
    for (int i=0; i < length;i++) printf("................");
    printf("\n");

}

void print_board(char board[N][N])
{
    int cell = 0;

    print_sep(N);
    for (int row = 0; row < N; ++row) {
        for (int column = 0; column < N; ++column) {
            printf("\t | %d: %c ", cell, board[row][column]);
            ++cell;
        }
        printf("\t | \n");
        print_sep(N);
    }
}

char get_winner(char board[N][N])
{
    char winner = '-';

    /*
    Formas de ganar:
        - Horizontalmente N en linea 
        - Verticalmente N en columna
        - Diagonales
    */ 
    
    //Chequea horizontalmente:

    for(int row = 0; row < N && winner=='-';row++){ 
        bool win = true;
        for(int colum = 0; colum < N-1; colum++){
            // if(board[row][colum]!=board[row][colum+1] && win)
                win = win && board[row][colum]==board[row][colum+1]; 
        }
        winner = win || winner != '-' ? board[row][0] : winner ; 
    }

    //Chequea vecticalmente:

    for(int colum = 0; colum < N && winner=='-';colum++){  
        bool win = true;
        for(int row = 0; row < N-1; row++){
            win = win && board[row][colum]==board[row+1][colum]; 
        }
        winner = win || winner != '-' ? board[0][colum] : winner ; 
    }
    //Chequea diagonalmente:
    
    if ( winner=='-')
    {
        bool win = true;
        for(int row=0,colum=0; row< N-1; row++,colum++){
            win = win && (board[row][colum] == board[row+1][colum+1]) && board[row][colum]!='-';
        }
        winner = win ? board[0][0] : winner;
    }

    if ( winner=='-')
    {
        bool win = true;
        for(int row=0,colum=0; row< N-1; row++,colum++){
            win = win && (board[(N-1)-row][colum] == board[(N-1)-(row+1)][colum+1]) && board[(N-1)-row][colum]!='-';
        }
        winner = win ? board[N-1][0] : winner;
    }
    
    return winner;
}

bool has_free_cell(char board[N][N])
{
    bool free_cell=false;
    for (int row = 0; row < N; ++row) {
        for (int colum = 0; colum < N; ++colum) {
            if(board[row][colum] == '-') free_cell = true;
        }}
    return free_cell;
}

int main(void)
{
    printf("TicTacToe\n");

    char board[N][N]; //= {{ '-', '-', '-' },{ '-', '-', '-' },{ '-', '-', '-' }};

    for(int row=0; row<N;row++){
        for(int colum=0; colum<N;colum++){
            board[row][colum] = '-';
        }
    }
    char turn = 'X';
    char winner = '-';
    int cell = 0;
    while (winner == '-' && has_free_cell(board)) {
        print_board(board);
        printf("\nTurno %c - Elija posición (número del 0 al %d): ", turn,
               CELL_MAX);
        int scanf_result = scanf("%d", &cell);
        if (scanf_result <= 0) {
            printf("Error al leer un número desde teclado\n");
            exit(EXIT_FAILURE);
        }
        if (cell >= 0 && cell <= CELL_MAX) {
            int row = cell / N;
            int colum = cell % N;
            if (board[row][colum] == '-') {
                board[row][colum] = turn;
                turn = turn == 'X' ? 'O' : 'X';
                winner = get_winner(board);
            } else {
                printf("\nCelda ocupada!\n");
            }
        } else {
            printf("\nCelda inválida!\n");
        }
    }
    print_board(board);
    if (winner == '-') {
        printf("Empate!\n");
    } else {
        printf("Ganó %c\n", winner);
    }
    return 0;
}
