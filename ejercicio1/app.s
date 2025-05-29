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

	movz x10, 0x8B22,lsl 00 //Bits 0-15  
	movk x10, 0xFF22,lsl 16 // del 16-31

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

	//cielo
	mov x0, x20 // reinicia framebuffer
	mov x1, 200 // alto del rectangullo
	mov x2, 640 // ancho del rectangulo
	mov x9, 0// posicion y del rectangulo
	mov x3, 0 // posicion x del rectangulo

	movz x6, 0xCEEB, lsl 00 // color
	movk x6, 0xFF87, lsl 16

	bl draw_rectangle
	
	//Franja de pasto arriba
	mov x0,x20
	mov x1, 30
	mov x2, 640
	mov x9, 200
	mov x3, 0
	
	movz x6, 0x994C, lsl 00
	movk x6, 0x00, lsl 16
	bl draw_rectangle

	//Franja de pasto de abajo
	mov x0, x20
	mov x1, 100
	mov x2, 640
	mov x9, 380
	mov x3, 0

	movz x6, 0x994C, lsl 00
	movk x6, 0x00,  lsl 16
	bl draw_rectangle


	////banquina
	mov x0, x20
	mov x8, 620   // tamaño
	mov x16, 2    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 200    // Y inicial
	mov x18,10  // X inicial
	movz x6, 0xD700, lsl 00 // color
	movk x6, 0x40FF, lsl 16
	mov  x15, #90 //MOdificando este valor me permite "cortar" la cuspide del triangulo
	bl  draw_route


	////ruta
	mov x0, x20
	mov x8, 580   // tamaño
	mov x16, 2    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 200    // Y inicial
	mov x18,30  // X inicial
	movz x6, 0x3838, lsl 00 // color
	movk x6, 0x3838, lsl 16
	mov  x15, #72
	bl  draw_route

	//Lineas de la ruta
	mov x15,#1
	mov x0, x20 // reinicia framebuffer
	mov x1, 15 // alto del rectangullo
	mov x2, 4 // ancho del rectangulo
	mov x9, 196 // posicion y del rectangulo

	loop_linea:
		cmp x15,#7
		b.ge end_loop_line
		add x15,x15,#1
		mov x7,x15
		mul x7,x7,x2
		add x9,x9,x7
		mov x3, 318 // posicion x del rectangulo
		movz x6, 0xFF, lsl 16 // color
		movk x6, 0xFFFF, lsl 00
		add x1,x1,x15
		bl draw_rectangle
		b loop_linea
	end_loop_line:
		

    /*  Inicializa la posicion Y de las lineas
    mov x21, #200            // y de línea 1
    mov x22, #230            // y de línea 2
    mov x23, #260            // y de línea 3
    mov x24, #290            // y de línea 4
    mov x25, #320            // y de línea 5
    mov x26, #350            // y de línea 6

	mov x27, 200

linea_loop:
    // Borra las lineas (las pinta del color de la ruta)
    movz x6, 0x3838, lsl 0
	movk x6, 0x3838, lsl 16
    mov x3, #318      // X fijo de las lineas
    mov x2, #4        // Ancho
    mov x1, #15       // Alto

    mov x9, x21
	bl draw_rectangle
    mov x9, x22
	bl draw_rectangle
    mov x9, x23
	bl draw_rectangle
    mov x9, x24
	bl draw_rectangle
    mov x9, x25
	bl draw_rectangle
    mov x9, x26
	bl draw_rectangle

    // === Actualiza  las posiciones de las lineas constantemente
    add x21, x21, #2
    add x22, x22, #2
    add x23, x23, #2
    add x24, x24, #2
    add x25, x25, #2
    add x26, x26, #2

    // Controla si las lineas se salen y las reinicia en caso de que si 
    mov x12, #465      // 480 (pantalla) - 15 (alto de la linea)
    cmp x21, x12
    b.lt ok1
    mov x21, #200
ok1:
    cmp x22, x12
    b.lt ok2
    mov x22, #200
ok2:
    cmp x23, x12
    b.lt ok3
    mov x23, #200
ok3:
    cmp x24, x12
    b.lt ok4
    mov x24, #200
ok4:
    cmp x25, x12
    b.lt ok5
    mov x25, #200
ok5:
    cmp x26, x12
    b.lt ok6
    mov x26, #200
ok6:

    // Dibujar líneas (color blanco)
    movz x6, #0xFF, lsl 16
    movk x6, #0xFFFF, lsl 0
    mov x3, #318
    mov x2, #4
    mov x1, #15

    mov x9, x21
	bl draw_rectangle
    mov x9, x22
	bl draw_rectangle
    mov x9, x23
	bl draw_rectangle
    mov x9, x24
	bl draw_rectangle
    mov x9, x25
	bl draw_rectangle
    mov x9, x26
	bl draw_rectangle

    bl funcion_delay
    b linea_loop
*/

	//sol
	mov x0, x20 
	mov x1, 480 // centro a(x)
	mov x2, 20 // centro b(y)
	mov x3, 70 // radio
	movz x6, 0xF5, lsl 16 // color
	movk x6, 0xBF42, lsl 00
	bl draw_circle



	//NUBE 1
	
	mov x0, x20
	mov x1, 80 //centro x
	mov x2, 40 //centro y
	mov x3, 20 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle
	
	mov x0, x20
	mov x1, 100 //centro x
	mov x2, 35 //centro y
	mov x3, 25 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle
	
	mov x0, x20
	mov x1, 120 //centro x
	mov x2, 40 //centro y
	mov x3, 20 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle

	
	//NUBE 2
	
	mov x0, x20
	mov x1, 200 //centro x
	mov x2, 50 //centro y
	mov x3, 20 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle
	
	mov x0, x20
	mov x1, 220 //centro x
	mov x2, 45 //centro y
	mov x3, 25 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle
	
	mov x0, x20
	mov x1, 240 //centro x
	mov x2, 50 //centro y
	mov x3, 20 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle



	//Triangulo equilatero
	mov x0, x20
	mov x8, 100   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 100   // Y inicial
	mov x18, 60   // X inicial
	movz x6, 0xB48C, lsl 0 // color
	movk x6, 0xFFD2, lsl 16
	bl  draw_triangle

	//Triangulo equilatero
	mov x0, x20
	mov x8, 80   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 120   // Y inicial
	mov x18, 130   // X inicial
	movz x6, 0x8C66, lsl 0 // color 
	movk x6, 0xFFB9, lsl 16
	bl  draw_triangle

	//Triangulo equilatero
	mov x0, x20
	mov x8, 100   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 100   // Y inicial
	mov x18, 8   // X inicial
	movz x6, 0x8C66, lsl 0 // color
	movk x6, 0xFFB9, lsl 16
	bl  draw_triangle


        
	//montaña lado opuesto
		//Triangulo equilatero
	mov x0, x20
	mov x8, 100   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 100   // Y inicial
	mov x18, 460   // X inicial
	movz x6, 0xB48C, lsl 0 // color
	movk x6, 0xFFD2, lsl 16
	bl  draw_triangle

	//Triangulo equilatero
	mov x0, x20
	mov x8, 80   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 120   // Y inicial
	mov x18, 420   // X inicial
	movz x6, 0x8C66, lsl 0 // color
	movk x6, 0xFFB9, lsl 16
	bl  draw_triangle

	//Triangulo equilatero
	mov x0, x20
	mov x8, 100   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 100   // Y inicial
	mov x18, 500   // X inicial
	movz x6, 0x8C66, lsl 0 // color
	movk x6, 0xFFB9, lsl 16
	bl  draw_triangle
	


	//ARBOL 1
	
	mov x0,x20
	mov x1, 20 //alto
	mov x2, 6 //ancho
	mov x9, 190 //y
	mov x3, 222 //x
	movz x6, 0x5533, lsl 0
	movk x6, 0x9966, lsl 16 //marron tronco
	bl draw_rectangle
	
	//arbol 1 copa
	mov x0, x20
	mov x1, 225 //centro x
	mov x2, 185 //centro y
	mov x3, 12//radio
	movz x6, 0xFF00, lsl 0
	movk x6, 0x00, lsl 16 //Blanco
	bl draw_circle

	
	//ARBOL 2
	
	mov x0,x20
	mov x1, 20 //alto
	mov x2, 6 //ancho
	mov x9, 180 //y
	mov x3, 202 //x
	movz x6, 0x5533, lsl 0
	movk x6, 0x9966, lsl 16 //marron tronco
	bl draw_rectangle
	

	//arbol 2 copa
	mov x0, x20
	mov x1, 204 //centro x
	mov x2, 180 //centro y
	mov x3, 12//radio
	movz x6, 0xFF00, lsl 0
	movk x6, 0x00, lsl 16 //Blanco
	bl draw_circle

	
	
	//ARBOL 4
	
	mov x0,x20
	mov x1, 20 //alto
	mov x2, 6 //ancho
	mov x9, 190 //y
	mov x3, 380 //x
	movz x6, 0x5533, lsl 0
	movk x6, 0x9966, lsl 16 //marron tronco
	bl draw_rectangle
	
	//arbol 4 copa
	mov x0, x20
	mov x1, 382 //centro x
	mov x2, 185 //centro y
	mov x3, 12//radio
	movz x6, 0xFF00, lsl 0
	movk x6, 0x00, lsl 16 //Blanco
	bl draw_circle


	//ARBOL 5
	
	mov x0,x20
	mov x1, 20 //alto
	mov x2, 6 //ancho
	mov x9, 180 //y
	mov x3, 400 //x
	movz x6, 0x5533, lsl 0
	movk x6, 0x9966, lsl 16 //marron tronco
	bl draw_rectangle
	

	//arbol 5 copa
	mov x0, x20
	mov x1, 402 //centro x
	mov x2, 180 //centro y
	mov x3, 12//radio
	movz x6, 0xFF00, lsl 0
	movk x6, 0x00, lsl 16 //Blanco
	bl draw_circle


        //FIN ARBOLES

 
	//CARTELES
	//POSTE CARTEL 1 
	
	mov x0,x20
	mov x1, 20 //alto
	mov x2, 6 //ancho
	mov x9, 300 //y
	mov x3, 500 //x
	movz x6, 0x5533, lsl 0
	movk x6, 0x9966, lsl 16 //marron tronco
	bl draw_rectangle
	
	//POSTE CARTEL 1 
	
	mov x0,x20
	mov x1, 20 //alto
	mov x2, 6 //ancho
	mov x9, 300 //y
	mov x3, 560//x
	movz x6, 0x5533, lsl 0
	movk x6, 0x9966, lsl 16 //marron tronco
	bl draw_rectangle

	// BORDE CARTEL
	mov x0, x20
	mov x1, 85 // alto
	mov x2, 145 // ancho
	mov x9, 215 // y
	mov x3, 460 // x
	movz x6, 0xFFFF, lsl 0
	movk x6, 0xFFFF, lsl 16
	bl draw_rectangle


	// CARTEL
	mov x0, x20
	mov x1, 70 // alto
	mov x2, 130 // ancho
	mov x9, 222 // y
	mov x3, 467 // x
	movz x6, 0x00, lsl 16
	movk x6, 0x9900, lsl 00   
	bl draw_rectangle


	// Comienzo OdC

	// O (OdC)
	mov x0, x20
	mov x1, 500 //centro x
	mov x2, 245 //centro y
	mov x3, 15 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle

	mov x0, x20
	mov x1, 500 //centro x
	mov x2, 245 //centro y
	mov x3, 10 //radio
	movz x6, 0x00, lsl 16
	movk x6, 0x9900, lsl 00 //Blanco
	bl draw_circle
	// fin de o

	// d (OdC)
	mov x0, x20
	mov x1, 533 //centro x
	mov x2, 250 //centro y
	mov x3, 10 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle

	mov x0, x20
	mov x1, 533 //centro x
	mov x2, 250 //centro y
	mov x3, 5 //radio
	movz x6, 0x00, lsl 16
	movk x6, 0x9900, lsl 00 //Blanco
	bl draw_circle

	mov x0, x20
	mov x1, 30 // alto
	mov x2, 5 // ancho
	mov x9, 230 // y
	mov x3, 541 // x
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00   
	bl draw_rectangle
	//fin de d

	// C (OdC)
	mov x0, x20
	mov x1, 570 //centro x
	mov x2, 245 //centro y
	mov x3, 15 //radio
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00 //Blanco
	bl draw_circle

	mov x0, x20
	mov x1, 570 //centro x
	mov x2, 245 //centro y
	mov x3, 10 //radio
	movz x6, 0x00, lsl 16
	movk x6, 0x9900, lsl 00 //Blanco
	bl draw_circle

	mov x0, x20
	mov x1, 30 // alto
	mov x2, 10 // ancho
	mov x9, 230 // y
	mov x3, 578 // x
	movz x6, 0x00, lsl 16
	movk x6, 0x9900, lsl 00   
	bl draw_rectangle
	//fin de C

	// Fin de OdC

	// Comienzo 2025

	// 2
	mov x0, x20
	mov x1, 478
	mov x2, 275
	mov x3, 480
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 480
	mov x2, 270
	mov x3, 487
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 487
	mov x2, 270
	mov x3, 490
	mov x4, 275
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 490
	mov x2, 275
	mov x3, 478
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 478
	mov x2, 285
	mov x3, 490
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line
	// fin 2

	// 0
	mov x0, x20
	mov x1, 495
	mov x2, 270
	mov x3, 495
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 495
	mov x2, 285
	mov x3, 505
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 505
	mov x2, 285
	mov x3, 505
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 505
	mov x2, 270
	mov x3, 495
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line
	// fin 0

	// 2
	mov x0, x20
	mov x1, 510
	mov x2, 275
	mov x3, 512
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 512
	mov x2, 270
	mov x3, 519
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 519
	mov x2, 270
	mov x3, 522
	mov x4, 275
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 522
	mov x2, 275
	mov x3, 510
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line

	mov x0, x20
	mov x1, 510
	mov x2, 285
	mov x3, 522
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 //Blanco
	bl draw_line
	// fin 2

	// 5
	mov x0, x20
	mov x1, 528
	mov x2, 270
	mov x3, 538
	mov x4, 270
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 528
	mov x2, 270
	mov x3, 528
	mov x4, 277
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line
	
	mov x0, x20
	mov x1, 528
	mov x2, 277
	mov x3, 538
	mov x4, 277
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 538
	mov x2, 277
	mov x3, 538
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 538
	mov x2, 285
	mov x3, 528
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line
	// fin 5
	// Fin 2025

	//Inicio km
	// k
	mov x0, x20
	mov x1, 548
	mov x2, 270
	mov x3, 548
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 548
	mov x2, 278
	mov x3, 558
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 548
	mov x2, 278
	mov x3, 558
	mov x4, 271
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line
	// fin k

	// m
	mov x0, x20
	mov x1, 563
	mov x2, 270
	mov x3, 563
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 563
	mov x2, 270
	mov x3, 568
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 573
	mov x2, 270
	mov x3, 568
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line

	mov x0, x20
	mov x1, 573
	mov x2, 270
	mov x3, 573
	mov x4, 285
	movz x8, 0xFF, lsl 16
	movk x8, 0xFFFF, lsl 00 // Blanco
	bl draw_line
	//fin m
	//Fin km

	// Inicio flecha

	mov x0, x20
	mov x1, 7 // alto
	mov x2, 5 // ancho
	mov x9, 279 // y
	mov x3, 583 // x
	movz x6, 0xFF, lsl 16
	movk x6, 0xFFFF, lsl 00   
	bl draw_rectangle

	mov x0, x20
	mov x8, 11   // tamaño
	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
	mov x4, 270   // Y inicial
	mov x18, 580   // X inicial
	movz x6, 0xFF, lsl 16 // color
	movk x6, 0xFFFF, lsl 00
	bl  draw_triangle

	// Fin flecha



	 //INICIO CODIGO PRUEBA CARTEL MOVIENDOSE

	// Constantes iniciales
	mov x21, 500        // x actual
 	mov x22, 300        // límite izquierdo
	mov x23, -10        // delta de movimiento
	mov x24, 500        // x anterior (inicialmente igual que x21)
	mov x25, 70         // ancho del rectángulo
	mov x26, 200        // y fijo
	mov x27, 40         // alto
	mov x28, 640        // SCREEN_WIDTH
	sub x29, x28, x25   // límite derecho (SCREEN_WIDTH - ancho)

	// bucle_mover_rec:

	// // Chequeo de límites antes de borrar rectángulo anterior
	// cmp x24, #0
	// blt skip_borrar

	// cmp x24, x29   // x29 = límite derecho (SCREEN_WIDTH - ancho)
	// bgt skip_borrar
	// // BORRAR rectángulo anterior (en x24)
	// mov x0, x20
	// mov x1, x27            // alto
	// mov x2, x25            // ancho
	// mov x3, x24            // x anterior
	// mov x9, x26            // y
	// movz x6, 0x0000, lsl 16  // color negro (borrar)
	// movk x6, 0x0000, lsl 0
	// mov x7, SCREEN_WIDTH
	// bl draw_rectangle


	// skip_borrar:
	// // Actualizar posición
	// add x21, x21, x23
	// mov x24, x21    // guardar nueva posición para borrar en siguiente iteración

	// // Rebotar si llegamos a límites
	// cmp x21, x22
	// b.lt invertir_derecha

	// cmp x21, x29
	// b.gt invertir_izquierda

	// // DIBUJAR nuevo rectángulo
	// mov x0, x20
	// mov x1, x27
	// mov x2, x25
	// mov x3, x21
	// mov x9, x26
	// movz x6, 0xFF, lsl 16   // color rojo
	// movk x6, 0xFFFF, lsl 0
	// mov x7, SCREEN_WIDTH
	// bl draw_rectangle

	//bl funcion_delay

	// b bucle_mover_rec

	// invertir_izquierda:
	// mov x23, -10
	// b bucle_mover_rec

	// invertir_derecha:
	// mov x23, 10
	// b bucle_mover_rec


	 //FIN CODIGO PRUEBA CARTEL MOVIENDOSE
	



    //AUTO 1
