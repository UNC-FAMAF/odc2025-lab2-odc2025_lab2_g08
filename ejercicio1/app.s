.include "helpers.s"
/* -----------------------------------------------------
 | CONVENCION DE USO DE REGISTROS QUE USAMOS EN ESTE LAB |
  ------------------------------------------------------
    X20        : Utilizado para manipular el FB
 -------------------------------------------------------
    X0  - X7   : INPUT/OUTPUT para funciones(The PCS says that the first argument is passed in X0, 
                 the second argument in X1, and so on up to X7. Any further arguments are passed on the stack.)

    x8         : Registro usado por qemu
---------------------------------------------------------
The PCS defines which registers can be corrupted, and which registers cannot be
corrupted. If a register can be corrupted, then the called function can overwrite without needing to restore
    
    x9  - x12  : Registros de uso temporal, no se necesita guardarlos ni restaurarlos
    
    x13 - x15  : Registros para contadores en los ciclos 
    
    x16 - x17  : IP0,IP1 Intra-procedure corruptible registers (segun armv8 ISA doc)

    x19 - X28  : (CALLEE-SAVED Registers) En caso de usarse se deben guardar y restaurar (LDR/STR)(Registros NO-VOLATILES)
    
    X29 - X31  : | NO USAR |FP Frame pointer, LR Link register, SP stack pointer

RECAP:
    La funcion foo() puede usar los registros x0-x15 sin la necesidad de preservar sus valores en la pila, en cambio
    si la funcion foo() usa los registros x19-x28 la funcion DEBE guardar los valores en la pila y restablecerlos antes
    de retornar.


--------------------------------------------------------
    CONVENCION PARA LA DEFINICION DE FIGURAS
--------------------------------------------------------
    nombre_de_funcion:
    x1 --> x
    x2 --> y
    x3 --> color
    x4 --> resto de parametros necesarios
    .
    .
    .
    x7
-------------------------------------------------------
 */
    
.global main
main:
    // x0 = puntero al framebuffer inicializado (front)
    MOV     x20, x0              // guardar front buffer en x20
    LDR     x1, =BACKGROUND_FB
    ADD     x21, x20, x1         // x21 = back buffer
    
    BL draw_rutoide
    
main_init:
    //Dibujar en back buffer
    MOV     x0, x21
    BL draw_back
    BL draw_rutoide
    //ADR X8,car_2
    //BL render_shape

    ADR x8, car_1
    MOV w1, #84
    BL scale_shape


    ADR x8, car_2
    MOV w1, #82
    BL scale_shape

    ADR x8, car_2
    MOV w1, #18
    MOV w2, #28

    BL move_shape

    ADR x8, car_1
    MOV w1, #5
    MOV w2, #90

    BL move_shape

    MOV     x27, #-1

    MOV     x23, #0
    MOV     x28, #0

    
    MOV     x24, #7
    MOV     x25, #2
    
    MOV     x26, #7
    MOV     x22, #20

    

anim_loop:
    
    CMP X23,#17
    B.GE change_dir

    CMP X28,#2
    B.GE move_grass


    MUL X26,X26,X27

   
    ADR x8, car_1
    MOV X1, X24
    MOV X2, X25

    BL move_shape
    BL render_shape

    ADD X23,X23,#1
    ADD X28,X28,#1

    MOV X1,XZR
    MOV X2,XZR 
    
    ADR X8,car_2
    MOV X1, X25 
    MOV X2, X24 
    BL move_shape    
    BL render_shape

    MOV X1,XZR
    MOV X2,XZR 
    
    BL      delay
    BL      draw_rutoide

    //Copiar back buffer al front buffer
    MOV     x2, x20             // destino: front
    MOV     x1, x21            // src: back
    BL      copy_back_to_fore

    B       anim_loop

change_dir:
    MUL     x24, x24, x27
    MUL     x25, x25, x27
    MOV     x23, #0
    B       anim_loop

move_grass:
    MUL x22,x22,X27
    MOV     x28, #0
    B anim_loop


