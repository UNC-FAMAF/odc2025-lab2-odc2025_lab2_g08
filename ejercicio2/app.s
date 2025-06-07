.include "constants.inc"
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
.equ PLANE_OFFSET,15

.globl main
main:
    MOV x20, x0 // Guarda la dirección base del framebuffer en x20 (backup de x0)
    
main_init:
    //Procedimiento [draw_static_background] escrito en: [background.s]

    BL draw_grass
    BL draw_static_background
    BL draw_route_lines_dyn
    
    //GOLF R32
    ADR X8, car_8
    MOV X1, 200
    BL scale_shape
    MOV W1, #-70
    MOV W2, #-165
    BL move_shape
    
    //PORSHE
    ADR X8, car_6
    MOV W1, #185
    MOV W2, #240
    BL move_shape
    BL render_shape

    //MUSTANG
    ADR x8,car_9
    
    MOV X1,#70
    BL scale_shape
    MOV W1,#290
    MOV W2,#160
    BL move_shape
    BL render_shape


    //AVION
    ADR X27, plane_1
    MOV X8, X27
    MOV W1, #1
    MOV W2, #60
    BL move_shape
    BL render_shape

    
    ADR X28, plane_2
    MOV X8,X28
    MOV W1, #1
    MOV W2, #60
    BL move_shape
    BL render_shape

    .equ PaddingRouteLine,6
     MOV x25,#PaddingRouteLine //Cuanto se mueve de arriba a abajo las lineas
    /*
        Preparo la stack para poder almacenar la variable contador que nos va permitir
        animar las lineas de la ruta
     */
     SUB SP, SP, #32
     STR XZR, [sp, #8] //n = 0 en sp + 8
     STR XZR, [SP,#16] //m = 0
     STR XZR, [SP,#24] // mustang tracker 

game_loop:
    
    
    MOV X21,XZR
    LDR X21,[SP,#8]
    CMP x21,#2
    B.GE change_rect_dir
    
    MOV X21,XZR
    LDR X21,[SP,#16]
    CMP X21, #2
    B.GE move_car_ford
    

    BL draw_sky

    BL choose_plane
    MOV W1, #PLANE_OFFSET
    MOV W2, WZR
    BL move_shape
    BL render_shape
    
    //INCREMENTO EL CONTADOR n++
    LDR X21,[SP,#8]
    ADD X21,X21,#1
    STR X21,[SP,#8]

    //INCREMENTO EL CONTADOR M++
    LDR X21,[SP,#16]
    ADD X21,X21,#1
    STR X21,[SP,#16]

    //INCREMENTO EL CONTADOR Mustang tracker
    LDR X21,[SP,#24]
    ADD X21,X21,#1
    STR X21,[SP,#24]

    BL delay 
    B game_loop



move_car_ford:

    STR XZR,[SP,#16] //m = 0 //reseteo el counter m
    ADR X18,car_9
    
    LDR X15,[SP,#24] //MUSTANG TRACKER
    CMP X15,#90
    B.GE reset_mustang

    //renderizado de autos
    MOV X8,XZR
    MOV X1,XZR
    MOV X2,XZR
    //MUSTANG
    ADR X8,car_9
    MOV W1,#2
    MOV W2,#5
    BL move_shape
    BL render_shape

    //fin renderizado de autos
    B game_loop



reset_mustang:

    STR XZR,[SP,#24]
    //renderizado de autos
    MOV X8,XZR
    MOV X1,XZR
    MOV X2,XZR
    //MUSTANG
    
    ADR X8,car_9
    MOV W1,#296
    MOV W2,#120
    BL set_position
    BL render_shape


    //fin renderizado de autos
    B move_car_ford

change_rect_dir:

    NEG X25,X25 //MUL x25,x25,x22 // [x25] * (-1)
    STR XZR,[SP,#8]
    
    BL draw_rgt_shoulder
    BL draw_static_background
    BL draw_route_lines_dyn

    //renderizado de autos
    MOV X8,XZR
    MOV X1,XZR
    MOV X2,XZR

    ADR X8, car_8
    NEG X25,X25
    MOV X1,X25,LSL 1
    BL move_shape
    NEG X25,X25
    BL render_shape
    
    ADR X8, car_6
    MOV X2,X25
    MOV X1,X25
    BL move_shape
    BL render_shape  
    //fin renderizado de autos
    B game_loop



draw_route_lines_dyn:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
    .equ rl_h,25
    .equ rl_p,37
    //Rect example
    MOV X0,X20
    MOV x1, #305 // x
    MOV x2, #172 // y
    MOVZ x3, #0XFF,LSL 16 // //color
    MOVK X3, #0XFFFF,LSL 0
    MOV x4, #rl_h // alto
    MOV x5, #5 // ancho

    //(ANIM) LE SUMO EL OFFSET SETEADO EN x25, QUE VA IR HACIENDO -30,30,-30,30.... 
    ADD X2,X2,X25 //animado

    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle
    ADD X2,X2,#rl_p
    BL draw_rectangle


    //Algo asi puede funcionar para el pasto
    ////PASTO 2
    //MOV X0,X20
    //MOV x1, #0 // x
    //MOV x2, #240 // y
    //LDR x3, =0x309E6F // //color
    //MOV x4, #20 // alto
    //MOV x5, #170 // ancho
    //ADD X2,X2,X25 //animado

   // BL draw_rectangle

    LDP X29,X30,[SP],#16
    RET