draw_car_2:

	mov x19, 30 //para mover la pos del auto en pos x
	mov x18, 1 //mover el auto en pos y


	//1er rectangulo
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 120 // ancho del rectangulo
	mov x9, 360// posicion y del rectangulo
	mov x3, 170 // posicion x del rectangulo

	movz x6, 0xFF00, lsl 00 // color
	movk x6, 0xFF00, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	
	


	//2do rectangulo
	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 140 // ancho del rectangulo
	mov x9, 380// posicion y del rectangulo
	mov x3, 160 // posicion x del rectangulo

	movz x6, 0xFF00, lsl 00 // color
	movk x6, 0xFF00, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	
	
    

	//3er rectangulo
	mov x0, x20 // reinicia framebuffer
	mov x1, 30 // alto del rectangullo
	mov x2, 160 // ancho del rectangulo
	mov x9, 400// posicion y del rectangulo
	mov x3, 150 // posicion x del rectangulo

	movz x6, 0xFF, lsl 00 // color
	movk x6, 0xFF00, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	
	


	//ventanilla
	mov x0, x20 // reinicia framebuffer
	mov x1, 25 // alto del rectangullo
	mov x2, 100 // ancho del rectangulo
	mov x9, 370// posicion y del rectangulo
	mov x3, 180 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	


	//luces izquierdas
	mov x0, x20 // reinicia framebuffer
	mov x1, 10 // alto del rectangullo
	mov x2, 10 // ancho del rectangulo
	mov x9, 410// posicion y del rectangulo
	mov x3, 150 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	


	mov x0, x20 // reinicia framebuffer
	mov x1, 10 // alto del rectangullo
	mov x2, 10 // ancho del rectangulo
	mov x9, 410// posicion y del rectangulo
	mov x3, 160 // posicion x del rectangulo

	movz x6, 0xF5, lsl 00 // color
	movk x6, 0xBF42, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	
	

	//luces derechas
	mov x0, x20 // reinicia framebuffer
	mov x1, 10 // alto del rectangullo
	mov x2, 10 // ancho del rectangulo
	mov x9, 410// posicion y del rectangulo
	mov x3, 300 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	

	mov x0, x20 // reinicia framebuffer
	mov x1, 10 // alto del rectangullo
	mov x2, 10 // ancho del rectangulo
	mov x9, 410// posicion y del rectangulo
	mov x3, 290 // posicion x del rectangulo

	movz x6, 0xF5, lsl 00 // color
	movk x6, 0xBF42, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	

	//patente
	mov x0, x20 // reinicia framebuffer
	mov x1, 15 // alto del rectangullo
	mov x2, 40 // ancho del rectangulo
	mov x9, 410// posicion y del rectangulo
	mov x3, 210 // posicion x del rectangulo

	movz x6, 0xFF, lsl 00 // color
	movk x6, 0xFFFF, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	

	//rueda izquierda
	mov x0, x20 // reinicia framebuffer
	mov x1, 25 // alto del rectangullo
	mov x2, 30 // ancho del rectangulo
	mov x9, 430// posicion y del rectangulo
	mov x3, 150 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle
	

	//rueda derecha
	mov x0, x20 // reinicia framebuffer
	mov x1, 25 // alto del rectangullo
	mov x2, 30 // ancho del rectangulo
	mov x9, 430// posicion y del rectangulo
	mov x3, 280 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // color
	movk x6, 0x0000, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//bl loop_animacion
	
	
	//FIN AUTO 1


	//AUTO 2
	mov x18,x30
	mov x19,x30

	mov x19,76 //para mover la pos del auto en pos x
	mov x18, -60 //mover el auto en pos y

	mov x0, x20 // reinicia framebuffer
	mov x1, 33 // alto del rectangullo
	mov x2, 75 // ancho del rectangulo
	mov x9, 338 // posicion y del rectangulo
	mov x3, 223 // posicion x del rectangulo

	movz x6, 0xF8, lsl 00 // 
	movk x6, 0x3838, lsl 16

	add x3,x3,x19
	add x9,x9,x18


	bl draw_rectangle

	mov x0, x20 // reinicia framebuffer
	mov x1, 20 // alto del rectangullo
	mov x2, 100 // ancho del rectangulo
	mov x9, 350 // posicion y del rectangulo
	mov x3, 210 // posicion x del rectangulo

	movz x6, 0xF8, lsl 00 // 
	movk x6, 0x3838, lsl 16
	
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	mov x0, x20 // reinicia framebuffer
	mov x1, 10 // alto del rectangullo
	mov x2, 46 // ancho del rectangulo
	mov x9, 344 // posicion y del rectangulo
	mov x3, 237 // posicion x del rectangulo

	movz x6, 0x00, lsl 00 // 
	movk x6, 0x0000, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	mov x0, x20 // reinicia framebuffer
	mov x1, 5 // alto del rectangullo
	mov x2, 24 // ancho del rectangulo
	mov x9, 359 // posicion y del rectangulo
	mov x3, 248 // posicion x del rectangulo
	movz x6, 0xFF, lsl 16 // 
	movk x6, 0xFFFF, lsl 00
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle


	mov x0, x20 // reinicia framebuffer
	mov x1, 6 // alto del rectangullo
	mov x2, 96 // ancho del rectangulo
	mov x9, 369 // posicion y del rectangulo
	mov x3, 212 // posicion x del rectangulo
	movz x6, 0x00, lsl 00 
	movk x6, 0x0000, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	mov x0, x20 // reinicia framebuffer
	mov x1, 5 // alto del rectangullo
	mov x2, 101 // ancho del rectangulo
	mov x9, 374 // posicion y del rectangulo
	mov x3, 209 // posicion x del rectangulo

	movz x6, 0xF8, lsl 00 // 
	movk x6, 0x3838, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//RUEDA IZQ
	mov x0, x20 // reinicia framebuffer
	mov x1, 11 // alto del rectangullo
	mov x2, 25 // ancho del rectangulo
	mov x9, 379 // posicion y del rectangulo
	mov x3, 212 // posicion x del rectangulo
	movz x6, 0x00, lsl 00 
	movk x6, 0x0000, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//GUARDABARROS IZQ
	mov x0, x20 // reinicia framebuffer
	mov x1, 2 // alto del rectangullo
	mov x2, 15 // ancho del rectangulo
	mov x9, 380 // posicion y del rectangulo
	mov x3, 216 // posicion x del rectangulo
	movz x6, 0x8038, lsl 00 
	movk x6, 0x3838, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//RUEDA DER
	mov x0, x20 // reinicia framebuffer
	mov x1, 11 // alto del rectangullo
	mov x2, 25 // ancho del rectangulo
	mov x9, 379 // posicion y del rectangulo
	mov x3, 284 // posicion x del rectangulo
	movz x6, 0x00, lsl 00 
	movk x6, 0x0000, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//GUARDABARROS DER
	mov x0, x20 // reinicia framebuffer
	mov x1, 2 // alto del rectangullo
	mov x2, 15 // ancho del rectangulo
	mov x9, 380 // posicion y del rectangulo
	mov x3, 289 // posicion x del rectangulo
	movz x6, 0x8038, lsl 00 
	movk x6, 0x3838, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//LUZ DER
	mov x0, x20 // reinicia framebuffer
	mov x1, 6 // alto del rectangullo
	mov x2, 17 // ancho del rectangulo
	mov x9, 360 // posicion y del rectangulo
	mov x3, 289 // posicion x del rectangulo
	movz x6, 0xFFFF, lsl 16 
	movk x6, 0xFFFF, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//LUZ IZQ
	mov x0, x20 // reinicia framebuffer
	mov x1, 6 // alto del rectangullo
	mov x2, 17 // ancho del rectangulo
	mov x9, 360 // posicion y del rectangulo
	mov x3, 214 // posicion x del rectangulo
	movz x6, 0xFFFF, lsl 16 
	movk x6, 0xFFFF, lsl 16
	add x3,x3,x19
	add x9,x9,x18
	bl draw_rectangle

	//FIN AUTO



	//COMINEZO DE ANIMACION 
 
	mov x19, 0        // posición Y actual del auto
	mov x22, 0        // posición Y anterior
	mov x21, 480      // límite en Y (altura de pantalla)

