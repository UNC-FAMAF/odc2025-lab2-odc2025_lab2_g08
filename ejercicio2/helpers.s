.include "constants.inc"
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

    ¿Se guardan/restauran valores en la pila (explicitamente)? : SI
*/

get_rel_pix_addr:
    SUB     SP,SP,#32       // Reservo 32 bytes en pila
    STR     X29,[SP,#0]
    STR     X30,[SP,#8]
    STR     X1,[SP,#16]     // guardar posicion X
    STR     X2,[SP,#24]     // guardar posicion Y
    MOV     X29,SP
    
    MOV     X10,SCREEN_WIDTH//X10 <-- SCREEN_WIDTH  
    MUL     X9,X2,X10       // X9 <-- (Y * SCREEN_WIDTH) 
    ADD     X9,X9,X1        // X9 <-- (Y * SCREEN_WIDTH) + X
    LSL     X9,X9,#2        // X9 <-- 4 * [(Y * SCREEN_WIDTH) + X] 
    ADD     X7,X0,X9        // X7 <-- FB_BASE_ADDRESS + 4 * [(Y * SCREEN_WIDTH) + X]
    
    LDR     X2,[SP,#24]    // restaurar posicion Y
    LDR     X1,[SP,#16]    // restaurar posicion X
    LDR     X30,[SP,#8]
    LDR     X29,[SP,#0]
    ADD     SP,SP,#32
   
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


/*
    Función: [choose_plane]
    Descripción: Esta función alterna entre dos sprites del avion (contenidos en los registros X27 y X28)
    y copia uno de ellos en el registro X8, alternando en cada llamada.

    Para mantener el estado entre llamadas, se utiliza una variable global en memoria (`plane_toggle`)
    que almacena un valor binario (0 o 1). Este valor se alterna (con una operación XOR) en cada ejecución,
    y se usa para decidir si copiar X27 (plane_1) o X28(plane_2) a X8.

    Parámetros:
        Ninguno (usa estado interno persistente en memoria)

    Salidas:
        X8 ← X27 si plane_toggle == 0
        X8 ← X28 si plane_toggle == 1

    Registros usados (recap): 
        temporales: {W9, W10, W11}

    ¿Se guardan/restauran valores en la pila (explícitamente)?: NO
*/

.section .data
plane_toggle: .word 0 

choose_plane:
    // Cargar el valor actual del toggle
    LDR X9, =plane_toggle 
    LDR W10, [X9]          // W10 = plane_toggle

    // Alternar el valor para la próxima vez
    EOR W11, W10, #1       // W11 = W10 XOR 1 (alterna entre 0 y 1)
    STR W11, [X9]          // Guardar nuevo valor en plane_toggle

    // Usar W10 para decidir si cargar X27 o X28
    CMP W10, #0
    BEQ load_x27

load_x28:
    MOV X8, X28
    RET

load_x27:
    MOV X8, X27
    RET
