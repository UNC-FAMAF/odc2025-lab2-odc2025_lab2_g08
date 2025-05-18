	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

	.equ COLOR_FONDO_0 , 0xF8F8

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x10, COLOR_FONDO_0  
	movk x10, COLOR_FONDO_0

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
	// CARA :-|
	// dibujar cabeza
	mov x0, x20 // reinicia framebuffer
	mov x1, 200 // alto del rectangullo
	mov x2, 200 // ancho del rectangulo
	mov x9, 140 // posicion y del rectangulo
	mov x3, 50 // posicion x del rectangulo

	movz x6, 0xC8, lsl 16 // color #c874f2
	movk x6, 0x74f2, lsl 00

	bl draw_rectangle

	// dibujar ojo izquierdo
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 20 // ancho del rectangulo
	mov x9, 200 // posicion y del rectangulo
	mov x3, 100 // posicion x del rectangulo

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle


	//Ceja izquierda
	mov x0, x20 // reinicia framebuffer
	mov x1, 5 // alto del rectangullo
	mov x2, 20 // ancho del rectangulo
	mov x9, 190// posicion y del rectangulo
	mov x3, 100 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	// dibujar ojo derecho
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 20 // ancho del rectangulo
	mov x9, 200 // posicion y del rectangulo
	mov x3, 180 // posicion x del rectangulo

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	
	// dibujar boca
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 100 // ancho del rectangulo
	mov x9, 270 // posicion y del rectangulo
	mov x3, 100 // posicion x del rectangulo

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	//TEST CIRCULO
	// cara :)
	mov x0, x20 
	mov x1, 450 // centro a(x)
	mov x2, 240 // centro b(y)
	mov x3, 100 // radio

	movz x6, 0xF5, lsl 16 // color
	movk x6, 0xBF42, lsl 00

	bl draw_circle

	// boca
	mov x0, x20 
	mov x1, 450 // centro a(x)
	mov x2, 260 // centro b(y)
	mov x3, 70 // radio

	movz x6, 0x00, lsl 16 // color
	movk x6, 0x0000, lsl 00

	bl draw_circle

	// tapar mitad boca
	mov x0, x20 // reinicia framebuffer
	mov x1, 90 // alto del rectangullo
	mov x2, 140 // ancho del rectangulo
	mov x9, 180// posicion y del rectangulo
	mov x3, 380 // posicion x del rectangulo

	movz x6, 0xF5, lsl 16 // color
	movk x6, 0xBF42, lsl 00

	bl draw_rectangle

	// ojo izquierdo
	mov x0, x20 
	mov x1, 415 // centro a(x)
	mov x2, 220 // centro b(y)
	mov x3, 20 // radio

	movz x6, 0x00, lsl 16
	movk x6, 0x0000, lsl 00

	bl draw_circle

	//Ceja izquierda
	mov x0, x20 // reinicia framebuffer
	mov x1, 5 // alto del rectangullo
	mov x2, 30 // ancho del rectangulo
	mov x9, 190// posicion y del rectangulo
	mov x3, 400 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle

	// ojo izquierdo
	mov x0, x20 
	mov x1, 480 // centro a(x)
	mov x2, 220 // centro b(y)
	mov x3, 20 // radio

	movz x6, 0x00, lsl 16
	movk x6, 0x0000, lsl 00

	bl draw_circle



	//Ceja derecha
	mov x0, x20 // reinicia framebuffer
	mov x1, 5 // alto del rectangullo
	mov x2, 30 // ancho del rectangulo
	mov x9, 190// posicion y del rectangulo
	mov x3, 465 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00

	bl draw_rectangle


	//TEST PIXEL ART: (ODC)
//	 .equ PIXEL_SIZE, 4
//	 .equ DIR ,1
//	 .equ PADDING, 10
	// movz x6, 0x00, lsl 00 // color
	// movk x6, 0x0000, lsl 00
 	// mov     x0, x20 //RESETEO FB
 	// mov     x1, 1*DIR*PIXEL_SIZE+OFFSET_X      
 	// mov     x2, 2*DIR*PIXEL_SIZE+OFFSET_Y
 	// mov     x3, PIXEL_SIZE         // tamaño PIXEL_SIZE
 	// mov     x4, x6
 	// bl      draw_square
	
//	mov x0,x20 
//	mov x1, 7*PIXEL_SIZE //ALTO
//	mov x2, PIXEL_SIZE //ANCHO
//	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 15 *	PIXEL_SIZE + PADDING//X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//	mov x0,x20 
//	mov x1, 7*PIXEL_SIZE //ALTO
//	mov x2, PIXEL_SIZE //ANCHO
//	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 19 *	PIXEL_SIZE + PADDING  //X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//
//	mov x0,x20 
//	mov x1, PIXEL_SIZE //ALTO
//	mov x2, 4*PIXEL_SIZE //ANCHO
//	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 15 *	PIXEL_SIZE + PADDING//X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//	mov x0,x20 
//	mov x1, PIXEL_SIZE //ALTO
//	mov x2, 5*PIXEL_SIZE //ANCHO
//	mov x9, 9 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 15 *	PIXEL_SIZE + PADDING//X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//	//LETRA D
//	.equ PADDING_L,27
//
//	mov x0,x20 
//	mov x1, 7*PIXEL_SIZE //ALTO
//	mov x2, PIXEL_SIZE //ANCHO
//	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 15 *	PIXEL_SIZE + PADDING+ PADDING_L//X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//	mov x0,x20 
//	mov x1, 6*PIXEL_SIZE //ALTO
//	mov x2, PIXEL_SIZE //ANCHO
//	mov x9, 3 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 19 *	PIXEL_SIZE + PADDING+ PADDING_L //X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//
//	mov x0,x20 
//	mov x1, PIXEL_SIZE //ALTO
//	mov x2, 3*PIXEL_SIZE //ANCHO
//	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 15 *	PIXEL_SIZE + PADDING+ PADDING_L//X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//
//	mov x0,x20 
//	mov x1, PIXEL_SIZE //ALTO
//	mov x2, 3*PIXEL_SIZE //ANCHO
//	mov x9, 9 	*	PIXEL_SIZE 	+ PADDING //Y
//	mov x3, 15 *	PIXEL_SIZE + PADDING + PADDING_L//X
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//	bl draw_rectangle
//