bucle_animacion:
	// limpiar área anterior (auto en posición Y anterior)
	mov x0, x20          // framebuffer
 	//LA ZONA ECTANGULO SE HIZO LO MAS CHICA POSIBLE, DADO QUE AFECTABA LA VISTA
	mov x1, 2          // alto de la zona del auto (Y)
	mov x2, 2          // ancho zona auto (X)
	mov x3, 150          // X fijo (offset)
	add x9, x22, 350     // Y = posición anterior + offset (ajusta según donde dibujas)
	
	// color negro para limpiar
	movz x6, 0x0000, lsl 0
	movk x6, 0x0000, lsl 16
	bl draw_rectangle

	// dibujar auto en posición actual Y (x19)
	// dentro de draw_car_2, suma x19 a Y (x9), no a X (x3)
	bl draw_car_2

	// cuanto mas se llama mas lento se logra ver la animacion
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay

	// actualizar posición anterior
	mov x22, x19
 //delay por las dudas, no se si afecta en la velocidad
	bl funcion_delay
	// avanzar en Y
	add x19, x19, 105

	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay
	bl funcion_delay

	// condición para continuar animación
	cmp x19, x21
	blt bucle_animacion
	bl funcion_delay
	ret

	//FIN DE LA ANIMACION

	
	//---------------------------------------------------------------
	// Infinite Loop
