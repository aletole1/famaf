.ifndef formas_s
.equ formas_s, 0

.include "data.s"


/* 
Me devuelve x0 apuntando al primer pixel de donde quiero empezar a pintar, en donde:
	X0 = posición en el ejeX
	X1 = posición en el ejeY
*/

pixel:
	//direccion =  direccion del inicio + 4*( x + y*640 )
	
	madd x0, x1, x25, x0 //		x0 =  x + y*640
	lsl x0, x0, 2      //		4 * x0
	add x0,x27,x0 	  //	direccion del inicio + x0*4

	br lr


/*
Para formar un rectangulo necesito pasarle a la función 5 argumentos:
	X0 = posición en el ejeX
	X1 = posición en el ejeY
	X2 = tamaño de ancho 'x' 
	X3 = tamaño de alto 'y' 
	X4 = color
entonces, cuando llamo a 'rectangulo' antes tengo que definir estos argumentos.
*/

rectangulo: 

	sub sp, sp, 8
	stur lr, [sp]
 

	bl pixel

	mov x10, x3 
	
	rectloop1:
		mov x9, x0
		sub x11, x10, x3			//  
		mul x11, x11,x25 		   // 
		lsl x11, x11, 2			  // 
		add x9, x11, x9 	   	 // Dirección = Dirección de inicio + (4 * N)

		mov x11, x2
	rectloop0:
   		stur w4, [x9]	   	// Set color of pixel N
		add  x9, x9, 4	   		// Next pixel
		sub  x11, x11, #1  		// decrement X counter
		cbnz x11, rectloop0	   	// If not end row jump
		

		sub x3,x3, #1	 	  	// Decrement Y counter
		cbnz x3,rectloop1		// if not last row, jump


	ldur lr, [sp]
	add sp,sp,8

	br lr

	/*
	4 estrellas, cada estrella tiene 5 etapas:
	 			1 punto
				4 puntos en cruz
				4 puntos en cruz mas alejados
				9 puntos, cruz con punto en el medio
				8 puntos en forma circular 
	Las estrellas estan dentro de un arreglo de 35x35 pixels, cada "punto" de la estrella es de 5x5 pixels.
	La posición que le es pasada a la función es del pixel de arriba a la izq, y obtengo el pixel de arriba a la izq de cada punto.  

	 */
puntoblanco:
		sub sp, sp, 8
		stur lr, [sp]

		ldur w0,[x17]
    	ldur w1,[x17,4]
		add w0,w0,w12
		add w1,w1,w13
		mov x2,5
		mov x3,5
		ldr x4, blanco
		bl rectangulo
		
		ldur lr, [sp]
		add sp,sp,8
		br lr	

puntorosa:	
		sub sp, sp, 8
		stur lr, [sp]
		ldur w0, [x17]
		ldur w1, [x17,4]
		add w0,w0,w12
		add w1,w1,w13
		mov x2, 10
		mov x3, 10
		ldr x4, rosa_oscuro
		bl rectangulo

		ldur lr, [sp]
		add sp,sp,8
		br lr	

rect_arcoiris:
	sub sp, sp,8
	stur lr, [sp]
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0,w0,w12
	add w1,w1,w13
	add w1,w1,w14
	mov x2,	45
	mov x3, 20
	bl rectangulo

	ldur lr,[sp]
	add sp,sp,8
	br lr	
formaestrella1:
		sub sp, sp, 8
		stur lr, [sp]

		mov w12,15
		mov w13,15
		bl puntoblanco

		ldur lr, [sp]
		add sp,sp,8
		br lr	

formaestrella2:
		sub sp, sp, 8
		stur lr, [sp]

		//rect de arriba
		mov w12,15
		mov w13,10
		bl puntoblanco

		//rect de izq
		mov w12,10
		mov w13,15
		bl puntoblanco

		//rect de der
		mov w12,20
		mov w13,15
		bl puntoblanco

		// rect de abajo
		mov w12,15
		mov w13,20
		bl puntoblanco

		ldur lr, [sp]
		add sp,sp,8
		br lr	

formaestrella3:
		sub sp, sp, 8
		stur lr, [sp]

		//rect de arriba
		mov w12,15
		mov w13,0
		bl puntoblanco
		//rect de izq

		mov w12,0
		mov w13,15
		bl puntoblanco
		//rect de der

		mov w12,30
		mov w13,15
		bl puntoblanco

		// rect de abajo
		mov w12,15
		mov w13,30
		bl puntoblanco

		ldur lr, [sp]
		add sp,sp,8
		br lr	

