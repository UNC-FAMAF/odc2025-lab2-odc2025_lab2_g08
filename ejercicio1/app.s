    .equ SCREEN_WIDTH, 640
    .equ SCREEN_HEIGHT, 480
    .equ BITS_PER_PIXEL, 32
    .equ GPIO_BASE, 0x3f200000
    .equ GPIO_GPFSEL0, 0x00
    .equ GPIO_GPLEV0, 0x34

.globl main
main:
    MOV x20, x0 //Backup de x0

    BL draw_back
    BL draw_rutoide
    //ADR X8,car_2
    //BL render_shape

    ADR x8, car_1
    MOV w1, #80
    BL scale_shape

    ADR x8, car_1
    MOV w1, #170
    MOV w2, #90

    BL move_shape

    MOV X21,#-1 
    MOV X23,#0  //CADA 19 TICKS CAMBIA DE DIRECCION
    MOV X24,#10 // AUTO POS X
    MOV X25,#2 // AUTO POS Y
    MOV X26,#8//PARA RUTA

change_dir:
    MUL X24,X24,X21
    MUL X25,X25,X21
    MOV X23,#0
    B infloop

infloop:

    CMP X23,#17
    B.GE change_dir

    MUL X26,X26,X21

    BL draw_rutoide

    ADR x8, car_1

    MOV X1, X24
    MOV X2, X25

    BL move_shape

    BL render_shape

    SUB w1, w1, #1
    BL scale_shape

    BL funcion_delay
    ADD X23,X23,#1

    B infloop

funcion_delay:

    LDR x8, =0x04ffffff // Ajusta este valor según necesites más tiempo
delay:
    SUB x8, x8, #1 // Reduce el contador
    CBNZ x8, delay

    RET

draw_back:
    STP x29, x30, [sp, #-16]!
    MOV x29, sp

    //PASTO1
    MOV x0, x20
    MOV x1, #0 // x
    MOV x2, #165 // y
    LDR x3, =0x52b589 // //color
    MOV x4, #480 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle_1

    //PASTO2
    MOV x0, x20
    MOV x1, #0 // x
    MOV x2, #200 // y
    LDR x3, =0x309E6F // //color
    MOV x4, #150 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle_1

    //BANQUINA 1
    MOV x0, x20
    MOV x1, #40
    MOV x2, #535
    LDR x3, =0xf7caa2
    MOV x4, #400
    BL draw_shoulder_1

    //BANQUINA 2
    MOV x0, x20
    MOV x1, #195
    MOV x2, #535
    LDR x3, =0xf7caa2
    MOV x4, #400
    BL draw_shoulder_2

    //CIELO
    MOV x0, x20
    MOV x1, #0 // x
    MOV x2, #0 // y
    LDR x3, =0x08b9ce //color
    MOV x4, #165 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle_1

    //sol
    MOV x0, x20
    MOV x1, 480    // centro a(x)
    MOV x2, 20     // centro b(y)
    MOV x3, 60     // radio
    MOVZ x6, 0xF5, lsl16 // color
    MOVK x6, 0xBF42, lsl00
    BL draw_circle

    //MONTAÑA 3
    MOV x0, x20
    MOV x1, #20
    MOV x2, #164
    LDR x3, =0xE67E22
    MOV x4, #120
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 1
    MOV x0, x20
    MOV x1, #0
    MOV x2, #165
    LDR x3, =0xF39C12
    MOV x4, #80
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 2
    MOV x0, x20
    MOV x1, #70
    MOV x2, #164
    LDR x3, =0xF39C12
    MOV x4, #90
    MOV x12, #1
    BL draw_triangle_1

    //MONTAÑA 4
    MOV x0, x20
    MOV x1, #20+420
    MOV x2, #164
    LDR x3, =0xE67E22
    MOV x4, #180
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 5
    MOV x0, x20
    MOV x1, #0+420
    MOV x2, #165
    LDR x3, =0xF39C12
    MOV x4, #80
    MOV x12, #1
    BL draw_triangle_1
    //MONTAÑA 6
    MOV x0, x20
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
    //RUTA
    MOV x0, x20
    MOV x1, #8
    MOV x2, #710
    LDR x3, =0x50748c
    MOV x4, #620
    BL draw_route_1

    //LINEAS DE RUTAS
    MOV x0, x20
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
    MOV x0, x20
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

/* -----------------------------------------------------
 | CONVENCION DE USO DE REGISTROS USADO EN ESTE LAB:     |
   -----------------------------------------------------
    X0         : Utilizado para manipular el FB
    X20        : Utilizado para manipular el FB
--------------------------------------------------------
    X1  - X7   : INPUT/OUTPUT para funciones
    x8         : Registro usado por qemu
    x9  - x15  : Registros de uso temporal, no se necesita guardarlos ni restaurarlos
    x16 - x18  : Registros para contadores en los ciclos
    x19 - X28  : En caso de usarse se deben guardar y restaurar (LDR/STR)(Registros NO-VOLATILES)
    X29 - X31  : | NO USAR |FP Frame pointer, LR Link register, SP stack pointer
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
    BL get_relative_pix_addr //En x7 esta el return value

    MOV w10, w3    //Muevo el color a w10
    STUR w10, [x7] //X7 retorna get_relative_pix_addr

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

/*Función [draw_square]
Entradas:
    x0 = base addr fb
    x1 = POS X
    x2 = POS Y
    x3 = color (LDR x4,=0xFFFFFFFF)
    x4 = Tamaño
Salidas:
    Ninguna, solo usar registros volatiles
*/
draw_square_1:
    STP x29, x30, [sp, #-16]!
    MOV x29, sp
    MOV x16, #0 //Contador i = 0

ver_draw_square:
    CMP x16, x4 //Comparo i con el tamaño
    B.GE end_ver_draw_square
    MOV x17, #0 // j = 0

hor_draw_square:
    CMP x17, x4
    B.GE end_hor_draw_square
    ADD x1, x1, #1
    BL get_relative_pix_addr //En x7 esta el return value

    MOV w10, w3    //Muevo el color a w10
    STUR w10, [x7] //X7 retorna get_relative_pix_addr

    ADD x17, x17, #1 //j++
    B hor_draw_square

end_hor_draw_square:
    SUB x1, x1, x17     //X = X - j
    ADD x2, x2, #1      //Y = Y + 1
    ADD x16, x16, #1    //i++
    B ver_draw_square

end_ver_draw_square:
    LDP x29, x30, [sp], #16
    RET

/*Funcion [get_relative_pix_addr]
 Entradas:
   x0 = base del framebuffer
   x1 = pos X
   x2 = pos Y
 Salida:
   x7 = base + 4 * (x2 + x1 * x10) */
get_relative_pix_addr:
    //Prologue salvar FP (x29) y LR (x30)
    //El [STP] significa store pair
    STP x29, x30, [sp, #-16]! // push {x29, x30}
    MOV x29, sp
    //Establecer nuevo frame pointer
    MOV x10, SCREEN_WIDTH
    MUL x9, x2, x10 //x9 = Y * SCREEN_WIDTH
    ADD x9, x9, x1 // x9 = Y*W + X
    LSL x9, x9, #2 // x9 = (Y*W + X) << 2  (multiplica por 4)
    ADD x7, x0, x9 // x7 = fb_base + offset
    // Epilogue: restaurar FP y LR
    LDP x29, x30, [sp], #16 //restauramos el frame pointer y el link register
    //[LDP] Load pair,los trae de vuelta desde memoria
    //reseteo parametros de entrada
    RET
