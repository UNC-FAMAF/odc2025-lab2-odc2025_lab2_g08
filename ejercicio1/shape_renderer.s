// DEFINE DE FIGURAS
    .equ CIRCLE,    -3
    .equ SQUARE,    -4
    .equ RECTANGLE, -5
    .equ LINE,      -6
    .equ TRIANGLE,  -7
    .equ VALOR_DE_CORTE, -999

.section .data
.global car_1
car_1:
    // TIPO      | ALTO | ANCHO |    X     |    Y     |   COLOR
    .word RECTANGLE, 33,    75,    223+45, 338+20, 0x20389F  // carrocería principal
    .word RECTANGLE, 20,   100,    210+45, 350+20, 0x20389F  // techo
    .word RECTANGLE, 10,    46,    237+45, 344+20, 0x000000  // ventana
    .word RECTANGLE,  5,    24,    248+45, 359+20, 0xFFFFFF  // luz frontal
    .word RECTANGLE,  6,    96,    212+45, 369+20, 0x000000  // base inferior
    .word RECTANGLE,  5,   101,    209+45, 374+20, 0x20389F  // franja lateral
    .word RECTANGLE, 11,    25,    212+45, 379+20, 0x000000  // rueda izq
    .word RECTANGLE,  2,    15,    216+45, 380+20, 0x80383838 // guardabarros izq
    .word RECTANGLE, 11,    25,    284+45, 379+20, 0x000000  // rueda der
    .word RECTANGLE,  2,    15,    289+45, 380+20, 0x80383838 // guardabarros der
    .word RECTANGLE,  6,    17,    289+45, 360+20, 0xFFFFFF  // luz der
    .word RECTANGLE,  6,    17,    214+45, 360+20, 0xFFFFFF  // luz izq
    .word VALOR_DE_CORTE
car_1_end:

.global car_2
car_2:
    // TIPO      | ALTO | ANCHO |    X      |    Y      |    COLOR
    .word RECTANGLE, 12,    72,   162+140, 120+100, 0xFF00FF00
    .word RECTANGLE, 12,    84,   156+140, 132+100, 0xFF00FF00
    .word RECTANGLE, 18,    96,   150+140, 144+100, 0xFF00FF00
    .word RECTANGLE, 15,    60,   168+140, 126+100, 0x00000000
    .word RECTANGLE,  6,     6,   150+140, 150+100, 0x00000000
    .word RECTANGLE,  6,     6,   156+140, 150+100, 0x00F5BF42
    .word RECTANGLE,  6,     6,   240+140, 150+100, 0x00000000
    .word RECTANGLE,  6,     6,   240+140, 150+100, 0x00000000
    .word RECTANGLE,  6,     6,   234+140, 150+100, 0x00F5BF42
    .word RECTANGLE,  9,    24,   186+140, 150+100, 0xFFFFFF00
    .word RECTANGLE, 15,    18,   150+140, 162+100, 0x00000000
    .word RECTANGLE, 15,    18,   228+140, 162+100, 0x00000000
    .word VALOR_DE_CORTE
car_2_end:

.global rand
rand:
    // TIPO      | ALTO  | ANCHO |    X     |    Y     |   COLOR
    .word RECTANGLE, 480,  640,     0,    165, 0x52B589
    .word RECTANGLE, 150,  640,     0,    200, 0x309E6F
    .word VALOR_DE_CORTE
rand_end:

// render_shape:
//   X0 = dirección base del framebuffer
//   X8 = puntero al primer .word del shape (tipo, alto, ancho, x, y, color, …, VALOR_DE_CORTE)
//   Usará la convención:
//     X1 = posX, X2 = posY, X3 = color, X4 = alto, X5 = ancho
//     X20 = framebuffer/contexto de dibujo

.global render_shape
render_shape:
   
    STP     X29, X30, [SP, #-16]!   // guardar FP y LR
    MOV     X29, SP

.loop_component:
    // Cargar tipo y avanzar X8
    LDR     W9, [X8], #4           // W9 = tipo
    CMP     W9, #VALOR_DE_CORTE
    BEQ     .done                   // si es VALOR_DE_CORTE, terminamos

    // Cargar campos: alto, ancho, posX, posY, color
    LDR     W4,  [X8], #4            // W4 = alto
    LDR     W5,  [X8], #4            // W5 = ancho
    LDR     W14, [X8], #4           // W14 = posX
    LDR     W15, [X8], #4           // W15 = posY
    LDR     W6,  [X8], #4           // W6 = color

    // Mover a registros X (extender a 64 bits)
    MOV     W4, W4                  // X4 = alto
    MOV     W5, W5                  // X5 = ancho
    MOV     W1, W14                 // X1 = posX
    MOV     W2, W15                 // X2 = posY
    MOV     W3, W6                 // X3 = color

    // Preparar framebuffer/contexto
    MOV     X0, X20

    
    CMP     W9, #RECTANGLE
    BEQ     .draw_rect
    CMP     W9, #CIRCLE
    BEQ     .draw_circ
    CMP     W9, #LINE
    BEQ     .draw_line
    CMP     W9, #TRIANGLE
    BEQ     .draw_triang
    // Si no coincide ningún tipo, ignorar y continuar

    
    B       .loop_component

.draw_rect:
   

    BL      draw_rectangle

    B      .loop_component

.draw_circ:
    BL      draw_circle
    B       .loop_component

.draw_line:
    BL      draw_line
    B       .loop_component

.draw_triang:
    BL      draw_triangle
    B       .loop_component

.done:
    LDP     X29, X30, [SP], #16      // restaurar FP y LR
    RET
