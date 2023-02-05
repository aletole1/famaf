.ifndef data_s
.equ data_s, 0

/*
    Este archivo contiene toda la información relacionada con valores 
    que se utilizan en diversos puntos a lo largo del programa
*/

.data

// Colores
azul:        .word 0x003366
negro:       .word 0x000000
blanco:      .word 0xFFFFFF
piel:        .word 0xFECD95
rosa_claro:  .word 0xFF99FF
rosa_oscuro: .word 0xEF3694
rosa_cachete:.word 0xF59798
gris:        .word 0x999999


    //colores del arcoiris
naranja:     .word 0xFD9800
rojo:        .word 0xFE0000
amarillo:    .word 0xFDFD00
verde:       .word 0x33FD00
celeste:     .word 0x0098FC
violeta:     .word 0x6633FD

//posiciones de algunos elementos, arreglo de 2 elementos (ejeX,ejeY)
estrella1:   .word 500, 35
estrella2:   .word 60,  90
estrella3:   .word 550, 330
estrella4:   .word 150, 400
estrella5:   .word 450, 135

patas_:      .word 160, 300
cuerpo_:     .word 150, 150
cara_:       .word 270, 206
arcoiris_:   .word 0, 165


// Pantalla 
/*
    Algunas constantes relacionadas con el tamaño de los píxeles y la pantalla.
*/
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.endif