draw_back:
    STP x29, x30, [sp, #-16]!
    MOV x29, sp



    //CIELO
    MOV X0,X21
    MOV x1, #0 // x
    MOV x2, #0 // y
    LDR x3, =0x08b9ce //color
    MOV x4, #165 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle_1

    //sol
    MOV X0,X21
    MOV x1, 480    // centro a(x)
    MOV x2, 20     // centro b(y)
    MOV x3, 60     // radio
    MOVZ x6, 0xF5, lsl16 // color
    MOVK x6, 0xBF42, lsl00
    BL draw_circle

    //MONTAÑA 3
    MOV X0,X21
    MOV x1, #20
    MOV x2, #164
    LDR x3, =0xE67E22
    MOV x4, #120
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 1
    MOV X0,X21
    MOV x1, #0
    MOV x2, #165
    LDR x3, =0xF39C12
    MOV x4, #80
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 2
    MOV X0,X21
    MOV x1, #70
    MOV x2, #164
    LDR x3, =0xF39C12
    MOV x4, #90
    MOV x12, #1
    BL draw_triangle_1

    //MONTAÑA 4
    MOV X0,X21
    MOV x1, #20+420
    MOV x2, #164
    LDR x3, =0xE67E22
    MOV x4, #180
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 5
    MOV X0,X21
    MOV x1, #0+420
    MOV x2, #165
    LDR x3, =0xF39C12
    MOV x4, #80
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 6
    MOV X0,X21
    MOV x1, #70+470
    MOV x2, #164
    LDR x3, =0xF39C12
    MOV x4, #90
    MOV x12, #1
    BL draw_triangle_1

    LDP x29, x30, [sp], #16
    RET


draw_rutoide:
    STP x29, x30, [sp, #-64]!
    MOV x29, sp
    
    //PASTO1
    MOV X0,X21
    MOV x1, #0 // x
    MOV x2, #165 // y
    LDR x3, =0x52b589 // //color
    MOV x4, #480 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle_1

    //PASTO2
    MOV X0,X21
    MOV x1, #0 // x
    MOV x2, #240 // y
    LDR x3, =0x309E6F // //color
    MOV x4, #165 // alto
    MOV x5, #640 // ancho
    ADD X2,X2,x22 //ANIM PASTO
    BL draw_rectangle_1

        //BANQUINA 1
    MOV x0, x21
    MOV x1, #40
    MOV x2, #535
    LDR x3, =0xf7caa2
    MOV x4, #400
    BL draw_shoulder_1

    //BANQUINA 2
    MOV x0, x21
    MOV x1, #195
    MOV x2, #535
    LDR x3, =0xf7caa2
    MOV x4, #400
    BL draw_shoulder_2

    //CIELO2
    MOV X0,X21
    MOV x1, #160 // x
    MOV x2, #115 // y
    LDR x3, =0x08b9ce //color
    MOV x4, #50 // alto
    MOV x5, #225 // ancho
    BL draw_rectangle_1
    //RUTA
    MOV X0,X21
    MOV x1, #8
    MOV x2, #710
    LDR x3, =0x50748c
    MOV x4, #620
    BL draw_route_1

    
    //LINEAS DE RUTAS
    MOV X0,X21
    MOV x1, #315 // x
    MOV x2, #174 // y
    
    
    ADD X2,X2,X26 //ANIM
    
    
    LDR x3, =0xFFFFFF //color
    MOV x4, #23 // alto
    MOV x5, #5 // ancho
    BL draw_route_lines

    LDP X29,X30,[SP],#16
    RET

draw_route_lines:
    STP x29, x30, [sp, #-64]!
    MOV x29, sp
    STP x1, x2, [sp, #16]
    STP x4, x5, [sp, #48]

    MOV x19, #0

for_rl:
    CMP x19, #9
    B.GE end_for_rl
    MOV X0,X21
    BL draw_rectangle_1
    ADD x2, x2, #40

    ADD x19, x19, #1
    B for_rl

end_for_rl: 
    LDP x4, x5, [sp, #48]
    LDP x1, x2, [sp, #16]
    LDP x29, x30, [sp], #64
    RET

draw_shoulder_2:
    STP x29, x30, [sp, #-64]!
    MOV x29, sp
    STP x1, x2, [sp, #16]
    STP x4, x5, [sp, #48]

    MOV x5, x4
    MOV x4, #7 //modifico la altura/ estiramiento
    MOV x16, #0
    //ADD x5, x5, x4
for_shoulder_1:
    CMP x16, x5
    B.GE end_for_shoulder_1

    BL draw_rectangle_1

    ADD x1, x1, #3
    SUB x2, x2, x4
    SUB x5, x5, x4

    ADD x16, x16, 10
    B for_shoulder_1

end_for_shoulder_1:

    LDP x4, x5, [sp, #48]
    LDP x1, x2, [sp, #16]
    LDP x29, x30, [sp], #64
    RET

draw_shoulder_1:
    STP x29, x30, [sp, #-64]!
    MOV x29, sp
    STP x1, x2, [sp, #16]
    STP x4, x5, [sp, #48]

    MOV x5, x4
    MOV x4, #7 //modifico la altura/ estiramiento
    MOV x16, #0
    //ADD x5, x5, x4
for_shoulder:
    CMP x16, x5
    B.GE end_for_shoulder

    BL draw_rectangle_1

    ADD x1, x1, #4
    SUB x2, x2, x4
    SUB x5, x5, x4

    ADD x16, x16, 10
    B for_shoulder

end_for_shoulder:

    LDP x4, x5, [sp, #48]
    LDP x1, x2, [sp, #16]
    LDP x29, x30, [sp], #64
    RET

draw_triangle_1:
    STP x29, x30, [sp, #-64]!
    MOV x29, sp
    STP x1, x2, [sp, #16]
    STP x4, x5, [sp, #48]

    MOV x5, x4
    MOV x4, x12 //modifico la altura/ estiramiento
    MOV x16, #0
    ADD x5, x5, x4
for_triangle:
    CMP x16, x5
    B.GE end_for_triangle

    BL draw_rectangle_1

    ADD x1, x1, #1
    SUB x2, x2, x12
    SUB x5, x5, #2

    ADD x16, x16, 1
    B for_triangle

end_for_triangle:

    LDP x4, x5, [sp, #48]
    LDP x1, x2, [sp, #16]
    LDP x29, x30, [sp], #64
    RET

draw_route_1:
    STP x29, x30, [sp, #-64]!
    MOV x29, sp
    STP x1, x2, [sp, #16]
    STP x4, x5, [sp, #48]

    MOV x5, x4
    MOV x4, #2 //modifico la altura/ estiramiento
    MOV x16, #0
    //ADD x5, x5, x4
for_route:
    CMP x16, x5
    B.GE end_for_route

    BL draw_rectangle_1

    ADD x1, x1, #1
    SUB x2, x2, x4
    SUB x5, x5, x4

    ADD x16, x16, 70
    B for_route

end_for_route:

    LDP x4, x5, [sp, #48]
    LDP x1, x2, [sp, #16]
    LDP x29, x30, [sp], #64
    RET



/*Función [draw_triangle]
Entradas:
    x0 = base addr fb
    x1 = POS X
    x2 = POS Y
    x3 = color (LDR x4,=0xFFFFFFFF)
    x4 = tam base
Salidas:
    Ninguna, solo usar registros volatiles
/*Función [draw_rectangle]
Entradas:
    x0 = base addr fb
    x1 = POS X
    x2 = POS Y
    x3 = color (LDR x4,=0xFFFFFFFF)
    x4 = alto
    x5 = ancho
Salidas:
    Ninguna, solo usar registros volatiles
*/

draw_rectangle_1:

    STP x29, x30, [sp, #-48]!
    MOV x29, sp
    STP x1, x2, [sp, #16]
    STR x5, [sp, #32]

    MOV x16, #0 //Contador i = 0

ver_draw_rectangle:
    CMP x16, x4 //Comparo i con el tamaño
    B.GE end_ver_draw_rectangle
    MOV x17, #0 // j = 0

hor_draw_rectangle:
    CMP x17, x5
    B.GE end_hor_draw_rectangle
    ADD x1, x1, #1
    BL get_rel_pix_addr //En x7 esta el return value

    MOV w10, w3    //Muevo el color a w10
    STUR w10, [x7] //X7 retorna get_rel_pix_addr

    ADD x17, x17, #1 //j++
    B hor_draw_rectangle

end_hor_draw_rectangle:
    SUB x1, x1, x17     //X = X - j
    ADD x2, x2, #1      //Y = Y + 1
    ADD x16, x16, #1    //i++
    B ver_draw_rectangle

end_ver_draw_rectangle:
    LDR x5, [sp, #32]
    LDP x1, x2, [sp, #16]
    LDP x29, x30, [sp], #48
    RET





// Subrutina: dibujar circulo
// (x-a)² + (y-b)² <= r²
.global draw_circle
draw_circle:
    stp x29, x30, [sp, #-16]!     // decrementar SP en 16 y guardar FP/LR
    mov x29, sp                   // establecer nuevo frame pointer
    sub x9, x2, x3 //y = b - r (posicion inicial y)

    mul x11, x3, x3    //r²
    lsl x12, x3, 1     // 2r para x (cota superior)
    lsl x13, x3, 1     // 2r para y (cota superior)

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

    ldp x29, x30, [sp], #16 // restaurar FP/LR y subir SP
    ret