//DIBUJO DE UN TRIANGULO
.equ ALTURA, 100
.equ PADDING_TRIANGULO,220
.equ COLOR_TRIANGULO, 0x3830
.equ PIXEL_SIZE, 1

//loop
	mov x25, #0
	loop:
		cmp x25,ALTURA
		b.ge end_loop
		add x25,x25,#1

		mov x0,x20 //RESETEO FB
		mov x1, PIXEL_SIZE //ALTO
		mov x2, PIXEL_SIZE  //ANCHO
		mul x2,x2,x25 //ANCHO = PIXEL_SIZE * X2 * X25(n) 

		mov x9, PIXEL_SIZE //Y
		mul x9,x9,x25 

		//AHORA LA POS HORIZONTAL
		mov x3, PIXEL_SIZE + PADDING_TRIANGULO //X POS 
		mov x28,ALTURA
		sub x28,x28,x25
		add x28,x28,x25
		
		movz x6, COLOR_TRIANGULO, lsl 00 
		movk x6, COLOR_TRIANGULO, lsl 00
		bl draw_rectangle

		b loop

	end_loop:

//	//ESTE CODIGO FUNCIONA Y HACE UN TRIANGULO EQUILATERO
//	mov x25, #0
//	loop:
//		cmp x25,#21
//		b.ge end_loop
//		add x25,x25,#1
//
//		mov x0,x20 
//		mov x1, PIXEL_SIZE //ALTO
//		mov x2, PIXEL_SIZE  //ANCHO
//		mul x2,x2,x25
//
//		mov x9, PIXEL_SIZE //Y
//		mul x9,x9,x25
//
//
//		mov x3, PIXEL_SIZE +PADDING//X
//		mov x28,#21
//		sub x28,x28,x25
//		add x3,x3,x28
//		add x3,x3,X3
//
//
//		movz x6, 0xff, lsl 00 // color
//		movk x6, 0xffff, lsl 16
//		bl draw_rectangle
//		
//		b loop
//
//	end_loop:


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


// Subrutina: dibujar circulo
// (x-a)² + (y-b)² <= r²
draw_circle:
	sub x9, x2, x3 //y = b - r (posicion inicial y)

	mul x11, x3, x3 //r²
	lsl x12, x3, 1 // 2r para x (cota superior)
	lsl x13, x3, 1 // 2r para y (cota superior)

	mov x7, SCREEN_WIDTH

circ_loopy:
	sub x10, x1, x3 //x = a - r (posicion inicial x)
	mov x5, x12

circ_loopx:
	sub x14, x10, x1 //x-a
	mul x14, x14, x14 //(x-a)²

	sub x15, x9, x2 // y-b
	mul x15, x15, x15 //(y-b)²

	add x15, x15, x14 //(x-a)²+(y-b)²

	cmp x15, x11
	bgt skip_pixel // (x-a)²+(y-b)² > r², entonces no colorea el pixel

	// calcular pixel actual
	mul x4, x9, x7 // y * screen width
	add x4, x4, x10 // + x
	lsl x4, x4, 2 // * 4
	add x4, x0, x4 // + framebuffer
	// x4 = framebuffer + ((y * SCREEN_WIDTH + x) * 4) = dirección del píxel (x,y)
	stur w6, [x4]

	
skip_pixel:
	add x10, x10, 1 // avanza un píxel en X dentro de la fila
	sub x5, x5, 1 // 2r - 1
	cbnz x5, circ_loopx // repite mientras queden píxeles horizontales (ancho del circulo)

	add x9, x9, 1 // avanza una fila en Y
	sub x13, x13, 1 // 2r - 1
	cbnz x13, circ_loopy // repite mientras queden filas por pintar (alto del circulo)

	ret


// draw_square:
//   x0 = dirección base del framebuffer
//   x1 = posición X del cuadrado (columna)
//   x2 = posición Y del cuadrado (fila)
//   x3 = tamaño del lado del cuadrado (size)
//   x4 = color (32 bpp)
// Registros usados internamente: x5–x9
draw_square:
    mov     x5, x3               // filas restantes = size
    mov     x6, SCREEN_WIDTH     // ancho de pantalla

sq_row:
    mov     x7, x1               // columna actual = x
    mov     x8, x3               // columnas restantes = size

sq_col:
    // addr = fb + 4 * (y * SCREEN_WIDTH + x)
    mul     x9, x2, x6
    add     x9, x9, x7
    lsl     x9, x9, 2
    add     x9, x0, x9
    stur    w4, [x9]             // escribe color

    add     x7, x7, 1            // siguiente columna
    sub     x8, x8, 1
    cbnz    x8, sq_col           // repite en la fila

    add     x2, x2, 1            // siguiente fila
    sub     x5, x5, 1
    cbnz    x5, sq_row           // repite filas

    ret