InfLoop:
	b InfLoop


//--------------------------------------------------------------------
// SUBRUTINAS
// -------------------------------------------------------------------

// Subrutina: dibujar rectangulo
draw_rectangle:
	//stp x29, x30, [sp, #16]!   // guarda fp/lr en stack, ajusta sp
    mov x29, sp   

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
	//ldp    x29, x30, [sp], #16    // restaura fp/lr y ajusta sp
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



funcion_delay:
   mov X8, #60000     // Ajusta este valor según necesites más tiempo
delay:
   sub X8, X8, #1     // Reduce el contador
    cbnz x8, delay      
    ret


// Subrutina: dibujar linea entre dos puntos
// Algoritmo de Bresenham
// x1 = x0 (punto x del punto 1)
// x2 = y0 (punto y del punto 1)
// x3 = x1 (punto x del punto 2)
// x4 = y1 (punto y del punto 2)
draw_line:

	mov x7, SCREEN_WIDTH

    sub x9, x3, x1 // x9 = x1 - x0
    cmp x9, #0
    bge dx_done
    neg x9, x9

dx_done:
    mov x5, x9 // x5 = dx = |x1 - x0|

    sub x9, x4, x2 // x9 = y1 - y0
    cmp x9, #0
    bge dy_done
    neg x9, x9

