
.include "helpers.s"
/*  
    NOMBRE DE ARCHOVO: shapes.s
    DESC: En este archivo se encuentran los procedimientos,usados para el dibujo de figuras geometricas en el FB
 */

/*
    Función: [draw_square]
    Descripción: Dibuja un cuadrado de lado N en pantalla, en el framebuffer. 
    Recorre dos bucles anidados (filas y columnas) y para cada pixel llama a 
    [get_rel_pix_addr] para obtener la dirección correcta y pintar el color.

    Parámetros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1
        POSICION Y      --> X2
        COLOR           --> X3 (LDR X3,=0XFFFFFF ó 0XFFFFFFFF)
        TAMAÑO          --> X4

    Salidas:
        No tiene un valor de retorno explicito a un registro. 
        Este procedimiento dibujara un cuadrado en el FB en la posicion (x,y) dada.

    Registros usados (recap): 
        input: {X0,X1,X2,X3,X4}
        output:{}
        temp: {X13,X14,X10,X7}

    ¿Se guardan/restauran valores en la pila (explícitamente)?: SI, debido a que
    hay loops debemos guardar la direccion de donde se llamo originalmente la funcion
*/
draw_square:
    STP     X29,X30,[SP,#-16]!
    MOV     X29,SP
    MOV     X13,#0 // CONTADOR i = 0

y_draw_square:
    CMP     X13,X4 // COMPARA i con TAMAÑO
    B.GE    end_y_draw_square
    MOV     X14,#0 // CONTADOR j = 0

x_draw_square:
    CMP     X14,X4 // COMPARA j con TAMAÑO  
    B.GE    end_x_draw_square
    
    ADD     x1, x1, #1 // X = X + 1
    BL      get_rel_pix_addr //fn(x1,x2) --> x7 esta el return value

    MOV     w10, w3    //Muevo el color a w10
    STUR    w10, [x7] //Pinto el pixel relativo en (x,y)

    ADD     X14,X14,#1 //j++
    B       x_draw_square

end_x_draw_square:
    SUB     x1, x1, x13 //X = X - j
    ADD     x2, x2, #1  //Y = Y + 1
    ADD     X13,X13,#1  //i++
    B       y_draw_square

end_y_draw_square:
    LDP     X29,X30,[SP],#16
    RET



/*
    Función: [draw_rectangle]
    Descripción: Dibuja un rectangulo de ALTOxANCHO en pantalla, en el framebuffer. 
    Recorre dos bucles anidados (filas y columnas) y para cada pixel llama a 
    [get_rel_pix_addr] para obtener la dirección correcta y pintar el color.

    Parámetros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1
        POSICION Y      --> X2
        COLOR           --> X3 (LDR X3,=0XFFFFFF ó 0XFFFFFFFF)
        ALTO            --> X4
        ANCHO           --> X5

    Salidas:
        No tiene un valor de retorno explicito a un registro. 
        Este procedimiento dibujara un rectangulo en el FB en la posicion (x,y) dada.

    Registros usados (recap): 
        input: {X0,X1,X2,X3,X4,X5}
        output:{}
        temp: {X13,X14,X10,X7}

    ¿Se guardan/restauran valores en la pila (explícitamente)?: SI, debido a que
    hay loops debemos guardar la direccion de donde se llamo originalmente la funcion
*/

.global "draw_rectangle"
draw_rectangle:
    STP x29, x30, [sp, #-16]!
    MOV x29, sp
    MOV     X13,#0 // CONTADOR i = 0

y_draw_rectangle:
    CMP     X13,X4 // COMPARA i con ALTO
    B.GE    end_y_draw_rectangle
    MOV     X14,#0 // CONTADOR j = 0

x_draw_rectangle:
    CMP     X14,X5 // COMPARA j con ANCHO  
    B.GE    end_x_draw_rectangle
    ADD     x1, x1, #1 // X = X + 1
    BL     get_rel_pix_addr //fn(x1,x2) --> x7 esta el return value
    MOV     w10, w3    //Muevo el color a w10
    STUR    w10, [x7] //Pinto el pixel relativo en (x,y)
    ADD     X14,X14,#1 //j++
    B       x_draw_rectangle

end_x_draw_rectangle:
    SUB     x1, x1, x14 //X = X - j
    ADD     x2, x2, #1  //Y = Y + 1
    ADD     X13,X13,#1  //i++
    B       y_draw_rectangle

end_y_draw_rectangle:
   
    LDP x29, x30, [sp], #16
    RET


