.section .rodata
.align 4
.global car_desc
car_desc:
    //auto 1
    .word 33, 75, 223, 338  -20, 0x00F8, 0x3838   // carrocería principal
    .word 20, 100, 210, 350 -20, 0x00F8, 0x3838  // techo
    .word 10, 46, 237, 344  -20, 0x0000, 0x0000   // ventana
    .word 5, 24, 248, 359   -20, 0xFFFF, 0xFFFF    // luz frontal
    .word 6, 96, 212, 369   -20, 0x0000, 0x0000    // base inferior
    .word 5, 101, 209, 374  -20, 0x00F8, 0x3838   // franja lateral
    .word 11, 25, 212, 379  -20, 0x0000, 0x0000   // rueda izq
    .word 2, 15, 216, 380   -20, 0x8038, 0x3838    // guardabarros izq
    .word 11, 25, 284, 379  -20, 0x0000, 0x0000   // rueda der
    .word 2, 15, 289, 380   -20, 0x8038, 0x3838    // guardabarros der
    .word 6, 17, 289, 360   -20, 0xFFFF, 0xFFFF    // luz der
    .word 6, 17, 214, 360   -20, 0xFFFF, 0xFFFF    // luz izq

    //auto 2
    .word 33, 75, 223+50, 338+50, 0x00F8, 0x3838    // carrocería principal
    .word 20, 100, 210+50, 350+50, 0x00F8, 0x3838   // techo
    .word 10, 46, 237+50, 344+50, 0x0000, 0x0000    // ventana
    .word 5, 24, 248+50, 359+50, 0xFFFF, 0xFFFF     // luz frontal
    .word 6, 96, 212+50, 369+50, 0x0000, 0x0000     // base inferior
    .word 5, 101, 209+50, 374+50, 0x00F8, 0x3838    // franja lateral
    .word 11, 25, 212+50, 379+50, 0x0000, 0x0000    // rueda izq
    .word 2, 15, 216+50, 380+50, 0x8038, 0x3838     // guardabarros izq
    .word 11, 25, 284+50, 379+50, 0x0000, 0x0000    // rueda der
    .word 2, 15, 289+50, 380+50, 0x8038, 0x3838     // guardabarros der
    .word 6, 17, 289+50, 360+50, 0xFFFF, 0xFFFF     // luz der
    .word 6, 17, 214+50, 360+50, 0xFFFF, 0xFFFF     // luz izq

    //auto 3
    .word 33 , 75 , 223 +50 +120 , 338 + 20, 0x3030, 0x3030 // carrocería principal
    .word 20 , 100, 210 +50 +120 , 350 + 20, 0x3030, 0x3030 // techo
    .word 10 , 46 , 237 +50 +120 , 344 + 20, 0x0000, 0x0000 // ventana
    .word 5  , 24 , 248 +50 +120 , 359 + 20, 0xFFFF, 0xFFFF       // luz frontal
    .word 6  , 96 , 212 +50 +120 , 369 + 20, 0x0000, 0x0000       // base inferior
    .word 5  , 101, 209 +50 +120 , 374 + 20, 0x3030, 0x3030      // franja lateral
    .word 11 , 25 , 212 +50 +120 , 379 + 20, 0x0000, 0x0000      // rueda izq
    .word 2  , 15 , 216 +50 +120 , 380 + 20, 0x8038, 0x3838       // guardabarros izq
    .word 11 , 25 , 284 +50 +120 , 379 + 20, 0x0000, 0x0000      // rueda der
    .word 2  , 15 , 289 +50 +120 , 380 + 20, 0x8038, 0x3838       // guardabarros der
    .word 6  , 17 , 289 +50 +120 , 360 + 20, 0xFFFF, 0xFFFF       // luz der
    .word 6  , 17 , 214 +50 +120 , 360 + 20, 0xFFFF, 0xFFFF       // luz izq

   
    // AUTO 4 (escalado al 60 % para reducir 40 %)
    .word 12,  72, 162 + 140 , 120 + 100, 0xFF00, 0xFF00   // antes 20×120 @270,200
    .word 12,  84, 156 + 140 , 132 + 100, 0xFF00, 0xFF00   // antes 20×140 @260,220
    .word 18,  96, 150 + 140 , 144 + 100, 0xFF00, 0xFF00   // antes 30×160 @250,240
    .word 15,  60, 168 + 140 , 126 + 100, 0x0000, 0x0000   // antes 25×100 @280,210
    .word  6,   6, 150 + 140 , 150 + 100, 0x0000, 0x0000   // antes 10×10  @250,250
    .word  6,   6, 156 + 140 , 150 + 100, 0x00F5, 0xBF42   // antes 10×10  @260,250
    .word  6,   6, 240 + 140 , 150 + 100, 0x0000, 0x0000   // antes 10×10  @400,250
    .word  6,   6, 240 + 140 , 150 + 100, 0x0000, 0x0000   // antes 10×10  @400,250
    .word  6,   6, 234 + 140 , 150 + 100, 0x00F5, 0xBF42   // antes 10×10  @390,250
    .word  9,  24, 186 + 140 , 150 + 100, 0xFFFF, 0xFFFF   // antes 15×40  @310,250
    .word 15,  18, 150 + 140 , 162 + 100, 0x0000, 0x0000   // antes 25×30  @250,270
    .word 15,  18, 228 + 140 , 162 + 100, 0x0000, 0x0000   // antes 25×30  @380,270