dy_done:
    mov x6, x9 // x6 = dy = |y1 - y0|
	sub x14, x5, x6 // error = dx - dy

	cmp x1, x3
	ble sx_one
	mov x11, -1
	b comp_sy

sx_one:
	mov x11, 1
	b comp_sy

comp_sy:
	cmp x2, x4
	ble sy_one
	mov x12, -1
	b line_loop

sy_one: 
	mov x12, 1
	b line_loop

line_loop:
	mul x13, x2, x7 // y0 * screen width
	add x13, x13, x1 // + x0
	lsl x13, x13, 2 // * 4
	add x13, x0, x13 // + framebuffer
    //x13 = framebuffer + ((y * SCREEN_WIDTH + x) * 4) = dirección del píxel (x,y)
	stur w8, [x13]

	cmp x1, x3
	bne not_equal

	cmp x2, x4
	bne not_equal

	b end_line

not_equal:
	lsl x15, x14, 1 // x15 = error * 2
	neg x16, x6
	cmp x15, x16
	bge step_x

	b check_step_y

step_x:
	sub x14, x14, x6 // error = error - dy
	add x1, x1, x11 // x0 = x0 + sx

	b check_step_y

check_step_y:
	cmp x15, x5
	ble step_y
	b line_loop

step_y:
	add x14, x14, x5 // error = error + dx
	add x2, x2, x12 // y0 = y0 + sy
	b line_loop

