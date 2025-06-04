.include "constants.inc"
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
    

.globl main
main:
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20

main_init:

    //Procedimiento [draw_static_background] escrito en: [background.s]
	BL draw_static_background


    ADR X8,car_6
    MOV W1,#170
    MOV W2,#230
    BL move_shape   
    BL render_shape


    ADR X8,car_4
    MOV W1,#178
    MOV W2,#60
    BL move_shape
    BL render_shape

    ADR X8,car_9
    MOV X1,#92
    BL scale_shape
    MOV W1,#289
    MOV W2,#210
    BL move_shape
    BL render_shape


    ADR X8,car_5
    MOV W1,#560
    MOV W2,#110
    BL move_shape

    MOV X1,#42
    BL scale_shape
    BL render_shape

    ADR X8,plane_1
    MOV W1,#103
    MOV W2,#60
    BL move_shape
    BL render_shape




inf_loop:

     

	b inf_loop