formaestrella4:
		sub sp, sp, 8
		stur lr, [sp]

	//punto del medio
		bl formaestrella1

	//4 puntos en cruz
		bl formaestrella3

	//rect de arriba
		mov w12,15
		mov w13,5
		bl puntoblanco
	
	//rect de izq
		mov w12,5
		mov w13,15
		bl puntoblanco
	
	//rect de der
		mov w12,25
		mov w13,15
		bl puntoblanco

	// rect de abajo
		mov w12,15
		mov w13,25
		bl puntoblanco

		ldur lr, [sp]
		add sp,sp,8
		br lr	
	
formaestrella5:
		sub sp, sp, 8
		stur lr, [sp]

		//si lo vemos como si fueran posiciones en el reloj serian
		
		//1,2
		mov w12,25
		mov w13,5
		bl puntoblanco

		//4,5
		mov w12,25
		mov w13,25
		bl puntoblanco

		//7,8
		mov w12,5
		mov w13,25
		bl puntoblanco

		//10,11
		mov w12,5
		mov w13,5
		bl puntoblanco

		//12,9,8
		bl formaestrella3

		ldur lr, [sp]
		add sp,sp,8
		br lr	


cuerpo:
	sub sp, sp, 8
	stur lr, [sp]

	//parte color negro (borde del cuerpo)
	ldur w0, [x17]						
	ldur w1, [x17,4]
	add w1, w1, 10						
	mov x2, 200    		 // X Size
	mov x3, 140       		// Y Size 
	ldr x4, negro
	bl rectangulo


	ldur w0, [x17]						
	ldur w1, [x17,4]
	add w0, w0, 10						
	mov x2, 180    		 // X Size
	mov x3, 160       		// Y Size 
	ldr x4, negro
	bl rectangulo
	

	ldur w0, [x17]						
	ldur w1, [x17,4]
	add w0, w0, 5						
	add w1, w1, 5						
	mov x2, 190    		 // X Size
	mov x3, 150       		// Y Size 
	ldr x4, negro
	bl rectangulo

	//parte color piel 
	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0, w0, 10
	add w1, w1, 5
	mov x2, 180
	mov x3, 150
	ldr x4, piel
	bl rectangulo

	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0, w0, 5
	add w1, w1, 10
	mov x2, 190
	mov x3, 140
	ldr x4, piel
	bl rectangulo

	//parte color rosa

	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0, w0, 20
	add w1, w1, 10
	mov x2, 160
	mov x3, 140
	ldr x4, rosa_claro
	bl rectangulo
	
	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0, w0, 15
	add w1, w1, 15
	mov x2, 170
	mov x3, 130
	ldr x4, rosa_claro
	bl rectangulo

	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0, w0, 10
	add w1, w1, 20
	mov x2, 180
	mov x3, 120
	ldr x4, rosa_claro
	bl rectangulo


	//puntos color rosa fuerte
	// utilizo la funcion que defini mas arriba

	mov w12, 25
	mov w13, 20
	bl puntorosa

	mov w12, 110
	mov w13, 100
	bl puntorosa

	mov w12, 140
	mov w13, 29
	bl puntorosa

	mov w12, 80
	mov w13, 26
	bl puntorosa

	mov w12, 90
	mov w13, 60
	bl puntorosa

	mov w12, 48
	mov w13, 72
	bl puntorosa
	
	mov w12, 38
	mov w13, 132
	bl puntorosa


	ldur lr, [sp]
	add sp,sp,8
	br lr	


pata:
	sub sp,sp,8
	stur lr, [sp]

	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0,w0,w12
	mov x2, 30
	mov x3, 15
	ldr x4, negro
	bl rectangulo
	
	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0,w0, w12
	add w0,w0, 5
	mov x2, 25
	mov x3, 20
	ldr x4, negro
	bl rectangulo

	ldur w0, [x17]
	ldur w1, [x17,4]
	add w0,w0, w12
	add w0,w0, 5
	mov x2, 20
	mov x3, 15
	ldr x4, gris
	bl rectangulo

	ldur lr, [sp]
	add sp,sp,8
	br lr

patas:
	sub sp,sp,8
	stur lr, [sp]
	
	//pata 1
	
	mov w12, wzr
	bl pata

	mov w12, 40
	bl pata

	mov w12, 125
	bl pata

	mov w12, 165
	bl pata

	ldur lr, [sp]
	add sp,sp,8
	br lr

