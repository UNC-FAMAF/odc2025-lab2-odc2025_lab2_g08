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
.equ PLANE_OFFSET,10

.globl main
main:
    MOV x20, x0 // Guarda la dirección base del framebuffer en x20 (backup de x0)
    
main_init:
    //Procedimiento [draw_static_background] escrito en: [background.s]

    BL draw_static_background
    Bl draw_cars

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

    MOV X26,#1


    /*
        EJEMPLO DE RECTANGULO MOVIENDOSE DE ARRIBA HACIA ABAJO
        x21 VA SER EL COUNTER
        x22 EL -1
        x25 EL OFFSET
        OBS: SE USAN REGISTROS NO VOLATILES
     */
     
     MOV x21,#0
     MOV x22,#-1
     MOV x25,30
     
     SUB SP, SP, #16
     STR XZR, [sp, #8] //n = 0 en sp + 8

game_loop:

    //CMP X26,#((SCREEN_WIDTH/PLANE_OFFSET) -7)
    //B.GE fix_plane_h

    

    CMP x21,#50 //cada 50 vueltas del game loop se cambia la direccion
    B.GE change_rect_dir
    
    MOV W1,#PLANE_OFFSET
    MOV W2,WZR
    MOV X8,X27
    BL move_shape

    MOV W1,#PLANE_OFFSET
    MOV W2,WZR
    MOV X8,X28
    BL move_shape


    BL paridad
    MOV W1, #PLANE_OFFSET
    MOV W2, WZR    
    BL render_shape

    //BL draw_example_rect

    ADD X26,X26,#1
    //COUNTER PARA TRACKEAR EL MOVIMIENTO DEL RECT 
    ADD x21,x21,#1
    
    BL add_one

    BL delay 
    BL draw_sky
    B game_loop


add_one:
    LDR X9,[SP,#8]
    ADD X9,X9,#1
    STR X9,[SP,#8]
    RET
reset:
    LDR X9,[SP,#8]
    MOV X9,XZR
    STR X9,[SP,#8]
    RET

paridad:
    LDR x11, [sp, #8]
    AND x11, x11, #1
    CBNZ x11, cargar_p2
    B cargar_p1

    RET


cargar_p1:
    mov X8,x28
    RET

cargar_p2:
    mov X8,x27
    RET



change_rect_dir:

    NEG X25,X25 //MUL x25,x25,x22 // [x25] * (-1)
    MOV x21,#0
    
    B game_loop


draw_example_rect:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP

    //Rect example
    MOV X0,X20
    MOV x1, #50 // x
    MOV x2, #50 // y
    MOV x3, 0 // //color
    MOV x4, #50 // alto
    MOV x5, #50 // ancho

    //(ANIM) LE SUMO EL OFFSET SETEADO EN x25, QUE VA IR HACIENDO -30,30,-30,30.... 
    ADD X1,X1,X25
    
    BL draw_rectangle

    LDP X29,X30,[SP],#16
    RET




fix_plane_h:
    //Este arreglo se hizo porque el avion se bajaba de mas cada aproximadamente [1000] iteraciones
    MOV X26,#1  //RESET PLANE COUNTER
    MOV X8,X27
    BL move_plane_reset
    

    MOV X8,X28
    BL move_plane_reset 

    BL reset
    
    
    B game_loop
    


draw_cars:
    SUB SP,SP,#48
    STR X29,[SP,#0]
    STR X30,[SP,#8]
    STR X1,[SP,#16]
    STR X2,[SP,#24]
    STR X8,[SP,#32]    
    MOV X29,SP
    

    ADR X8, car_8
    MOV X1, 200
    BL scale_shape
    MOV W1, #-89
    MOV W2, #-200
    BL move_shape
    BL render_shape


    ADR X8, car_6
    MOV W1, #175
    MOV W2, #210
    BL move_shape
    BL render_shape

    ADR X8, car_4
    MOV W1, #200
    MOV W2, #40
    BL move_shape
    BL render_shape

    ADR X8, car_9
    MOV X1, #80
    BL scale_shape
    MOV W1, #294
    MOV W2, #160
    BL move_shape
    BL render_shape

    LDR X8,[SP,#32]
    LDR X2,[SP,#24]
    LDR X1,[SP,#16]
    LDR X30,[SP,#8]
    LDR X29,[SP,#0]
    ADD SP,SP,#48
    
    RET


