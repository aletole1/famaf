.ifndef gato_s
.equ gato_s, 0

.include "data.s"
.include "formas.s"

gato: 
	stur lr, [sp]
	sub sp,sp,8
	
	ldr x17, =arcoiris_
	bl arcoiris

	ldr x17, =patas_
	bl patas

	ldr x17, =cuerpo_
	bl cuerpo

	ldr x17, =cara_
	bl cara
	
	add sp,sp,8
	ldur lr, [sp]
	br lr
	

.endif
