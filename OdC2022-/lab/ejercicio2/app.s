.include "background.s"
.include "data.s"
.include "gato.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
 	mov x27,x0	// Guardo la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	
	bl makebackground
	bl gato
	bl estrellas

//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
	