end_line:
	ret

draw_right_triangle:
    stp  x29, x30, [sp, #16]!   // guarda fp/lr
    mov  x29, sp   
    mov  x15, #0               // contador de filas

    mov  x0,  x20              // reset fb
    mov  x1,  x16              // altura = 1
    mov  x2,  x17              // ancho inicial = 1 (se va haciendo mas grande)
    mov  x9,  x4               // Y inicial 
    mov  x3,  x5               // X inicial 

for_loop:
    cmp  x15, x8               
    b.ge end_loop
    add  x15, x15, #1          
    
	mov  x2,  x15 // ANCHO = i             

    bl  draw_rectangle        
    b	for_loop
end_loop:
    ldp  x29, x30, [sp], #16   // restaura fp/lr
    ret



draw_triangle:
    stp  x29, x30, [sp, #16]!   // guarda fp/lr
    mov  x29, sp   
    mov  x15, #0               // contador de filas

    mov  x0,  x20              // reset fb
    mov  x1,  x16              // altura = 1
    mov  x2,  x17              // ancho inicial = 1 (se va haciendo mas grande)
    mov  x9,  x4               // Y inicial 
    mov  x3,  1
	              // X inicial 

for_loop_1:
    cmp  x15, x8               
    b.ge end_loop_1
    add  x15, x15, #1          
    
	mov  x2, x15            
	mov x28,x8
	sub x28,x28,x15
	lsr x28,x28,1

	mov x3,x28
	add x3,x3,x18
	


    bl  draw_rectangle        
    b	for_loop_1
end_loop_1:
    ldp  x29, x30, [sp], #16   // restaura fp/lr
    ret




draw_right_triangle_inverted:
    stp  x29, x30, [sp, #16]!   // guarda fp/lr
    mov  x29, sp   
    mov  x15, #0               // contador de filas
    mov  x0,  x20              // reset fb
    mov  x1,  x16              // altura = 1
    mov  x2,  x17              // ancho inicial = 1 (se va haciendo mas grande)
    mov  x9,  x4               // Y inicial 
    add  x3,x3, x5               // X inicial 

for_loop_2:
    cmp  x15, x8               
    b.ge end_loop_2
    add  x15, x15, #1          
    
	mov  x2, x15            
	mov x28,x8
	sub x28,x28,x15	
	
	mov x3,x28
	add x3,x3,x18
    bl  draw_rectangle        
    b	for_loop_2
end_loop_2:
    ldp  x29, x30, [sp], #16   // restaura fp/lr
    ret


draw_route:
    stp  x29, x30, [sp, #16]!   // guarda fp/lr
    mov  x29, sp   
    //mov  x15, #90               // contador de filas

    mov  x0,  x20              // reset fb
    mov  x1,  x16              // altura = 1
    mov  x2,  x17              // ancho inicial = 1 (se va haciendo mas grande)
    mov  x9,  x4               // Y inicial 
    mov  x3,  x18 // X inicial 
	//x15 se encarga de cortar el fondo del triangulo
for_loop_3:
    cmp  x15, x8               
    b.ge end_loop_3
    add x15,x15,#7

	mov  x2, x15            
	mov x28,x8
	sub x28,x28,x15
	lsr x28,x28,1

	mov x3,x28
	add x3,x3,x18
	


    bl  draw_rectangle   
    bl  draw_rectangle        
    b	for_loop_3
end_loop_3:
    ldp  x29, x30, [sp], #16   // restaura fp/lr
    ret




/*loop_animacion:

    cmp x19, 640 // Si X supera el ancho de la pantalla
    bge reset_position      // Reiniciar posición si está fuera de los límites
    cmp x18, 480 // Si Y supera el alto de la pantalla
    bge reset_position

    add x19, x19, #5  // Mueve el auto en X
    add x18, x18, #1  // Mueve el auto en Y
    bl draw_car_2       // Redibuja el auto con nueva posición
    
    // Pequeño delay para simular la velocidad
    mov x8, #1000 
delay:
    subs x18, x18, #1
    bne delay
    b animation_loop  // Repetir animación


reset_position:
    mov x19, #30  // Reiniciar posición X
    mov x18, #1   // Reiniciar posición Y
    b animation_loop  // Volver a animar desde el inicio

*/

//------SECCION BACKUP DE CODIGO DE TESTEO------------

//	// TEST RECTANGULO
//	// CARA :-|
//	// dibujar cabeza
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 200 // alto del rectangullo
//	mov x2, 200 // ancho del rectangulo
//	mov x9, 140 // posicion y del rectangulo
//	mov x3, 50 // posicion x del rectangulo
//
//	movz x6, 0xC8, lsl 16 // color #c874f2
//	movk x6, 0x74f2, lsl 00
//
//	bl draw_rectangle
//	//mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//	// dibujar ojo izquierdo
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 20 // alto del rectangullo
//	mov x2, 20 // ancho del rectangulo
//	mov x9, 200 // posicion y del rectangulo
//	mov x3, 100 // posicion x del rectangulo
//
//	movz x6, 0x00, lsl 16 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//	//mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//
//	//Ceja izquierda
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 5 // alto del rectangullo
//	mov x2, 20 // ancho del rectangulo
//	mov x9, 190// posicion y del rectangulo
//	mov x3, 100 // posicion x del rectangulo
//
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//	//mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//	// dibujar ojo derecho
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 20 // alto del rectangullo
//	mov x2, 20 // ancho del rectangulo
//	mov x9, 200 // posicion y del rectangulo
//	mov x3, 180 // posicion x del rectangulo
//
//	movz x6, 0x00, lsl 16 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//	//mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//	// dibujar ceja derecha
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 5 // alto del rectangulo
//	mov x2, 20 // ancho del rectangulo
//    mov x9, 190 // pos y
//	mov x3, 180 // pos x
//
//	movz x6, 0x00, lsl 00 // color negro
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//	//mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//	
//	// dibujar boca
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 20 // alto del rectangullo
//	mov x2, 100 // ancho del rectangulo
//	mov x9, 270 // posicion y del rectangulo
//	mov x3, 100 // posicion x del rectangulo
//
//	movz x6, 0x00, lsl 16 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//	//mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//	//TEST CIRCULO
//	// cara :)
//	mov x0, x20 
//	mov x1, 450 // centro a(x)
//	mov x2, 240 // centro b(y)
//	mov x3, 100 // radio
//
//	movz x6, 0xF5, lsl 16 // color
//	movk x6, 0xBF42, lsl 00
//
//	bl draw_circle
//
//	// boca
//	mov x0, x20 
//	mov x1, 450 // centro a(x)
//	mov x2, 260 // centro b(y)
//	mov x3, 70 // radio
//
//	movz x6, 0x00, lsl 16 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_circle
//
//	// tapar mitad boca
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 90 // alto del rectangullo
//	mov x2, 140 // ancho del rectangulo
//	mov x9, 180// posicion y del rectangulo
//	mov x3, 380 // posicion x del rectangulo
//
//	movz x6, 0xF5, lsl 16 // color
//	movk x6, 0xBF42, lsl 00
//
//	bl draw_rectangle
//
//	// ojo izquierdo
//	mov x0, x20 
//	mov x1, 415 // centro a(x)
//	mov x2, 220 // centro b(y)
//	mov x3, 20 // radio
//
//	movz x6, 0x00, lsl 16
//	movk x6, 0x0000, lsl 00
//
//	bl draw_circle
//
//	//Ceja izquierda
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 5 // alto del rectangullo
//	mov x2, 30 // ancho del rectangulo
//	mov x9, 190// posicion y del rectangulo
//	mov x3, 400 // posicion x del rectangulo
//
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//
//	// ojo izquierdo
//	mov x0, x20 
//	mov x1, 480 // centro a(x)
//	mov x2, 220 // centro b(y)
//	mov x3, 20 // radio
//
//	movz x6, 0x00, lsl 16
//	movk x6, 0x0000, lsl 00
//
//	bl draw_circle
//
//
//
//	//Ceja derecha
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 5 // alto del rectangullo
//	mov x2, 30 // ancho del rectangulo
//	mov x9, 190// posicion y del rectangulo
//	mov x3, 465 // posicion x del rectangulo
//
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
//
//
//	//TEST PIXEL ART: (ODC)
////	 .equ PIXEL_SIZE, 4
////	 .equ DIR ,1
////	 .equ PADDING, 10
//	// movz x6, 0x00, lsl 00 // color
//	// movk x6, 0x0000, lsl 00
// 	// mov     x0, x20 //RESETEO FB
// 	// mov     x1, 1*DIR*PIXEL_SIZE+OFFSET_X      
// 	// mov     x2, 2*DIR*PIXEL_SIZE+OFFSET_Y
// 	// mov     x3, PIXEL_SIZE         // tamaño PIXEL_SIZE
// 	// mov     x4, x6
// 	// bl      draw_square
//	
////	mov x0,x20 
////	mov x1, 7*PIXEL_SIZE //ALTO
////	mov x2, PIXEL_SIZE //ANCHO
////	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 15 *	PIXEL_SIZE + PADDING//X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////	mov x0,x20 
////	mov x1, 7*PIXEL_SIZE //ALTO
////	mov x2, PIXEL_SIZE //ANCHO
////	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 19 *	PIXEL_SIZE + PADDING  //X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////
////	mov x0,x20 
////	mov x1, PIXEL_SIZE //ALTO
////	mov x2, 4*PIXEL_SIZE //ANCHO
////	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 15 *	PIXEL_SIZE + PADDING//X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////	mov x0,x20 
////	mov x1, PIXEL_SIZE //ALTO
////	mov x2, 5*PIXEL_SIZE //ANCHO
////	mov x9, 9 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 15 *	PIXEL_SIZE + PADDING//X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////	//LETRA D
////	.equ PADDING_L,27
////
////	mov x0,x20 
////	mov x1, 7*PIXEL_SIZE //ALTO
////	mov x2, PIXEL_SIZE //ANCHO
////	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 15 *	PIXEL_SIZE + PADDING+ PADDING_L//X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////	mov x0,x20 
////	mov x1, 6*PIXEL_SIZE //ALTO
////	mov x2, PIXEL_SIZE //ANCHO
////	mov x9, 3 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 19 *	PIXEL_SIZE + PADDING+ PADDING_L //X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////
////	mov x0,x20 
////	mov x1, PIXEL_SIZE //ALTO
////	mov x2, 3*PIXEL_SIZE //ANCHO
////	mov x9, 2 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 15 *	PIXEL_SIZE + PADDING+ PADDING_L//X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
////	mov x0,x20 
////	mov x1, PIXEL_SIZE //ALTO
////	mov x2, 3*PIXEL_SIZE //ANCHO
////	mov x9, 9 	*	PIXEL_SIZE 	+ PADDING //Y
////	mov x3, 15 *	PIXEL_SIZE + PADDING + PADDING_L//X
////	movz x6, 0x00, lsl 00 // color
////	movk x6, 0x0000, lsl 00
////	bl draw_rectangle
////
//
//	//test linea
//	mov x0, x20
//	mov x1, 320
//	mov x2, 240
//	mov x3, 300
//	mov x4, 300
//	movz x8, 0xFF, lsl 16
//	movk x8, 0xFF0F, lsl 00
//
//	bl draw_line
//
//	mov x0, x20
//	mov x1, 300
//	mov x2, 300
//	mov x3, 350
//	mov x4, 260
//	movz x8, 0xFF, lsl 16
//	movk x8, 0xFF0F, lsl 00
//
//	bl draw_line
//
//	mov x0, x20
//	mov x1, 350
//	mov x2, 260
//	mov x3, 290
//	mov x4, 260
//	movz x8, 0xFF, lsl 16
//	movk x8, 0xFF0F, lsl 00
//
//	bl draw_line
//
//	mov x0, x20
//	mov x1, 290
//	mov x2, 260
//	mov x3, 340
//	mov x4, 300
//	movz x8, 0xFF, lsl 16
//	movk x8, 0xFF0F, lsl 00
//
//	bl draw_line
//
//	mov x0, x20
//	mov x1, 340
//	mov x2, 300
//	mov x3, 320
//	mov x4, 240
//	movz x8, 0xFF, lsl 16
//	movk x8, 0xFF0F, lsl 00
//
//// Triángulo rectangulo 1 a (x=250, y=10)
//	mov x0, x20
//	mov x8, 120   // tamaño
//	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
//	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
//	mov x4, 250    // Y inicial
//	mov x5, 50   // X inicial
//	movz x6, 0xFF, lsl 16 // color
//	movk x6, 0xF0F0, lsl 00
//	bl  draw_right_triangle
//
//	//Triangulo equilatero
//	mov x0, x20
//	mov x8, 120   // tamaño
//	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
//	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
//	mov x4, 25    // Y inicial
//	mov x18, 388   // X inicial
//	movz x6, 0x00, lsl 16 // color
//	movk x6, 0x0000, lsl 00
//	bl  draw_triangle
//
//
//	mov x0, x20
//	mov x8, 120   // tamaño
//	mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
//	mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
//	mov x4, 250    // Y inicial
//	mov x18, 130  // X inicial
//	movz x6, 0xF8, lsl 16 // color
//	movk x6, 0xF9F9, lsl 00
//	bl  draw_right_triangle_inverted
//
//
//	//TEST POST LLAMADA A draw_right_triangle
//	mov x0, x20 // reinicia framebuffer
//	mov x1, 5 // alto del rectangullo
//	mov x2, 30 // ancho del rectangulo
//	mov x9, 10// posicion y del rectangulo
//	mov x3, 465 // posicion x del rectangulo
//	movz x6, 0x00, lsl 00 // color
//	movk x6, 0x0000, lsl 00
//
//	bl draw_rectangle