car_desc_end:

.equ CAR_PARTS, (car_desc_end- car_desc)/(6*4)


.global render_car
render_car:
    // --- 1) Carga la dirección base de car_desc en x8 ---
    ADRP    x8, car_desc
    ADD     x8, x8, :lo12:car_desc

    // --- 2) (Opcional) guarda puntero al framebuffer en x20 antes de entrar
    //     por ejemplo, supongamos que x20 ya contiene la dirección del framebuffer.

    MOV     x1, #0 // x1 = índice de parte (cuántas partes hemos dibujado)

loop_parts:
    CMP     x1, #CAR_PARTS // ¿leímos todas las partes?
    B.EQ    done

    // --- 3) Carga de la descripción de la parte (6 palabras) ---
    //   .word W,   H,    X,    Y,    COLOR_LO, COLOR_HI
    LDP     w3, w2, [x8], #8    // w2=W (ancho),  w3=H (alto),   x8+=8
    LDP     w4, w5, [x8], #8    // w4=X (posX),   w5=Y (posY),   x8+=8
    LDR     w6, [x8], #4        // w6=COLOR_LO (16b bajo),       x8+=4
    LDR     w7, [x8], #4        // w7=COLOR_HI (16b alto),       x8+=4

    // --- 4) Prepara los argumentos para draw_rectangle ---
    MOV     x0, x20             // framebuffer pointer
    MOV     x1, x3              // x1 ← alto  = w3
    MOV     x2, x2              // x2 ← ancho = w2   (ya está en w2→x2)
    MOV     x3, x4              // x3 ← posX  = w4
    MOV     x9, x5              // x9 ← posY  = w5

    // --- 5) Reconstruye el color de 32 bits: (COLOR_HI << 16) | COLOR_LO ---
    LSL     x7, x7, #16         // x7 = COLOR_HI << 16
    ORR     x6, x7, x6          // x6 = x7 | COLOR_LO

    // --- 6) Llama a tu rutina de dibujo ---
    BL      draw_rectangle

    // --- 7) Avanza al siguiente índice y repite ---
    ADD     x1, x1, #1
    B       loop_parts

done:
    RET

.global draw_car_1
draw_car_1:

    RET

.global draw_car_2
draw_car_2:
    //AUTO 1
    STP     x29, x30, [sp, #-16]! // guarda fp/lr
    MOV     x29, sp

    LDP     x29, x30, [sp], #16 // restaura fp/lr
    RET
    //FIN AUTO 1
