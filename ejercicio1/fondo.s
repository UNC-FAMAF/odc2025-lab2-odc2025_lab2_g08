.global draw_background
draw_background:

    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp

    //pasto
    mov x0, x20     // reinicia framebuffer
    mov x1, 480     // alto del rectangullo
    mov x2, 640     // ancho del rectangulo
    mov x9, 0 // posicion y del rectangulo
    mov x3, 0 // posicion x del rectangulo

    movz x6, 0x8B22, lsl00     //Bits 0-15
    movk x6, 0xFF22, lsl16     // del 16-31

    bl draw_rectangle

    //cielo
    mov x0, x20     // reinicia framebuffer
    mov x1, 200     // alto del rectangullo
    mov x2, 640     // ancho del rectangulo
    mov x9, 0 // posicion y del rectangulo
    mov x3, 0 // posicion x del rectangulo

    movz x6, 0xCEEB, lsl00 // color
    movk x6, 0xFF87, lsl16

    bl draw_rectangle

    ////banquina
    mov x0, x20
    mov x8, 620       // tamaño
    mov x16, 2        // alto = 1 //pixel_size NO CAMBIAR
    mov x17, 1        // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
    mov x4, 200       // Y inicial
    mov x18, 10 // X inicial
    movz x6, 0xD700, lsl00 // color
    movk x6, 0x40FF, lsl16
    mov x15, #90 //MOdificando este valor me permite "cortar" la cuspide del triangulo
    bl draw_route

    ////ruta
    mov x0, x20
    mov x8, 580       // tamaño
    mov x16, 2        // alto = 1 //pixel_size NO CAMBIAR
    mov x17, 1        // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
    mov x4, 200       // Y inicial
    mov x18, 30 // X inicial
    movz x6, 0x3838, lsl00 // color
    movk x6, 0x3838, lsl16
    mov x15, #72
    bl draw_route

    //LIneas de la ruta
    mov x15, #1
    mov x0, x20 // reinicia framebuffer
    mov x1, 15 // alto del rectangullo
    mov x2, 4 // ancho del rectangulo
    mov x9, 196 // posicion y del rectangulo

    bl draw_route_lines

    //sol
    mov x0, x20
    mov x1, 480    // centro a(x)
    mov x2, 20     // centro b(y)
    mov x3, 70     // radio
    movz x6, 0xF5, lsl16 // color
    movk x6, 0xBF42, lsl00
    bl draw_circle

    //Triangulo equilatero
    mov x0, x20
    mov x8, 100       // tamaño
    mov x16, 1        // alto = 1 //pixel_size NO CAMBIAR
    mov x17, 1        // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
    mov x4, 100       // Y inicial
    mov x18, 60       // X inicial
    movz x6, 0xB48C, lsl0 // color
    movk x6, 0xFFD2, lsl16
    bl draw_triangle

    //Triangulo equilatero
    mov x0, x20
    mov x8, 80        // tamaño
    mov x16, 1        // alto = 1 //pixel_size NO CAMBIAR
    mov x17, 1        // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
    mov x4, 120       // Y inicial
    mov x18, 130      // X inicial
    movz x6, 0x8C66, lsl0 // color
    movk x6, 0xFFB9, lsl16
    bl draw_triangle

    //Triangulo equilatero
    mov x0, x20
    mov x8, 100       // tamaño
    mov x16, 1        // alto = 1 //pixel_size NO CAMBIAR
    mov x17, 1        // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
    mov x4, 100       // Y inicial
    mov x18, 8        // X inicial
    movz x6, 0x8C66, lsl0 // color
    movk x6, 0xFFB9, lsl16
    bl draw_triangle

    ldp x29, x30, [sp], #16 // restaura fp/lr

    ret

.global draw_route_lines
draw_route_lines:
    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp
    mov x15, #0
loop_linea:
    cmp x15, #7
    b.ge end_loop_line
    add x15, x15, #1
    mov x7, x15
    mul x7, x7, x2
    add x9, x9, x7
    mov x3, 318 // posicion x del rectangulo
    movz x6, 0xFF, lsl16 // color
    movk x6, 0xFFFF, lsl00
    add x1, x1, x15
    bl draw_rectangle
    b loop_linea

end_loop_line:
    ldp x29, x30, [sp], #16 // restaura fp/lr
    ret

.global draw_route
draw_route:
    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp
    //mov  x15, #90               // contador de filas

    mov x0, x20                // reset fb
    mov x1, x16                // altura = 1
    mov x2, x17                // ancho inicial = 1 (se va haciendo mas grande)
    mov x9, x4                 // Y inicial
    mov x3, x18 // X inicial
    //x15 se encarga de cortar el fondo del triangulo
for_loop_3:
    cmp x15, x8
    b.ge end_loop_3
    add x15, x15, #7

    mov x2, x15
    mov x28, x8
    sub x28, x28, x15
    lsr x28, x28, 1

    mov x3, x28
    add x3, x3, x18

    bl draw_rectangle
    bl draw_rectangle
    b for_loop_3
end_loop_3:
    ldp x29, x30, [sp], #16 // restaura fp/lr
    ret
