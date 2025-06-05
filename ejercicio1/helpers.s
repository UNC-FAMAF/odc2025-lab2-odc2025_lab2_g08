.include "constants.s"
/*  
    NOMBRE DE ARCHOVO: helpers.s
    DESC: En este archivo se encuentran las funciones,procedimientos usadas ampliamente en el lab.

 */

/*
    Función: [get_rel_pix_addr]
    Descripción: Como indica su nombre, esta función calcula la dirección relativa en el framebuffer de un píxel 
    basada en las coordenadas (X, Y), siguiendo esta fórmula:

                addr = base_addr + 4 * [X + (Y * SCREEN_WIDTH)]  
    Parámetros: 
                  FB_BASE_ADDRESS --> X0
                       POSICIÓN X --> X1
                       POSICIÓN Y --> X2 
    Salidas:
        Dirección relativa del píxel --> X7
    
    Registros usados (recap): 
       
        input:{X0,X1,X2} 
        out:{x7}
        temp:{x9,x10}

    ¿Se guardan/restauran valores en la pila (explicitamente)? : NO
*/

get_rel_pix_addr:
    MOV     X29,SP
    MOV     X10,SCREEN_WIDTH//X10 <-- SCREEN_WIDTH  
    MUL     X9,X2,X10       // X9 <-- (Y * SCREEN_WIDTH) 
    ADD     X9,X9,X1        // X9 <-- (Y * SCREEN_WIDTH) + X
    LSL     X9,X9,#2        // X9 <-- 4 * [(Y * SCREEN_WIDTH) + X] 
    ADD     X7,X0,X9        // X7 <-- FB_BASE_ADDRESS + 4 * [(Y * SCREEN_WIDTH) + X]
    RET


/*
    Función: [delay]
    Descripción: Esta función implementa una espera artificial (delay_loop) mediante un bucle que decrementa 
    un contador. La duración del retardo está determinada por la combinación de dos constantes (`DELAY_VALUE_1` y `DELAY_VALUE_2`)
    que conforman el valor inicial del contador mediante instrucciones `MOV` y `MOVK`.

    Es útil para crear pausas visibles o sincronizar acciones en sistemas sin temporizadores.

    Parámetros:
        Ninguno (usa constantes internas fijas)

    Salidas:
        Ninguna

    Registros usados (recap): 
        temp: {X0}

    ¿Se guardan/restauran valores en la pila (explícitamente)?: NO
*/

delay:
    
    MOV X0, DELAY_VALUE_2
    MOVK X0, DELAY_VALUE_1, LSL #16  

delay_loop:
    SUB X0, X0, #1 
    CBNZ X0, delay_loop
   
    RET


// ------------------------------------------------------------------
// copy_back_to_fore: copia BACKGROUND_FB bytes de x21 (back) a x20 (front)
// Entradas: x1 = x21 (back), x2 = x20 (front)
// ------------------------------------------------------------------

copy_back_to_fore:
    STP     x29, x30, [sp, #-16]!
    MOV     x29, sp

    MOV     x1, x21
    MOV     x2, x20
    LDR X15,=BACKGROUND_FB
    MOV     x3, X15,LSR 4

copy_loop:
    CBZ     x3, copy_done
    LDP     x4, x5, [x1], #16
    STP     x4, x5, [x2], #16
    SUB     x3, x3, #1
    B       copy_loop

copy_done:
    LDP     x29, x30, [sp], #16
    RET