cara:
	sub sp,sp,8
	stur lr, [sp]

	//parte negra (bordes de la cabeza)
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w1, w1, 40
	mov x2, 128
	mov x3,	40
	ldr x4, negro
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 24
	add w1, w1, 24
	mov x2, 80
	mov x3,	80
	ldr x4, negro
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 8
	add w1, w1, 8
	mov x2, 32
	mov x3,	80
	ldr x4, negro
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 88
	add w1, w1, 8
	mov x2, 32
	mov x3,	80
	ldr x4, negro
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 16
	mov x2, 16
	mov x3,	96
	ldr x4, negro
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 96
	mov x2, 16
	mov x3,	96
	ldr x4, negro
	bl rectangulo
	

	//parte gris (pelos del gato)
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 8
	add w1, w1, 40
	mov x2, 112
	mov x3,	40
	ldr x4, gris
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 24
	add w1, w1, 32
	mov x2, 80
	mov x3,	64
	ldr x4, gris
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 16
	add w1, w1, 8
	mov x2, 16
	mov x3,	80
	ldr x4, gris
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 96
	add w1, w1, 8
	mov x2, 16
	mov x3,	80
	ldr x4, gris
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 32
	add w1, w1, 16
	mov x2, 16
	mov x3,	16
	ldr x4, gris
	bl rectangulo
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 80
	add w1, w1, 16
	mov x2, 16
	mov x3,	16
	ldr x4, gris
	bl rectangulo

	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 40
	add w1, w1, 16
	mov x2, 8
	mov x3,	8
	ldr x4, negro
	bl rectangulo	
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 80
	add w1, w1, 16
	mov x2, 8
	mov x3,	8
	ldr x4, negro
	bl rectangulo


	//ojo izquierdo
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 32
	add w1, w1, 48
	mov x2, 16
	mov x3,	16
	ldr x4, negro
	bl rectangulo
	
	mov w12,32
	mov w13,48
	bl puntoblanco


	//ojo derecho
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 88
	add w1, w1, 48
	mov x2, 16
	mov x3,	16
	ldr x4, negro
	bl rectangulo
	
	mov w12,88
	mov w13,48
	bl puntoblanco

	//bigotes
	
	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 40
	add w1, w1, 72
	mov x2, 56
	mov x3,	16
	ldr x4, negro
	bl rectangulo

	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 48
	add w1, w1, 72
	mov x2, 16
	mov x3,	8
	ldr x4, gris
	bl rectangulo

	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 72
	add w1, w1, 72
	mov x2, 16
	mov x3,	8
	ldr x4, gris
	bl rectangulo

	//nariz

	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 72
	add w1, w1, 56
	mov x2, 8
	mov x3,	8
	ldr x4, negro
	bl rectangulo

	//cachetes

	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 16
	add w1, w1, 64
	mov x2, 16
	mov x3,	16
	ldr x4, rosa_cachete
	bl rectangulo

	ldur w0,[x17]
	ldur w1,[x17,4]
	add w0, w0, 104
	add w1, w1, 64
	mov x2, 16
	mov x3,	16
	ldr x4, rosa_cachete
	bl rectangulo

	ldur lr, [sp]
	add sp,sp,8
	br lr


makearcoiris:
	sub sp, sp,8
	stur lr, [sp]

	mov w14, wzr
	ldr x4, rojo
	bl rect_arcoiris

	mov w14,20
	ldr x4, naranja
	bl rect_arcoiris

	mov w14,40
	ldr x4, amarillo
	bl rect_arcoiris

	mov w14,60
	ldr x4, verde
	bl rect_arcoiris

	mov w14,80
	ldr x4, celeste
	bl rect_arcoiris

	mov w14,100
	ldr x4, violeta
	bl rect_arcoiris

	ldur lr, [sp]
	add sp, sp,8
	br lr

arcoiris:

	sub sp,sp,8
	stur lr,[sp]
	
	mov w12,wzr
	mov w13,wzr
	bl makearcoiris

	mov w12, 45
	mov w13, 5
	bl makearcoiris
	
	mov w12, 90
	mov w13, 0
	bl makearcoiris

	mov w12, 135
	mov w13, 5
	bl makearcoiris
 

	ldur lr,[sp]
	add sp,sp,8
	br lr

.endif
