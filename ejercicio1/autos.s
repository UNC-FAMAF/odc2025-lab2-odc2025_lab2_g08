//DEFINE DE FIGURAS
    .equ CIRCLE, -3
    .equ SQUARE, -4
    .equ RECTANGLE, -5
    .equ LINE, -6
    .equ TRIANGLE, -7
    .equ VALOR_DE_CORTE, -999
.section .data //Los siguientes datos se almacenaran en RAM
.global car_1
car_1:
    //auto 1
    // TIPO |ALTO | ANCHO | X | Y | C1 |
    .word RECTANGLE, 33, 75, 223+45, 338+20, 0x20389F  // carrocería principal
    .word RECTANGLE, 20, 100, 210+45, 350+20, 0x20389F // techo
    .word RECTANGLE, 10, 46, 237+45, 344+20, 0x00000000 // ventana
    .word RECTANGLE, 5, 24, 248+45, 359+20, 0xFFFFFFFF              // luz frontal
    .word RECTANGLE, 6, 96, 212+45, 369+20, 0x00000000              // base inferior
    .word RECTANGLE, 5, 101, 209+45, 374+20, 0x20389F // franja lateral
    .word RECTANGLE, 11, 25, 212+45, 379+20, 0x00000000  // rueda izq
    .word RECTANGLE, 2, 15, 216+45, 380+20, 0x80383838   // guardabarros izq
    .word RECTANGLE, 11, 25, 284+45, 379+20, 0x00000000  // rueda der
    .word RECTANGLE, 2, 15, 289+45, 380+20, 0x80383838              // guardabarros der
    .word RECTANGLE, 6, 17, 289+45, 360+20, 0xFFFFFFFF              // luz der
    .word RECTANGLE, 6, 17, 214+45, 360+20, 0xFFFFFFFF              // luz izq
    .word VALOR_DE_CORTE //poner VALOR_DE_CORTE asi el procedimiento render_shape sabe cuando termina un auto
car_1_end:

.global car_2
car_2:
    // AUTO 2 (escalado al 60 % para reducir 40 %)

    // TIPO |ALTO | ANCHO | X | Y | C1 | C2 |
    .word RECTANGLE, 12, 72, 162+140, 120+100, 0xFF00FF00
    .word RECTANGLE, 12, 84, 156+140, 132+100, 0xFF00FF00
    .word RECTANGLE, 18, 96, 150+140, 144+100, 0xFF00FF00
    .word RECTANGLE, 15, 60, 168+140, 126+100, 0x00000000
    .word RECTANGLE, 6, 6, 150+140, 150+100, 0x00000000
    .word RECTANGLE, 6, 6, 156+140, 150+100, 0x00F5BF42
    .word RECTANGLE, 6, 6, 240+140, 150+100, 0x00000000
    .word RECTANGLE, 6, 6, 240+140, 150+100, 0x00000000
    .word RECTANGLE, 6, 6, 234+140, 150+100, 0x00F5BF42
    .word RECTANGLE, 9, 24, 186+140, 150+100, 0xFFFFFFFF
    .word RECTANGLE, 15, 18, 150+140, 162+100, 0x00000000
    .word RECTANGLE, 15, 18, 228+140, 162+100, 0x00000000
    .word VALOR_DE_CORTE
car_2_end:

.global rand

rand:
    //      TIPO    |ALTO | ANCHO | X | Y | C |
    .word RECTANGLE, 480, 640, 0, 165, 0x52b589
    .word RECTANGLE, 150, 640, 0, 200, 0x309E6F

    .word VALOR_DE_CORTE //valor de corte

rand_end:

//El opcode ADR carga en un registro una dirección de memoria,
//calculada en tiempo de "compilacion", relativa a la posición actual del programa (pc: Program Counter registro
//que contiene la direccion de la instruccion en el programa que esta siendo ejecutada
//entradas:
// X8 = Direccion base del auto que se quiera cargar
//(se utiliza la instruccion ADR, que carga una dirección relativa cercana
// cuando la etiqueta está dentro de ±1MB)
//En este caso los datos que componen al auto estan cerca los 7 * 12 palabras que componen al auto
.global render_shape
render_shape:
    STP X29, X30, [SP, #-16]!
    MOV X29, SP

.loop_component:
    LDR W17, [X8], #4 // W0 = tipo
    CMP W17, #VALOR_DE_CORTE
    BEQ .done

    LDR W1, [X8], #4          // altura
    LDR W2, [X8], #4          // ancho
    LDR W3, [X8], #4          // posX
    LDR W9, [X8], #4          // posY
    LDR W4, [X8], #4          // color1

    MOV W6, W4

    MOV X0, X20 // X20 contiene framebuffer o contexto de dibujo

    // "switch (tipo)"
    CMP W17, #RECTANGLE
    BEQ .draw_rect

    CMP W17, #CIRCLE
    BEQ .draw_circ

    CMP W17, #LINE
    BEQ .draw_line

    CMP W17, #TRIANGLE
    BEQ .draw_triang

    B .loop_component // Si no se reconoce, ignora

.draw_rect:
    BL draw_rectangle
    B .loop_component

.draw_triang:
    //Triangulo equilatero
    MOV W8, W1 // tamaño
    //MOV     X16, 1    // alto = 1 //pixel_size NO CAMBIAR
    //MOV     X17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
    MOV W4, W9        // Y inicial
    MOV W18, W3       // X inicial
    BL draw_triangle

    B .loop_component

.draw_circ:

    MOV W3, W1

    BL draw_circle

    B .loop_component

.draw_line:
    BL draw_line

    B .loop_component

.done:
    LDP X29, X30, [SP], #16
    RET

.global move_shape
move_shape:
    STP X29, X30, [SP, #-16]!
    MOV X29, SP

    // Entradas:
    // X8 = puntero al primer componente de la forma
    // W1 = deltaX, W2 = deltaY

    MOV X10, X8 // puntero cursor

.loop_move:
    LDR W17, [X10]// W17 = tipo
    CMP W17, #VALOR_DE_CORTE
    BEQ .done_move

    // --- actualizar posX (offset 12 bytes: campo #4) ---
    LDR W3, [X10, #12]
    ADD W3, W3, W1
    STR W3, [X10, #12]

    // --- actualizar posY (offset 16 bytes: campo #5) ---
    LDR W4, [X10, #16]
    ADD W4, W4, W2
    STR W4, [X10, #16]

    // --- avanzar al siguiente componente según el tipo ---
    // RECTANGLE=-5, LINE=-6 → 6 campos (6×4=24 bytes)
    CMP W17, #RECTANGLE
    BEQ .skip_6
    CMP W17, #LINE
    BEQ .skip_6

    // CIRCLE=-3, TRIANGLE=-7 → 7 campos (7×4=28 bytes)
    CMP W17, #CIRCLE
    BEQ .skip_7
    CMP W17, #TRIANGLE
    BEQ .skip_7

    // si no coincide, saltamos 6 por defecto
.skip_6:
    ADD X10, X10, #24
    B .loop_move

.skip_7:
    ADD X10, X10, #28
    B .loop_move

.done_move:
    LDP X29, X30, [SP], #16
    RET





    .global scale_shape
// ----------------------------------------------------------------------------
// scale_shape:
//   Escala en el lugar todas las componentes de una figura.
// Entradas:
//   X8 = puntero al primer campo (tipo) de la forma
//   W1 = factor de escala en %, p. ej. 60 → reduce al 60%
// ----------------------------------------------------------------------------
scale_shape:
    STP     X29, X30, [SP, #-16]!  // prologue
    MOV     X29, SP

    MOV     W7, #100               // divisor fijo para porcentajes
    MOV     X10, X8               // cursor = base de la forma
    MOV     W2, W1                // W2 = scale_percent

.loop:
    LDR     W17, [X10]            // tipo
    CMP     W17, #VALOR_DE_CORTE
    BEQ     .done1

    // --- altura @ offset +4 ---
    ADD     X11, X10, #4
    LDR     W3, [X11]
    MUL     W3, W3, W2
    UDIV    W3, W3, W7
    STR     W3, [X11]

    // --- ancho @ offset +8 ---
    ADD     X12, X10, #8
    LDR     W4, [X12]
    MUL     W4, W4, W2
    UDIV    W4, W4, W7
    STR     W4, [X12]

    // --- posX @ offset +12 ---
    ADD     X11, X10, #12
    LDR     W5, [X11]
    MUL     W5, W5, W2
    UDIV    W5, W5, W7
    STR     W5, [X11]

    // --- posY @ offset +16 ---
    ADD     X12, X10, #16
    LDR     W6, [X12]
    MUL     W6, W6, W2
    UDIV    W6, W6, W7
    STR     W6, [X12]

    // Avanzar al siguiente componente:
    // RECTANGLE/LINE: 6 campos ×4 = 24 bytes
    // CIRCLE/TRIANGLE: 7 campos ×4 = 28 bytes
    CMP     W17, #RECTANGLE
    BEQ     .skip6
    CMP     W17, #LINE
    BEQ     .skip6
    CMP     W17, #CIRCLE
    BEQ     .skip7
    CMP     W17, #TRIANGLE
    BEQ     .skip7

.skip6:
    ADD     X10, X10, #24
    B       .loop

.skip7:
    ADD     X10, X10, #28
    B       .loop

.done1:
    LDP     X29, X30, [SP], #16   // epilogue
    RET

