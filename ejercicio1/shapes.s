.include "helpers.s"
/*  
    NOMBRE_DE_ARCHIVO: shapes.s
    DESC: En este archivo se encuentran todos los procedimientos que se encargan de dibujar figuras en el framebuffer
 */

/*
    Funcion: [draw_rectangle]
    Descripcion: Dibuja un rectangulo de ALTOxANCHO en pantalla, en el framebuffer.
                 Recorre dos bucles anidados (filas y columnas) y para cada pixel llama a
                 [get_rel_pix_addr] para obtener la direccion correcta y pintar el color.

    Parametros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1
        POSICION Y      --> X2
        COLOR           --> X3 (LDR X3,=0XFFFFFF o 0XFFFFFFFF)
        ALTO            --> X4
        ANCHO           --> X5

    Salidas:
        No tiene un valor de retorno explicito en registros.
        Este procedimiento dibujara un rectangulo en el FB en la posicion (X1,X2) con ancho X5 y alto X4.

    Registros usados (recap):
        input:  {X0,X1,X2,X3,X4,X5}
        output: {}
        temp:   {X13,X14,X10,X7}

    Guardar/Restaurar:
        Se guarda en pila X29,X30, X1,X2,X4,X5 por los loops.
*/
.global "draw_rectangle"
draw_rectangle:
    SUB SP,SP,#48       // Reservo 48 bytes en pila
    STR X29,[SP,#0]
    STR X30,[SP,#8]
    STR X1,[SP,#16]
    STR X2,[SP,#24]
    STR X4,[SP,#32]
    STR X5,[SP,#40]
    MOV X29,SP

    MOV     X13,#0     // Contador i = 0

y_draw_rectangle:
    CMP     X13,X4     // Compara i con ALTO
    B.GE    end_y_draw_rectangle
    MOV     X14,#0     // Contador j = 0

x_draw_rectangle:
    CMP     X14,X5     // Compara j con ANCHO
    B.GE    end_x_draw_rectangle
    ADD     X1,X1,#1  // X = X + 1
    BL      get_rel_pix_addr // fn(X1,X2) --> X7 retorna direccion pixel
    MOV     W10,W3    // Muevo el color a W10
    STUR    W10,[X7]  // Pinto el pixel relativo en (X1,X2)
    ADD     X14,X14,#1 // j++
    B       x_draw_rectangle

end_x_draw_rectangle:
    SUB     X1,X1,X14 // X = X - j
    ADD     X2,X2,#1  // Y = Y + 1
    ADD     X13,X13,#1 // i++
    B       y_draw_rectangle

end_y_draw_rectangle:
    

end_draw_rect:
LDR     X5,[SP,#40]
LDR     X4,[SP,#32]
LDR     X2,[SP,#24]
LDR     X1,[SP,#16]
LDR     X30,[SP,#8]
LDR     X29,[SP,#0]
ADD     SP,SP,#48
RET


/*
    Funcion: [draw_square]
    Descripcion: Dibuja un cuadrado de lado N en pantalla, en el framebuffer.
                 Funciona como wrapper de [draw_rectangle] pasando ancho=alto.

    Parametros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1
        POSICION Y      --> X2
        COLOR           --> X3 (LDR X3,=0XFFFFFF o 0XFFFFFFFF)
        TAMANO          --> X4

    Salidas:
        No tiene un valor de retorno explicito en registros.
        Este procedimiento dibujara un cuadrado en el FB en la posicion (X1,X2) con lado X4.

    Registros usados (recap):
        input:  {X0,X1,X2,X3,X4}
        output: {}
        temp:   {X13,X14,X10,X7}

    Guardar/Restaurar:
        Se guarda en pila X29,X30, X1,X2,X4.
*/
.global "draw_square"
draw_square:
    SUB SP,SP,#32       // Reservo 32 bytes en pila
    STR X29,[SP,#0]
    STR X30,[SP,#8]
    STR X1,[SP,#16]
    STR X2,[SP,#24]
    STR X4,[SP,#32]
    MOV X29,SP

    MOV X5,X4          // ANCHO = TAMANO
    B draw_rectangle   // Llamo a draw_rectangle

    // Restauracion (no se llega aqui, porque B salta)
    LDR X4,[SP,#32]
    LDR X2,[SP,#24]
    LDR X1,[SP,#16]
    LDR X30,[SP,#8]
    LDR X29,[SP,#0]
    ADD SP,SP,#32
    RET


/*
    Funcion: [draw_circle]
    Descripcion: Dibuja un circulo relleno de radio R en pantalla, en el framebuffer,
                 usando el algoritmo de punto medio para determinar los limites de cada
                 fila escaneada y luego dibuja lineas horizontales completas.

    Convenciones de registros:
        X0  : FB_BASE_ADDRESS (direccion base del framebuffer)
        X1  : CX (coordenada X del centro)
        X2  : CY (coordenada Y del centro)
        X3  : COLOR (valor de 32 bits, p.ej. 0x00FFFFFF)
        X4  : RADIUS (radio del circulo)

    Registros temporales (no se guardan/restauran):
        X9  - X12      : Uso general
        X13 - X15      : Variables del algoritmo (y, x_offset, R^2)
        X16 - X18      : Variables auxiliares para calculos
        X21 - X24      : Variables de dibujado de spans

    Registros callee-saved (si se usan, se guardan/restauran):
        X19 : Guardara CX
        X5  : Guardara CY

    Guardar/Restaurar:
        Se guarda en pila X29,X30, X1,X2,X4, X19,X5.
*/
.global draw_circle
draw_circle:
    SUB     SP, SP, #64
    STR     X29,[SP,#0]
    STR     X30,[SP,#8]
    STR     X1, [SP,#16]   // guardar CX
    STR     X2, [SP,#24]   // guardar CY
    STR     X4, [SP,#32]   // guardar RADIUS
    MOV     X29, SP        // nuevo frame pointer

    // Mover CX y CY a registros callee-saved
    MOV     X19, X1        // X19 = CX
    MOV     X5,  X2        // X5  = CY
    STR     X19,[SP,#40]
    STR     X5,[SP,#48]

    // Calcular R^2 en X15
    MUL     X15, X4, X4     // X15 = RADIUS * RADIUS

    // Inicializar y = 0 (X13) y x_offset = RADIUS (X14)
    MOV     X13, #0        // y = 0
    MOV     X14, X4        // x_offset = R

loop_y:
    CMP     X13, X4        // mientras (y <= R)
    B.GT    end_loop_y

    MOV     X16, X14       // X16 = x_offset provisional

adjust_x:
    MUL     X9,  X16, X16  // X9  = x_off^2
    MUL     X10, X13, X13  // X10 = y^2
    ADD     X11, X9, X10   // X11 = x_off^2 + y^2
    CMP     X11, X15
    B.LE    done_adjust    // si <= R^2, acabado

    SUB     X16, X16, #1   // x_off--
    B       adjust_x

done_adjust:
    // X16 tiene x_offset correcto para esta fila

    // Dibujar linea horizontal en (CY + y)
    MOV     X17, X19       // X17 = CX
    SUB     X17, X17, X16  // X17 = CX - x_offset
    MOV     X18, X19       // X18 = CX
    ADD     X18, X18, X16  // X18 = CX + x_offset

    MOV     X21, X5        // X21 = CY
    ADD     X21, X21, X13  // X21 = CY + y

    MOV     X22, X17       // X22 = i inicial

draw_span1:
    CMP     X22, X18
    B.GT    end_span1
    MOV     X1, X22       // X1 = i
    MOV     X2, X21       // X2 = CY + y
    BL      get_rel_pix_addr // --> X7 = direccion pixel
    MOV     W23, W3       // W23 = COLOR
    STUR    W23,[X7]      // escribir pixel
    ADD     X22, X22, #1  // i++
    B       draw_span1

end_span1:
    CMP     X13, #0       // Si y == 0, no dibujar simetrico
    BEQ     skip_span2

    MOV     X17, X19       // X17 = CX
    SUB     X17, X17, X16  // X17 = CX - x_offset
    MOV     X18, X19       // X18 = CX
    ADD     X18, X18, X16  // X18 = CX + x_offset

    MOV     X24, X5        // X24 = CY
    SUB     X24, X24, X13  // X24 = CY - y

    MOV     X22, X17       // X22 = i inicial

draw_span2:
    CMP     X22, X18
    B.GT    end_span2
    MOV     X1, X22       // X1 = i
    MOV     X2, X24       // X2 = CY - y
    BL      get_rel_pix_addr // --> X7 = direccion pixel
    MOV     W23, W3       // W23 = COLOR
    STUR    W23,[X7]      // escribir pixel
    ADD     X22, X22, #1  // i++
    B       draw_span2

end_span2:
skip_span2:
    ADD     X13, X13, #1  // y++
    MOV     X14, X16      // x_offset_new = x_offset_actual
    B       loop_y

end_loop_y:
    LDR     X5,[SP,#48]   // restaurar CY
    LDR     X19,[SP,#40]  // restaurar CX
    LDR     X4,[SP,#32]   // restaurar RADIUS
    LDR     X2,[SP,#24]   // restaurar X2 original
    LDR     X1,[SP,#16]   // restaurar X1 original
    LDR     X30,[SP,#8]
    LDR     X29,[SP,#0]
    ADD     SP,SP,#64
    RET


/*
    Funcion: [draw_route]
    Descripcion: Dibuja una ruta de rectangulos desplazandose y reduciendo tamano
                 en cada iteracion. En cada paso llama a [draw_rectangle] con
                 los valores actuales de posicion, color, alto y ancho.

    Parametros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1  (coordenada X inicial)
        POSICION Y      --> X2  (coordenada Y inicial)
        COLOR           --> X3  (valor de color 32 bits)
        ALTO            --> X4  (alto de rectangulo inicial)
        ANCHO           --> X5  (ancho de rectangulo inicial)

    Salidas:
        No tiene un valor de retorno explicito en registros.
        Dibuja varios rectangulos en forma de ruta hasta que se cumpla la condicion.

    Registros usados (recap):
        input:  {X0,X1,X2,X3,X4,X5}
        output: {}
        temp:   {X13}   // contador de iteraciones

    Guardar/Restaurar:
        Se guarda en pila X29,X30, X1,X2.
        X4 y X5 se modifican en cada iteracion y no se restauran hasta el final.
*/
.global "draw_route"
draw_route:
    SUB     SP,SP,#32       // Reservo 32 bytes en pila
    STR     X29,[SP,#0]
    STR     X30,[SP,#8]
    STR     X1,[SP,#16]     // guardar posicion X
    STR     X2,[SP,#24]     // guardar posicion Y
    MOV     X29,SP

    MOV     X13, XZR        // contador = 0

do_draw_route:
    CMP     X13, X5        // comparar contador con ANCHO inicial
    B.GE    end_draw_route

    SUB     X2, X2, X4     // Y = Y - alto
    SUB     X5, X5, X4     // ANCHO = ANCHO - alto
    ADD     X1, X1, #1     // X = X + 1

    BL      draw_rectangle // llama a draw_rectangle con X0..X5

    ADD     X13, X13, #80  // incrementar contador en 80
    B       do_draw_route

end_draw_route:
    LDR     X2,[SP,#24]    // restaurar posicion Y
    LDR     X1,[SP,#16]    // restaurar posicion X
    LDR     X30,[SP,#8]
    LDR     X29,[SP,#0]
    ADD     SP,SP,#32
    RET


/*
    Funcion: [draw_lft_shoulder]
    Descripcion: Dibuja la banquina izquierda con rectangulos succesivos
                 desplazados y reduciendo tamano. Similar a draw_route pero con valores fijos
                 de desplazamiento en Y y reduccion de ancho por iteracion.

    Parametros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1  (coordenada X inicial)
        POSICION Y      --> X2  (coordenada Y inicial)
        COLOR           --> X3  (valor de color 32 bits)
        ALTO            --> X4  (alto de rectangulo)
        ANCHO           --> X5  (ancho de rectangulo inicial)

    Salidas:
        No tiene un valor de retorno explicito en registros.
        Dibuja varios rectangulos en forma de banquina izquierda hasta que
        contador >= ANCHO inicial.

    Registros usados (recap):
        input:  {X0,X1,X2,X3,X4,X5}
        output: {}
        temp:   {X13}   // contador de iteraciones

    Guardar/Restaurar:
        Se guarda en pila X29,X30, X1,X2.
*/
.global "draw_lft_shoulder"
draw_lft_shoulder:
    SUB     SP,SP,#32       // Reservo 32 bytes en pila
    STR     X29,[SP,#0]
    STR     X30,[SP,#8]
    STR     X1,[SP,#16]     // guardar posicion X
    STR     X2,[SP,#24]     // guardar posicion Y
    MOV     X29,SP

    MOV     X13, XZR        // contador = 0

do_lft_shoulder:
    CMP     X13, X5        // comparar contador con ANCHO inicial
    B.GE    end_lft_shoulder

    SUB     X2, X2, #7     // Y = Y - 7
    SUB     X5, X5, #4     // ANCHO = ANCHO - 4
    ADD     X1, X1, #4     // X = X + 4

    BL      draw_rectangle // llama a draw_rectangle con X0..X5

    ADD     X13, X13, #155 // incrementar contador en 155
    B       do_lft_shoulder

end_lft_shoulder:
    LDR     X2,[SP,#24]    // restaurar posicion Y
    LDR     X1,[SP,#16]    // restaurar posicion X
    LDR     X30,[SP,#8]
    LDR     X29,[SP,#0]
    ADD     SP,SP,#32
    
    RET


/*
    Funcion: [draw_rgt_shoulder]
    Descripcion: Dibuja la banquina derecha con rectangulos sucesivos
                 desplazados y reduciendo tamano. Similar a draw_route pero con valores fijos
                 de desplazamiento en Y y reduccion de ancho por iteracion.

    Parametros:
        FB_BASE_ADDRESS --> X0
        POSICION X      --> X1  (coordenada X inicial)
        POSICION Y      --> X2  (coordenada Y inicial)
        COLOR           --> X3  (valor de color 32 bits)
        ALTO            --> X4  (alto de rectangulo)
        ANCHO           --> X5  (ancho de rectangulo inicial)

    Salidas:
        No tiene un valor de retorno explicito en registros.
        Dibuja varios rectangulos en forma de banquina derecha hasta que
        contador >= ANCHO inicial.

    Registros usados (recap):
        input:  {X0,X1,X2,X3,X4,X5}
        output: {}
        temp:   {X13}   // contador de iteraciones

    Guardar/Restaurar:
        Se guarda en pila X29,X30, X1,X2.
*/
.global "draw_rgt_shoulder"
draw_rgt_shoulder:
    SUB     SP,SP,#32       // Reservo 32 bytes en pila
    STR     X29,[SP,#0]
    STR     X30,[SP,#8]
    STR     X1,[SP,#16]     // guardar posicion X
    STR     X2,[SP,#24]     // guardar posicion Y
    MOV     X29,SP

    MOV     X13, XZR        // contador = 0

do_rgt_shoulder:
    CMP     X13, X5        // comparar contador con ANCHO inicial
    B.GE    end_rgt_shoulder

    SUB     X2, X2, #7     // Y = Y - 7
    SUB     X5, X5, #5     // ANCHO = ANCHO - 5
    ADD     X1, X1, #1     // X = X + 1

    BL      draw_rectangle // llama a draw_rectangle con X0..X5

    ADD     X13, X13, #108 // incrementar contador en 108
    B       do_rgt_shoulder

end_rgt_shoulder:
    LDR     X2,[SP,#24]    // restaurar posicion Y
    LDR     X1,[SP,#16]    // restaurar posicion X
    LDR     X30,[SP,#8]
    LDR     X29,[SP,#0]
    ADD     SP,SP,#32
    RET


/*
    Funcion: [draw_triangle]
    Descripcion: Dibuja un triángulo compuesto por rectángulos sucesivos.
                 En cada iteración, desplaza la coordenada X a la derecha,
                 desplaza la coordenada Y hacia arriba en función de ALTURA_RECT,
                 y reduce el ancho en 2. Se repite hasta que el contador
                 alcance el ancho calculado de la base del triángulo.

    Parametros:
        FB_BASE_ADDRESS --> X0   (dirección base del framebuffer)
        POSICION X      --> X1   (coordenada X inicial del triángulo)
        POSICION Y      --> X2   (coordenada Y inicial del triángulo)
        COLOR           --> X3   (valor de color de 32 bits)
        ANCHO_INICIAL   --> X4   (ancho inicial de la base del triángulo)
        /* X5 se guarda/restaura pero no se utiliza en la lógica de dibujo 
        ALTURA_RECT     --> X12  (altura de cada rectángulo y desplazamiento en Y)

    Salidas:
        No tiene valor de retorno explícito. Se encarga de invocar
        draw_rectangle repetidamente para formar el triángulo.

    Registros usados (recap):
        input:  {X0, X1, X2, X3, X4, X12}
        temp:   {X5, X13}

    Guardar/Restaurar:
        Se guardan en pila: X29, X30, X1, X2, X4, X5
*/
.global "draw_triangle"
draw_triangle:
    STP     X29, X30, [SP, #-64]!    // Reservo 64 bytes y guardo frame pointer y link register
    MOV     X29, SP
    STP     X1, X2, [SP, #16]        // Guardar POSICION X (X1) y POSICION Y (X2)
    STP     X4, X5, [SP, #48]        // Guardar ANCHO_INICIAL (X4) y X5 (no usado)

    MOV     X5, X4                   // X5 = ANCHO_INICIAL
    MOV     X4, X12                  // X4 = ALTURA_RECT (altura de cada rectángulo)
    MOV     X13, #0                  // contador = 0
    ADD     X5, X5, X4               // base_width = ANCHO_INICIAL + ALTURA_RECT

for_triangle:
    CMP     X13, X5                  // Si contador >= base_width, fin
    B.GE    end_for_triangle

    BL      draw_rectangle           // Dibuja rectángulo con X0..X5

    ADD     X1, X1, #1               // X = X + 1 (desplaza X a la derecha)
    SUB     X2, X2, X12              // Y = Y - ALTURA_RECT (sube en Y)
    SUB     X5, X5, #2               // reduce el ancho en 2 para el siguiente rectángulo

    ADD     X13, X13, #1             // contador = contador + 1
    B       for_triangle

end_for_triangle:
    LDP     X4, X5, [SP, #48]        // Restaurar ANCHO_INICIAL (X4) y X5 original
    LDP     X1, X2, [SP, #16]        // Restaurar POSICION X (X1) y POSICION Y (X2)
    LDP     X29, X30, [SP], #64      // Restaurar X29, X30 y liberar pila
    RET







/* 
   Funcion: [draw_line]
   Descripción: Dibuja una línea entre (x0,y0) y (x1,y1)
                usando el algoritmo de Bresenham.
   Parámetros (por convención):
       X0 --> dirección base del framebuffer
       X1 --> x0 (coordenada X del punto inicial)
       X2 --> y0 (coordenada Y del punto inicial)
       X3 --> x1 (coordenada X del punto final)
       X4 --> y1 (coordenada Y del punto final)
       X5 --> color (valor de 32 bits)
       X6, X7 --> no usados
   Registros temporales:
       X9  --> screen_width (ancho de pantalla)
       X11 --> sx (paso en X, +1 o -1)
       X12 --> sy (paso en Y, +1 o -1)
       X13 --> dx = |x1 - x0|
       X14 --> dy = |y1 - y0|
       X15 --> error = dx - dy
       X16 --> e2 (error * 2), temporal intra-procedure
   Sobre X20 se guarda el puntero a framebuffer para escribir píxeles.
   No se utilizan registros callee-saved (x19-x28).
-------------------------------------------------------- 
*/

.global draw_line
draw_line:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
    // Guardar el framebuffer en X20 para manipular píxeles
    MOV     X20, X0

    // Cargar screen width en X9 (constante o etiqueta predefinida)
    MOV     X9, #SCREEN_WIDTH

    // Calcular dx = |x1 - x0|
    SUB     X13, X3, X1        // X13 = x1 - x0
    CMP     X13, #0
    B.GE    dx_positive
    NEG     X13, X13           // X13 = |x1 - x0|
dx_positive:
    // Calcular dy = |y1 - y0|
    SUB     X14, X4, X2        // X14 = y1 - y0
    CMP     X14, #0
    B.GE    dy_positive
    NEG     X14, X14           // X14 = |y1 - y0|
dy_positive:
    // Calcular error = dx - dy
    SUB     X15, X13, X14      // X15 = dx - dy

    // Determinar sx = (x0 < x1) ? +1 : -1
    CMP     X1, X3
    BLE     set_sx_pos
    MOV     X11, #-1           // sx = -1
    B       set_sy
set_sx_pos:
    MOV     X11, #1            // sx = +1

    // Determinar sy = (y0 < y1) ? +1 : -1
set_sy:
    CMP     X2, X4
    BLE     set_sy_pos
    MOV     X12, #-1           // sy = -1
    B       line_loop_start
set_sy_pos:
    MOV     X12, #1            // sy = +1

line_loop_start:
    // Calcular la dirección del píxel actual: addr = FB_BASE + ((y0 * screen_width + x0) * 4)
    // 1) t1 = y0 * screen_width
    MUL     X16, X2, X9        // X16 = y0 * SCREEN_WIDTH
    // 2) t2 = t1 + x0
    ADD     X16, X16, X1       // X16 = (y0 * SCREEN_WIDTH) + x0
    // 3) t3 = t2 << 2  (multiplicar por 4 bytes por píxel)
    LSL     X16, X16, #2       // X16 = ((y0*SW + x0) * 4)
    // 4) addr = FB_BASE + t3
    ADD     X16, X20, X16      // X16 = dirección final del píxel

    // Almacenar el color en [addr]
    STUR    W5, [X16]          // *(uint32_t*)addr = color (W5)

    // Si llegamos al punto final, salir
    CMP     X1, X3
    B.NE    not_done
    CMP     X2, X4
    B.NE    not_done

    LDP X29,X30,[SP],#16
    RET

not_done:
    // e2 = error * 2
    LSL     X16, X15, #1       // X16 = 2 * error

    // Si e2 > -dy, avanzar en X: error -= dy, x0 += sx
    NEG     X17, X14           // X17 = -dy
    CMP     X16, X17
    B.LT    skip_step_x
    SUB     X15, X15, X14      // error = error - dy
    ADD     X1, X1, X11        // x0 = x0 + sx
skip_step_x:
    // Si e2 < dx, avanzar en Y: error += dx, y0 += sy
    CMP     X16, X13
    B.GE    skip_step_y
    ADD     X15, X15, X13      // error = error + dx
    ADD     X2, X2, X12        // y0 = y0 + sy
skip_step_y:
    B       line_loop_start


.global "draw_route_lines"
draw_route_lines:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
    MOV X0,X20
    MOV X1,#317
    MOV X2,#170
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 + 39
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 + 39 +39
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 + 39 +39 + 39
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 + 39 +39 + 39 +39
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 + 39 +39 + 39 +39+39
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    MOV X0,X20
    MOV X1,#317
    MOV X2,#170 +39 + 39 +39 + 39 +39+39+ 39
    LDR x3, =0xFFFFFF //color
    MOV x4, #24 // alto
    MOV x5, #5 // ancho
    BL draw_rectangle

    LDP X29,X30,[SP],#16
    RET


.global "draw_mountain"
draw_mountain:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
    //MONTAÑA 3
    MOV X0,X20
    MOV x1, #20
    MOV x2, #167
    LDR x3, =0xE67E22
    MOV x4, #120
    MOV x12, #1
    BL draw_triangle
    //MONTAÑA 1
    MOV X0,X20
    MOV x1, #0
    MOV x2, #167
    LDR x3, =0xF39C12
    MOV x4, #80
    MOV x12, #1
    BL draw_triangle
    //MONTAÑA 2
    MOV X0,X20
    MOV x1, #70
    MOV x2, #167
    LDR x3, =0xF39C12
    MOV x4, #90
    MOV x12, #1
    BL draw_triangle

    //MONTAÑA 4
    MOV X0,X20
    MOV x1, #20+420
    MOV x2, #167
    LDR x3, =0xE67E22
    MOV x4, #180
    MOV x12, #1
    BL draw_triangle
    //MONTAÑA 5
    MOV X0,X20
    MOV x1, #0+420
    MOV x2, #167
    LDR x3, =0xF39C12
    MOV x4, #80
    MOV x12, #1
    BL draw_triangle
    //MONTAÑA 6
    MOV X0,X20
    MOV x1, #70+470
    MOV x2, #167
    LDR x3, =0xF39C12
    MOV x4, #90
    MOV x12, #1
    BL draw_triangle
    LDP X29,X30,[SP],#16
    RET


.global "draw_clouds"
draw_clouds:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
	//NUBE 1
	
	MOV x0, x20
	MOV x1, 80 //centro x
	MOV x2, 40 //centro y
	LDR X3,=0XFFFFFFFF
    MOV x4, 20 //radio
	BL draw_circle
	
	MOV x0, x20
	MOV x1, 100 //centro x
	MOV x2, 35 //centro y
	LDR X3,=0XFFFFFFFF
    MOV x4, 25 //radio
	BL draw_circle
	
	MOV x0, x20
	MOV x1, 120 //centro x
	MOV x2, 40 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 20 //radio
	BL draw_circle

	
	//NUBE 2
	MOV x0, x20
	MOV x1, 200 //centro x
	MOV x2, 50 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 20 //radio
	BL draw_circle
	
	MOV x0, x20
	MOV x1, 220 //centro x
	MOV x2, 45 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 25 //radio
	BL draw_circle
	
	MOV x0, x20
	MOV x1, 240 //centro x
	MOV x2, 50 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 20 //radio

	BL draw_circle

    //NUBE 3
	MOV x0, x20
	MOV x1, 200 + 360 //centro x
	MOV x2, 50 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 20 //radio
	BL draw_circle
	
	MOV x0, x20
	MOV x1, 220 + 360//centro x
	MOV x2, 45 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 25 //radio
	BL draw_circle
	
	MOV x0, x20
	MOV x1, 240 + 360//centro x
	MOV x2, 50 //centro y
	LDR X3,=0XFFFFFFFF
	MOV x4, 20 //radio

	BL draw_circle

    LDP X29,X30,[SP],#16
    RET

.global "draw_signals"
draw_signals:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
    //CARTELES
    //POSTE CARTEL 1 

    MOV     x0, x20
    MOV     x4, 14       // alto: 20 * 0.7 = 14
    MOV     x5, 4        // ancho: 6 * 0.7 = 4
    MOV     x2, 270      // y: 260 + 10 = 270
    MOV     x1, 480      // x: 450 + 30 = 480
    MOVZ    x3, 0x5533, lsl 0
    MOVK    x3, 0x9966, lsl 16  // marrón tronco
    BL      draw_rectangle

    //POSTE CARTEL 2 

    MOV     x0, x20
    MOV     x4, 14       // alto: 20 * 0.7 = 14
    MOV     x5, 4        // ancho: 6 * 0.7 = 4
    MOV     x2, 270      // y: 260 + 10 = 270
    MOV     x1, 522      // x: 492 + 30 = 522
    MOVZ    x3, 0x5533, lsl 0
    MOVK    x3, 0x9966, lsl 16  // marrón tronco
    BL      draw_rectangle

    // BORDE CARTEL

    MOV     x0, x20
    MOV     x4, 60       // alto: 85 * 0.7 = 60
    MOV     x5, 102      // ancho: 145 * 0.7 = 102
    MOV     x2, 211      // y: 201 + 10 = 211
    MOV     x1, 452      // x: 422 + 30 = 452
    MOVZ    x3, 0xFFFF, lsl 0
    MOVK    x3, 0xFFFF, lsl 16
    BL      draw_rectangle

    // CARTEL

    MOV     x0, x20
    MOV     x4, 49       // alto: 70 * 0.7 = 49
    MOV     x5, 91       // ancho: 130 * 0.7 = 91
    MOV     x2, 215      // y: 205 + 10 = 215
    MOV     x1, 457      // x: 427 + 30 = 457
    MOVZ    x3, 0x0000, lsl 16
    MOVK    x3, 0x9900, lsl 0
    BL      draw_rectangle

    // Comienzo OdC

    // O (OdC)
    MOV     x0, x20
    MOV     x1, 480      // centro x: 450 + 30 = 480
    MOV     x2, 232      // centro y: 222 + 10 = 232
    MOV     x4, 11       // radio: 15 * 0.7 = 11
    MOVZ    x3, 0x00FF, lsl 16
    MOVK    x3, 0xFFFF, lsl 0  // blanco
    BL      draw_circle

    MOV     x0, x20
    MOV     x1, 480      // centro x: 450 + 30 = 480
    MOV     x2, 232      // centro y: 222 + 10 = 232
    MOV     x4, 7        // radio: 10 * 0.7 = 7
    MOVZ    x3, 0x0000, lsl 16
    MOVK    x3, 0x9900, lsl 0  // color interior
    BL      draw_circle
    // fin de O

    // d (OdC)
    MOV     x0, x20
    MOV     x1, 503      // centro x: 473 + 30 = 503
    MOV     x2, 235      // centro y: 225 + 10 = 235
    MOV     x4, 7        // radio: 10 * 0.7 = 7
    MOVZ    x3, 0x00FF, lsl 16
    MOVK    x3, 0xFFFF, lsl 0  // blanco
    BL      draw_circle

    MOV     x0, x20
    MOV     x1, 503      // centro x: 473 + 30 = 503
    MOV     x2, 235      // centro y: 225 + 10 = 235
    MOV     x4, 4        // radio: 5 * 0.7 = 4
    MOVZ    x3, 0x0000, lsl 16
    MOVK    x3, 0x9900, lsl 0  // color interior
    BL      draw_circle

    MOV     x0, x20
    MOV     x4, 21       // alto: 30 * 0.7 = 21
    MOV     x5, 4        // ancho: 5 * 0.7 = 4
    MOV     x2, 221      // y: 211 + 10 = 221
    MOV     x1, 509      // x: 479 + 30 = 509
    MOVZ    x3, 0x00FF, lsl 16
    MOVK    x3, 0xFFFF, lsl 0  // blanco
    BL      draw_rectangle
    // fin de d

    // C (OdC)
    MOV     x0, x20
    MOV     x1, 529      // centro x: 499 + 30 = 529
    MOV     x2, 232      // centro y: 222 + 10 = 232
    MOV     x4, 11       // radio: 15 * 0.7 = 11
    MOVZ    x3, 0x00FF, lsl 16
    MOVK    x3, 0xFFFF, lsl 0  // blanco
    BL      draw_circle

    MOV     x0, x20
    MOV     x1, 529      // centro x: 499 + 30 = 529
    MOV     x2, 232      // centro y: 222 + 10 = 232
    MOV     x4, 7        // radio: 10 * 0.7 = 7
    MOVZ    x3, 0x0000, lsl 16
    MOVK    x3, 0x9900, lsl 0  // color interior
    BL      draw_circle

    MOV     x0, x20
    MOV     x4, 21       // alto: 30 * 0.7 = 21
    MOV     x5, 7        // ancho: 10 * 0.7 = 7
    MOV     x2, 221      // y: 211 + 10 = 221
    MOV     x1, 535      // x: 505 + 30 = 535
    MOVZ    x3, 0x0000, lsl 16
    MOVK    x3, 0x9900, lsl 0  // color interior
    BL      draw_rectangle
    // fin de C

    // Fin de OdC

    // Comienzo 2025

    // 2
    MOV     x0, x20
    MOV     x1, 465      // x: 435 + 30 = 465
    MOV     x2, 253      // y: 243 + 10 = 253
    MOV     x3, 466      // x: 436 + 30 = 466
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 466      // x: 436 + 30 = 466
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 471      // x: 441 + 30 = 471
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 471      // x: 441 + 30 = 471
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 473      // x: 443 + 30 = 473
    MOV     x4, 253      // y: 243 + 10 = 253
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 473      // x: 443 + 30 = 473
    MOV     x2, 253      // y: 243 + 10 = 253
    MOV     x3, 465      // x: 435 + 30 = 465
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 465      // x: 435 + 30 = 465
    MOV     x2, 260      // y: 250 + 10 = 260
    MOV     x3, 473      // x: 443 + 30 = 473
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line
    // fin 2

    // 0
    MOV     x0, x20
    MOV     x1, 477      // x: 447 + 30 = 477
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 477      // x: 447 + 30 = 477
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 477      // x: 447 + 30 = 477
    MOV     x2, 260      // y: 250 + 10 = 260
    MOV     x3, 484      // x: 454 + 30 = 484
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 484      // x: 454 + 30 = 484
    MOV     x2, 260      // y: 250 + 10 = 260
    MOV     x3, 484      // x: 454 + 30 = 484
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 484      // x: 454 + 30 = 484
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 477      // x: 447 + 30 = 477
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line
    // fin 0

    // 2
    MOV     x0, x20
    MOV     x1, 487      // x: 457 + 30 = 487
    MOV     x2, 253      // y: 243 + 10 = 253
    MOV     x3, 488      // x: 458 + 30 = 488
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 488      // x: 458 + 30 = 488
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 493      // x: 463 + 30 = 493
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 493      // x: 463 + 30 = 493
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 495      // x: 465 + 30 = 495
    MOV     x4, 253      // y: 243 + 10 = 253
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 495      // x: 465 + 30 = 495
    MOV     x2, 253      // y: 243 + 10 = 253
    MOV     x3, 487      // x: 457 + 30 = 487
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 487      // x: 457 + 30 = 487
    MOV     x2, 260      // y: 250 + 10 = 260
    MOV     x3, 495      // x: 465 + 30 = 495
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line
    // fin 2

    // 5
    MOV     x0, x20
    MOV     x1, 500      // x: 470 + 30 = 500
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 507      // x: 477 + 30 = 507
    MOV     x4, 249      // y: 239 + 10 = 249
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 500      // x: 470 + 30 = 500
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 500      // x: 470 + 30 = 500
    MOV     x4, 254      // y: 244 + 10 = 254
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 500      // x: 470 + 30 = 500
    MOV     x2, 254      // y: 244 + 10 = 254
    MOV     x3, 507      // x: 477 + 30 = 507
    MOV     x4, 254      // y: 244 + 10 = 254
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 507      // x: 477 + 30 = 507
    MOV     x2, 254      // y: 244 + 10 = 254
    MOV     x3, 507      // x: 477 + 30 = 507
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 507      // x: 477 + 30 = 507
    MOV     x2, 260      // y: 250 + 10 = 260
    MOV     x3, 500      // x: 470 + 30 = 500
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line
    // fin 5

    // Inicio km
    // k
    MOV     x0, x20
    MOV     x1, 514      // x: 484 + 30 = 514
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 514      // x: 484 + 30 = 514
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 514      // x: 484 + 30 = 514
    MOV     x2, 255      // y: 245 + 10 = 255
    MOV     x3, 521      // x: 491 + 30 = 521
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 514      // x: 484 + 30 = 514
    MOV     x2, 255      // y: 245 + 10 = 255
    MOV     x3, 521      // x: 491 + 30 = 521
    MOV     x4, 250      // y: 240 + 10 = 250
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line
    // fin k

    // m
    MOV     x0, x20
    MOV     x1, 524      // x: 494 + 30 = 524
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 524      // x: 494 + 30 = 524
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 524      // x: 494 + 30 = 524
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 528      // x: 498 + 30 = 528
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 531      // x: 501 + 30 = 531
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 528      // x: 498 + 30 = 528
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line

    MOV     x0, x20
    MOV     x1, 531      // x: 501 + 30 = 531
    MOV     x2, 249      // y: 239 + 10 = 249
    MOV     x3, 531      // x: 501 + 30 = 531
    MOV     x4, 260      // y: 250 + 10 = 260
    MOVZ    x5, 0x00FF, lsl 16
    MOVK    x5, 0xFFFF, lsl 0  // blanco
    BL      draw_line
    // fin m
    // Fin km

    // Inicio flecha

    MOV     x0, x20
    MOV     x4, 8        // alto: 12 * 0.7 = 8
    MOV     x5, 3        // ancho: 5 * 0.7 = 4
    MOV     x2, 253      // y: 243 + 10 = 253
    MOV     x1, 539      // x: 508 + 30 = 538
    MOVZ    x3, 0x00FF, lsl 16
    MOVK    x3, 0xFFFF, lsl 0  // blanco
    BL      draw_rectangle

    //MONTAÑA 4
    MOV X0,X20
    MOV x1, #535
    MOV x2, #253
    LDR x3, =0xFFFFFFFF
    MOV x4, #10
    MOV x12, #1
    BL draw_triangle

    LDP X29,X30,[SP],#16
    RET
    // Fin flecha
