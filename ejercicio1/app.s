	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x10, 0xDB, lsl 16
	movk x10, 0xF7FF, lsl 00

	mov x2, SCREEN_HEIGH         // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  // Colorear el pixel N
	add x0,x0,4	   // Siguiente pixel
	sub x1,x1,1	   // Decrementar contador X
	cbnz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1	   // Decrementar contador Y
	cbnz x2,loop1  // Si no es la última fila, salto

	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10
	and w11, w10, 0b10

	// w11 será 1 si había un 1 en la posición 2 de w10, si no será 0
	// efectivamente, su valor representará si GPIO 2 está activo
	lsr w11, w11, 1

	// TEST RECTANGULO
	// CARA :-)
	// dibujar cabeza
	mov x0, x20 // reinicia framebuffer
	mov x1, 150 // alto del rectangullo
	mov x2, 200 // ancho del rectangulo
	mov x9, 160 // posicion y del rectangulo
	mov x3, 200 // posicion x del rectangulo

	movz x6, 0xC8, lsl 16 // color #c874f2
	movk x6, 0x74f2, lsl 00

	bl draw_rectangle

	// dibujar ojo izquierdo
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 20 // ancho del rectangulo
	mov x9, 200 // posicion y del rectangulo
	mov x3, 230 // posicion x del rectangulo

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	// dibujar ojo derecho
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 20 // ancho del rectangulo
	mov x9, 200 // posicion y del rectangulo
	mov x3, 350 // posicion x del rectangulo

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	// dibujar boca
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 140 // ancho del rectangulo
	mov x9, 250 // posicion y del rectangulo
	mov x3, 230 // posicion x del rectangulo

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop


// Subrutina: dibujar rectangulo
draw_rectangle:
	mov x4, x1 // copia de parametro height
	mov x7, SCREEN_WIDTH // copia de screen width

loopy:
	mov x10, x3 // copia de x
	mov x5, x2 // copia de parametro width

loopx:
	// calcular pixel actual
	mul x11, x9, x7 // y * screen width
	add x11, x11, x10 // + x
	lsl x11, x11, 2 // * 4
	add x11, x0, x11 // + framebuffer
	// x11 = framebuffer + ((y * SCREEN_WIDTH + x) * 4) = dirección del píxel (x,y)

	stur w6, [x11] // colorea el pixel actual

	add x10, x10, 1 // avanza un píxel en X dentro de la fila
	sub x5, x5, 1 // width - 1
	cbnz x5, loopx // repite mientras queden píxeles horizontales (ancho del rectángulo)

	add x9, x9, 1 // avanza una fila en Y
	sub x4, x4, 1 // height - 1
	cbnz x4, loopy // repite mientras queden filas por pintar (alto del rectángulo)

	ret

