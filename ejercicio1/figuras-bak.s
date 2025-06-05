.equ SCREEN_WIDTH, 640
.equ SCREEN_HEIGH, 480

//Entradas:
//x3 = pos y
//x4 = pos x
//x5 = tamaño del cuadrado
//x10 = color
.global draw_square
draw_square:
    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp
    
	MOV X12,#0
	for_y:
		CMP X12,X5
		BGE end_for_y
		ADD X12,X12,#1
		MOV X11,#0
		for_x:
			CMP X11,X5
			BGE end_for_x
			ADD X11,X11,#1
			ADD X4,X4,#1
			BL calc_address
			STUR W10,[x7]  // Colorear el pixel N
			B for_x
		end_for_x:
		SUB X4,X4,X11 // ESTO ES COMO HACER:  MOV X4, (X INICIAL)
		ADD X3,X3,1
		B for_y
	end_for_y:
    
    ldp x29, x30, [sp], #16 // restaurar FP/LR y subir SP
	RET

.global calc_address
calc_address:
    // Entrada:
    //   X0 = base del framebuffer
    //   X1 = SCREEN_WIDTH
    //   X3 = pos Y
    //   X4 = pos X
    // Salida:
    //   X7 = dirección final = base + 4 * ( X4 + X3 * SCREEN_WIDTH )
    MUL     x6, x3, x1        // X6 = Y * SCREEN_WIDTH
    ADD     x6, x6, x4        // X6 = Y*W + X
    LSL     x6, x6, #2        // X6 = (Y*W + X) * 4 
    ADD     x7, x0, x6        // X7 = fb_base + offset
    RET




// Subrutina: dibujar rectangulo
draw_rectangle:
    stp x29, x30, [sp, #-16]!     // decrementar SP en 16 y guardar FP/LR
    mov x29, sp                   // establecer nuevo frame pointer
    mov x4, x1 // altura
    mov x7, SCREEN_WIDTH

loopy:
    mov x10, x3
    mov x5, x2
loopx:
    mul x11, x9, x7
    add x11, x11, x10
    lsl x11, x11, 2
    add x11, x0, x11
    stur w6, [x11]

    add x10, x10, 1
    sub x5, x5, 1
    cbnz x5, loopx

    add x9, x9, 1
    sub x4, x4, 1
    cbnz x4, loopy

    ldp x29, x30, [sp], #16 // restaurar FP/LR y subir SP
    ret




// Subrutina: dibujar linea entre dos puntos
// Algoritmo de Bresenham
// x1 = x0 (punto x del punto 1)
// x2 = y0 (punto y del punto 1)
// x3 = x1 (punto x del punto 2)
// x4 = y1 (punto y del punto 2)
.global draw_line
draw_line:
    mov x7, SCREEN_WIDTH
    sub x9, x3, x1 // x9 = x1 - x0
    cmp x9, #0
    bge dx_done
    neg x9, x9

dx_done:
    mov x5, x9 // x5 = dx = |x1 - x0|

    sub x9, x4, x2 // x9 = y1 - y0
    cmp x9, #0
    bge dy_done
    neg x9, x9

dy_done:
    mov x6, x9 // x6 = dy = |y1 - y0|
    sub x14, x5, x6 // error = dx - dy
    cmp x1, x3
    ble sx_one
    mov x11, -1
    b comp_sy

sx_one:
    mov x11, 1
    b comp_sy

comp_sy:
    cmp x2, x4
    ble sy_one
    mov x12, -1
    b line_loop

sy_one:
    mov x12, 1
    b line_loop

line_loop:
    mul x13, x2, x7     // y0 * screen width
    add x13, x13, x1    // + x0
    lsl x13, x13, 2     // * 4
    add x13, x0, x13    // + framebuffer
    //x13 = framebuffer + ((y * SCREEN_WIDTH + x) * 4) = dirección del píxel (x,y)
    stur w8, [x13]

    cmp x1, x3
    bne not_equal

    cmp x2, x4
    bne not_equal

    b end_line

not_equal:
    lsl x15, x14, 1 // x15 = error * 2
    neg x16, x6
    cmp x15, x16
    bge step_x

    b check_step_y

step_x:
    sub x14, x14, x6 // error = error - dy
    add x1, x1, x11 // x0 = x0 + sx

    b check_step_y

check_step_y:
    cmp x15, x5
    ble step_y
    b line_loop

step_y:
    add x14, x14, x5 // error = error + dx
    add x2, x2, x12 // y0 = y0 + sy
    b line_loop

end_line:
    ret


.global draw_right_triangle
draw_right_triangle:
    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp
    mov x15, #0 // contador de filas

    mov x0, x20                // reset fb
    mov x1, x16                // altura = 1
    mov x2, x17                // ancho inicial = 1 (se va haciendo mas grande)
    mov x9, x4                 // Y inicial
    mov x3, x5                 // X inicial

for_loop:
    cmp x15, x8
    b.ge end_loop
    add x15, x15, #1

    mov x2, x15 // ANCHO = i

    bl draw_rectangle
    b for_loop
end_loop:
    ldp x29, x30, [sp], #16 // restaura fp/lr
    ret

.global draw_triangle
draw_triangle:
    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp
    
    mov x15, #0 // contador de filas

    mov x0, x20                // reset fb
    mov x1, x16                // altura = 1
    mov x2, x17                // ancho inicial = 1 (se va haciendo mas grande)
    mov x9, x4                 // Y inicial
    mov x3, 1
    // X inicial

for_loop_1:
    cmp x15, x8
    b.ge end_loop_1
    add x15, x15, #1

    mov x2, x15
    mov x28, x8
    sub x28, x28, x15
    lsr x28, x28, 1

    mov x3, x28
    add x3, x3, x18

    bl draw_rectangle
    b for_loop_1
end_loop_1:
    ldp x29, x30, [sp], #16 // restaura fp/lr
    ret

.global draw_right_triangle_inverted
draw_right_triangle_inverted:
    stp x29, x30, [sp, #-16]! // guarda fp/lr
    mov x29, sp
    mov x15, #0                // contador de filas
    mov x0, x20                // reset fb
    mov x1, x16                // altura = 1
    mov x2, x17                // ancho inicial = 1 (se va haciendo mas grande)
    mov x9, x4                 // Y inicial
    add x3, x3, x5 // X inicial

for_loop_2:
    cmp x15, x8
    b.ge end_loop_2
    add x15, x15, #1

    mov x2, x15
    mov x28, x8
    sub x28, x28, x15

    mov x3, x28
    add x3, x3, x18
    bl draw_rectangle
    b for_loop_2
end_loop_2:
    ldp x29, x30, [sp], #16 // restaura fp/lr
    ret



