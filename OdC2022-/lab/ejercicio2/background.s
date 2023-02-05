
.ifndef background_s
.equ background_s, 0

.include "data.s"
.include "formas.s"

makebackground:
 
	sub sp, sp, 8
	stur lr, [sp]
	
	mov x0, xzr 						
	mov x1, xzr
	mov x2, SCREEN_WIDTH    		 // X Size
	mov x3, SCREEN_HEIGH       		// Y Size 
	ldr x4, azul		
	bl rectangulo

	ldur lr, [sp]
	add sp,sp,8
	br lr

estrellas:
	sub sp, sp, 8
	stur lr, [sp]

	ldr x17,=estrella1
	bl formaestrella1
	ldr x17,=estrella2
	bl formaestrella2
	ldr x17,=estrella3
	bl formaestrella3
	ldr x17,=estrella4
	bl formaestrella4





	ldr x17,=estrella5
	bl formaestrella5
	




	ldur lr, [sp]
	add sp,sp,8
	br lr

.endif
