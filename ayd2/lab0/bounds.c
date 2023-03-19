#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#define ARRAY_SIZE 4

typedef struct {
    bool is_upperbound;
    bool is_lowerbound;
    bool exists;
    unsigned int where;
}bound_data;

bound_data check_bound(int value, int arr[], unsigned int length) {
    bound_data res;
    //
    // TODO: COMPLETAR    
    //
    //inicializo los valores de res
    res.is_lowerbound = true;
    res.is_upperbound = true;
    res.exists        = false;

    for(int i=0; i < (int)length; i++){
        if (value == arr[i]){
            res.exists= true;
            res.where = i; //guarda en where el ultimo indice donde se encontro a value en el arreglo ingresado    
        };
        
        if (value < arr[i] && res.is_upperbound){
            res.is_upperbound = 0;
        };
        if (value > arr[i] && res.is_lowerbound){
            res.is_lowerbound = 0;
        };
    }

    return res;
}


int main(void) {
    int a[ARRAY_SIZE]; //= {0, -1, 9, 4};
    int value;
    //
    // TODO: COMPLETAR - Pedir entrada al usuario
    for (int i=0; i < ARRAY_SIZE; i++){
    printf("Ingresa el valor del elemento %d del arreglo deseado: ", i);
    scanf("%d",&a[i]);
    };

    printf("Ingresa el valor del dato a analizar: ");
    scanf("%d",&value);
    
    bound_data result = check_bound(value, a, ARRAY_SIZE);

    printf("\nEs cota sup: %d\n", result.is_upperbound); 
    printf("Es cota inf: %d\n", result.is_lowerbound); 

    if(result.exists){
        printf("Es max: %d\n", result.is_upperbound); 
        printf("Es min: %d\n", result.is_lowerbound); 

        printf("Existe: %u\n", result.exists);      
        printf("Esta en el indice: %u\n", result.where);               
    }else{
        printf("Es max: %d\n", 0); 
        printf("Es min: %d\n", 0); 
    }
    
    return EXIT_SUCCESS;
}

