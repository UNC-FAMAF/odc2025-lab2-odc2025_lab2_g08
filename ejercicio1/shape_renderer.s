// DEFINE DE FIGURAS
    .equ CIRCLE,    -3
    .equ SQUARE,    -4
    .equ RECTANGLE, -5
    .equ LINE,      -6
    .equ TRIANGLE,  -7
    .equ VALOR_DE_CORTE, -999 //similar a como C maneja los strings en printf

.section .data
.global car_1
car_1:
    // TIPO      | ALTO | ANCHO |    X     |    Y     |   COLOR
    .word RECTANGLE, 7,    70,      223, 338,0x057CA1
    .word RECTANGLE, 17,    80,     219, 344,0x097194
    .word RECTANGLE, 7,    105,     207, 354,0x097194
    .word RECTANGLE, 6,    9,       207, 354,0x000000 //ESPEJO IZQ
    .word RECTANGLE, 6,    9,       302, 354,0x000000 //ESPEJO DER
    .word RECTANGLE, 11,    48,     235, 349,0x000000 //LUNETA TRASERA
    .word RECTANGLE, 21,    112,    203, 360,0x057CA1
    .word RECTANGLE, 9,    25,     203, 367, 0x383838 //BACK LUZ IZQ
    .word RECTANGLE, 9,    25,     290, 367, 0x383838 //BACK LUZ DER
    .word RECTANGLE, 5,    10,     206, 371, 0xFBB372 //LUZ IZ1
    .word RECTANGLE, 5,    10,     215, 371, 0xEE6F54
    .word RECTANGLE, 5,    10,     293, 371, 0xEE6F54 //LUZ DER
    .word RECTANGLE, 5,    10,     302, 371, 0xFBB372
    .word RECTANGLE, 7,    35,     242, 370, 0xFFFFFF //PATENTE
    .word RECTANGLE, 4,    104,    206, 381, 0x000000 // PARTE DE PARAGOLPES
    .word RECTANGLE, 5,    60,     230, 390, 0x353E46 //SOMBRA
    //INI RUEDAS
    .word RECTANGLE,   10,      25,    207 -2, 389, 0x000000
    .word RECTANGLE,    2,    17,    210 -2,  395,  0x888888
    .word RECTANGLE, 10,    25,    285 +2, 389, 0x000000
    .word RECTANGLE,  2,    17,    289 +2,  395,  0x888888
    //FIN RUEDAS
    .word RECTANGLE, 6,    114,    202, 384, 0x057CA1 //PARAGOLPES TRASERO
    //INICIO PATENTE
    ////S
    //.word RECTANGLE, 6,    5,     243 +2 , 371   , 0x000000
    //.word RECTANGLE, 1,    3,     246 +2 , 373   , 0XFFFFFF
    //.word RECTANGLE, 1,    3,     243 +2 , 374   , 0XFFFFFF
    //.word RECTANGLE, 1,    2,     243 +2 , 371   , 0XFFFFFF    
    //.word RECTANGLE, 1,    2,     247 +2 , 376   , 0XFFFFFF    
    ////A
    //.word RECTANGLE, 1,    4,     244+6 +2,   371, 0x000000
    //.word RECTANGLE, 6,    1,     244+6 +2,   371, 0x000000
    //.word RECTANGLE, 6,    1,     251+2 +2,   371, 0x000000
    //.word RECTANGLE, 1,    4,     244+6 +2,   374, 0x000000
    ////N
    //.word RECTANGLE, 6,    1,     250+6 +2,   371, 0x000000
    //.word RECTANGLE, 1,    3,     250+6 +2,   371, 0x000000
    //.word RECTANGLE, 6,    1,     256+2 +2,   371, 0x000000
    ////T
    //.word RECTANGLE, 6,    1,     260+3 +2,   371, 0x000000
    //.word RECTANGLE, 1,    4,     262   +2,     371, 0x000000
    ////I
    //.word RECTANGLE, 6,    1,     263+4 +2,   371, 0x000000
    .word VALOR_DE_CORTE
car_1_end:


.global car_2
car_2:
    // TIPO      | ALTO | ANCHO |    X      |    Y      |    COLOR
    .word RECTANGLE, 12,    72,   162+140, 120+100, 0xFF00FF00
    .word RECTANGLE, 12,    84,   156+140, 132+100, 0xFF00FF00
    .word RECTANGLE, 18,    96,   150+140, 144+100, 0xFF00FF00
    .word RECTANGLE, 15,    60,   168+140, 126+100, 0x00000000
    .word RECTANGLE,  6,     6,   150+140, 150+100, 0x00000000
    .word RECTANGLE,  6,     6,   156+140, 150+100, 0xFFFFFFFF
    .word RECTANGLE,  6,     6,   240+140, 150+100, 0x00000000
    .word RECTANGLE,  6,     6,   240+140, 150+100, 0x00000000
    .word RECTANGLE,  6,     6,   234+140, 150+100, 0xFFFFFFFF
    .word RECTANGLE,  9,    24,   186+140, 150+100, 0xFFFFFFFF
    .word RECTANGLE, 15,    18,   150+140, 162+100, 0x00000000
    .word RECTANGLE, 15,    18,   228+140, 162+100, 0x00000000
    .word VALOR_DE_CORTE
car_2_end:

.global rand
rand:
    // TIPO      | ALTO  | ANCHO |    X     |    Y     |   COLOR
    .word RECTANGLE, 480,  640,     0,    165, 0x52B589
    .word RECTANGLE, 150,  640,     0,    200, 0x309E6F
    .word VALOR_DE_CORTE
rand_end:

.global car_3
car_3:
    // TIPO      | ALTO | ANCHO |    X     |    Y     |   COLOR
    .word RECTANGLE, 7,    70,      223, 338,0x700be3
    .word RECTANGLE, 17,    80,     219, 344,0x610ac4
    .word RECTANGLE, 7,    105,     207, 354,0x610ac4
    .word RECTANGLE, 6,    9,       207, 354,0x000000 //ESPEJO IZQ
    .word RECTANGLE, 6,    9,       302, 354,0x000000 //ESPEJO DER
    .word RECTANGLE, 11,    48,     235, 349,0x000000 //LUNETA TRASERA
    .word RECTANGLE, 21,    112,    203, 360,0x700be3
    .word RECTANGLE, 9,    25,     203, 367, 0x383838 //BACK LUZ IZQ
    .word RECTANGLE, 9,    25,     290, 367, 0x383838 //BACK LUZ DER
    .word RECTANGLE, 5,    10,     206, 371, 0xFBB372 //LUZ IZ1
    .word RECTANGLE, 5,    10,     215, 371, 0xEE6F54
    .word RECTANGLE, 5,    10,     293, 371, 0xEE6F54 //LUZ DER
    .word RECTANGLE, 5,    10,     302, 371, 0xFBB372
    .word RECTANGLE, 7,    35,     242, 370, 0xFFFFFF //PATENTE
    .word RECTANGLE, 4,    104,    206, 381, 0x000000 // PARTE DE PARAGOLPES
    .word RECTANGLE, 5,    60,     230, 390, 0x353E46 //SOMBRA
    //INI RUEDAS
    .word RECTANGLE,   10,      25,    207 -2, 389, 0x000000
    .word RECTANGLE,    2,    17,    210 -2,  395,  0x888888
    .word RECTANGLE, 10,    25,    285 +2, 389, 0x000000
    .word RECTANGLE,  2,    17,    289 +2,  395,  0x888888
    //FIN RUEDAS
    .word RECTANGLE, 6,    114,    202, 384, 0x700be3 //PARAGOLPES TRASERO
    //INICIO PATENTE
   
    .word VALOR_DE_CORTE
car_3_end:



.global car_4
car_4:
    //horas invertidas en este auto: 3 hs

    // TIPO      | ALTO | ANCHO |    X      |    Y      |    COLOR
    .word RECTANGLE, 7,70, 180, 300,0x06608a
    .word RECTANGLE, 7,80, 175, 306,0x06608a
    .word RECTANGLE, 23,90, 170, 312,0x003a51


    .word RECTANGLE, 40,135, 148, 350 ,0x000000

    .word RECTANGLE, 45,130, 150, 345 ,0x003a51


    .word RECTANGLE, 45,110, 160, 330 ,0x06608a
    .word RECTANGLE, 25,120, 155, 340 ,0x06608a


    .word RECTANGLE, 6,115, 157, 317,0x06608a
    .word RECTANGLE, 6,125, 152, 322,0x06608a
    .word RECTANGLE, 6,125, 152, 328,0x003a51

    .word RECTANGLE, 30,68, 181, 312 ,0x000000
    .word RECTANGLE, 17,80, 175, 318 ,0x000000

    .word RECTANGLE, 18,58, 186, 318 ,0x172227
    .word RECTANGLE, 10,70, 180, 322 ,0x172227

    .word RECTANGLE, 5,5, 170, 312 ,0x000000
    .word RECTANGLE, 5,5, 255, 312 ,0x000000

    .word RECTANGLE, 10,10, 170, 325 ,0x000000
    .word RECTANGLE, 6,10, 165, 329 ,0x000000

    .word RECTANGLE, 10,10, 250, 325 ,0x000000
    .word RECTANGLE, 6,10, 255, 329 ,0x000000


    .word RECTANGLE, 5,10, 185, 342 ,0x003a51
    .word RECTANGLE, 5,5,  190, 347 ,0x003a51
    .word RECTANGLE, 5,5,  194, 352 ,0x003a51

    .word RECTANGLE, 5,10, 235, 342 ,0x003a51
    .word RECTANGLE, 5,5,  235, 347 ,0x003a51
    .word RECTANGLE, 5,5,  231, 352 ,0x003a51

    //luz izq
    .word RECTANGLE, 15,15, 162, 350 ,0x000000
    .word RECTANGLE, 10,14, 168, 355 ,0xfdc551
    .word RECTANGLE, 5,20,  168, 365 ,0xeea032
    .word RECTANGLE, 5,5,   177, 355 ,0x000000
    .word RECTANGLE, 5,5,   182, 360 ,0x000000
    .word RECTANGLE, 5,5,   187, 365 ,0x000000
    .word RECTANGLE, 5,5,   167, 365 ,0x000000

    // Luz derecha
    .word RECTANGLE, 15,15, 253, 350 ,0x000000
    .word RECTANGLE, 10,15, 248, 355 ,0xfdc551
    .word RECTANGLE, 5,21,  242, 365 ,0xeea032
    .word RECTANGLE, 5,5,   248, 355 ,0x000000
    .word RECTANGLE, 5,5,   248-5, 355+5 ,0x000000
    .word RECTANGLE, 5,5,   248-5 -5, 355+5 +5 ,0x000000
    .word RECTANGLE, 5,5,   258, 365 ,0x000000



    .word RECTANGLE, 15,92, 169, 379 ,0x000000

    .word RECTANGLE, 6,120, 155, 390 ,0x06608a
    .word RECTANGLE, 8,8, 153, 385 ,0x06608a
    .word RECTANGLE, 8,8, 269, 385 ,0x06608a

    .word VALOR_DE_CORTE

car_4_end:



.global car_5
car_5:
    //horas invertidas en este auto: 3 hs
    // TIPO      | ALTO | ANCHO |    X      |    Y      |    COLOR
    .word RECTANGLE, 8,70, 181, 300,0xc22419
    .word RECTANGLE, 8,80, 176, 306,0xc22419
    .word RECTANGLE, 23,90, 170,312,0x9c2017


    .word RECTANGLE, 40,135, 148, 350 ,0x000000

    .word RECTANGLE, 45,130, 150, 345 ,0x9c2017


    .word RECTANGLE, 45,110, 160, 330 ,0xc22419
    .word RECTANGLE, 25,120, 155, 340 ,0xc22419


    .word RECTANGLE, 6,115, 157, 317,0xc22419
    .word RECTANGLE, 6,125, 152, 322,0xc22419
    .word RECTANGLE, 6,125, 152, 328,0x9c2017

    .word RECTANGLE, 30,68, 181, 312 ,0x000000
    .word RECTANGLE, 17,80, 175, 318 ,0x000000

    .word RECTANGLE, 18,58, 186, 318 ,0x172227
    .word RECTANGLE, 10,70, 180, 322 ,0x172227

    .word RECTANGLE, 5,5, 170, 312 ,0x000000
    .word RECTANGLE, 5,5, 255, 312 ,0x000000

    .word RECTANGLE, 10,10, 170, 325 ,0x000000
    .word RECTANGLE, 6,10, 165, 329 ,0x000000

    .word RECTANGLE, 10,10, 250, 325 ,0x000000
    .word RECTANGLE, 6,10, 255, 329 ,0x000000


    .word RECTANGLE, 5,10, 185, 342 ,0x9c2017
    .word RECTANGLE, 5,5,  190, 347 ,0x9c2017
    .word RECTANGLE, 5,5,  194, 352 ,0x9c2017

    .word RECTANGLE, 5,10, 235, 342 ,0x9c2017
    .word RECTANGLE, 5,5,  235, 347 ,0x9c2017
    .word RECTANGLE, 5,5,  231, 352 ,0x9c2017

    //luz izq
    .word RECTANGLE, 15,15, 162, 350 ,0x000000
    .word RECTANGLE, 10,14, 168, 355 ,0xfdc551
    .word RECTANGLE, 5,20,  168, 365 ,0xeea032
    .word RECTANGLE, 5,5,   177, 355 ,0x000000
    .word RECTANGLE, 5,5,   182, 360 ,0x000000
    .word RECTANGLE, 5,5,   187, 365 ,0x000000
    .word RECTANGLE, 5,5,   167, 365 ,0x000000

    // Luz derecha
    .word RECTANGLE, 15,15, 253, 350 ,0x000000
    .word RECTANGLE, 10,15, 248, 355 ,0xfdc551
    .word RECTANGLE, 5,21,  242, 365 ,0xeea032
    .word RECTANGLE, 5,5,   248, 355 ,0x000000
    .word RECTANGLE, 5,5,   248-5, 355+5 ,0x000000
    .word RECTANGLE, 5,5,   248-5 -5, 355+5 +5 ,0x000000
    .word RECTANGLE, 5,5,   258, 365 ,0x000000



    .word RECTANGLE, 15,92, 169, 379 ,0x000000

    .word RECTANGLE, 6,120, 155, 390-1 ,0xc22419
    .word RECTANGLE, 8,8, 153, 385 ,0xc22419
    .word RECTANGLE, 8,8, 269, 385 ,0xc22419

    .word VALOR_DE_CORTE

car_5_end:


.global plane_1
plane_1:
    
    //.word RECTANGLE, height, width, X, Y, ARGB_COLOR
    .word RECTANGLE, 5, 1, 8, 10, 0x585555
    .word RECTANGLE, 7, 1, 9, 9, 0x2B2B2B
    .word RECTANGLE, 1, 1, 7, 12, 0x2B2B2B
    .word RECTANGLE, 1, 1, 8, 12, 0x2B2B2B
    .word RECTANGLE, 1, 1, 9, 9, 0x585555
    .word RECTANGLE, 1, 1, 9, 15, 0x585555
    .word RECTANGLE, 1, 1, 9, 12, 0x585555
    .word RECTANGLE, 3, 1, 10, 11, 0x2B2B2B
    .word RECTANGLE, 1, 2, 11, 10, 0x2B2B2B
    .word RECTANGLE, 1, 1, 13, 9, 0x2B2B2B
    .word RECTANGLE, 1, 6, 14, 8, 0x2B2B2B
    .word RECTANGLE, 1, 6, 20, 9, 0x2B2B2B
    .word RECTANGLE, 2, 1, 26, 7, 0x2B2B2B
    .word RECTANGLE, 1, 1, 27, 6, 0x2B2B2B
    .word RECTANGLE, 1, 4, 28, 5, 0x2B2B2B
    .word RECTANGLE, 1, 1, 31, 6, 0x2B2B2B
    .word RECTANGLE, 7, 1, 30, 7, 0x2B2B2B
    .word RECTANGLE, 1, 3, 31, 12, 0x2B2B2B
    .word RECTANGLE, 1, 4, 26, 13, 0x2B2B2B
    .word RECTANGLE, 1, 1, 26, 14, 0x2B2B2B
    .word RECTANGLE, 1, 6, 20, 14, 0x2B2B2B
    .word RECTANGLE, 1, 1, 20, 15, 0x2B2B2B
    .word RECTANGLE, 1, 1, 21, 16, 0x2B2B2B
    .word RECTANGLE, 2, 1, 22, 17, 0x2B2B2B
    .word RECTANGLE, 1, 6, 17, 18, 0x2B2B2B
    .word RECTANGLE, 1, 1, 16, 17, 0x2B2B2B
    .word RECTANGLE, 1, 1, 15, 16, 0x2B2B2B
    .word RECTANGLE, 1, 1, 15, 15, 0x2B2B2B
    .word RECTANGLE, 1, 1, 14, 15, 0x2B2B2B
    .word RECTANGLE, 1, 1, 11, 14, 0x2B2B2B
    .word RECTANGLE, 1, 1, 12, 15, 0x2B2B2B
    .word RECTANGLE, 1, 1, 13, 15, 0x2B2B2B
    .word RECTANGLE, 2, 2, 11, 11, 0xFD1C1C
    .word RECTANGLE, 2, 2, 14, 9, 0x00FFFF
    .word RECTANGLE, 1, 1, 13, 10, 0x00FFFF
    .word RECTANGLE, 1, 3, 17, 9, 0xFD1C1C
    .word RECTANGLE, 1, 8, 19, 10, 0xFD1C1C
    .word RECTANGLE, 1, 1, 26, 9, 0xFD1C1C
    .word RECTANGLE, 2, 1, 27, 7, 0xFD1C1C
    .word RECTANGLE, 1, 3, 28, 6, 0xFD1C1C
    .word RECTANGLE, 1, 1, 28, 7, 0xFD1C1C
    .word RECTANGLE, 1, 1, 29, 7, 0xFD1C1C
    .word RECTANGLE, 2, 1, 16, 9, 0x2B2B2B
    .word RECTANGLE, 1, 3, 13, 11, 0x2B2B2B
    .word RECTANGLE, 1, 1, 17, 11, 0x2B2B2B
    .word RECTANGLE, 1, 1, 18, 10, 0x2B2B2B
    .word RECTANGLE, 1, 1, 13, 11, 0x800000
    .word RECTANGLE, 1, 1, 15, 10, 0x008080
    .word RECTANGLE, 5, 2, 28, 8, 0x800000
    .word RECTANGLE, 4, 1, 27, 9, 0x800000
    .word RECTANGLE, 1, 5, 25, 11, 0x2B2B2B
    .word RECTANGLE, 1, 1, 25, 12, 0x2B2B2B
    .word RECTANGLE, 1, 2, 28, 12, 0xFFFF00
    .word RECTANGLE, 1, 1, 27, 12, 0xFFA500
    .word RECTANGLE, 1, 1, 26, 12, 0xFFA500
    .word RECTANGLE, 1, 5, 17, 17, 0xFFA500
    .word RECTANGLE, 1, 4, 17, 16, 0xFFFF00
    .word RECTANGLE, 1, 3, 17, 15, 0xFFFF00
    .word RECTANGLE, 1, 7, 18, 11, 0x800000
    .word RECTANGLE, 1, 5, 13, 12, 0x800000
    .word RECTANGLE, 1, 1, 16, 11, 0x800000
    .word RECTANGLE, 1, 1, 17, 10, 0x800000
    .word RECTANGLE, 1, 1, 16, 11, 0xFD1C1C
    .word RECTANGLE, 1, 15, 11, 13, 0x800000
    .word RECTANGLE, 1, 3, 12, 14, 0x800000
    .word RECTANGLE, 1, 1, 14, 14, 0x2B2B2B
    .word RECTANGLE, 1, 5, 15, 14, 0xFFFF00
    .word RECTANGLE, 1, 1, 16, 15, 0xFFFF00
    .word RECTANGLE, 1, 1, 16, 16, 0xFFFF00
    .word RECTANGLE, 1, 4, 21, 12, 0xFFFF00
    .word RECTANGLE, 1, 3, 18, 12, 0xFFA500
    .word RECTANGLE, 1, 5, 34, 12, 0x2B2B2B
    .word RECTANGLE, 1, 1, 39, 11, 0x2B2B2B
    .word RECTANGLE, 1, 1, 40, 10, 0x2B2B2B
    .word RECTANGLE, 1, 1, 41, 9, 0x2B2B2B
    .word RECTANGLE, 1, 1, 39, 13, 0x2B2B2B
    .word RECTANGLE, 1, 1, 40, 14, 0x2B2B2B
    .word RECTANGLE, 1, 1, 41, 15, 0x2B2B2B
    .word RECTANGLE, 8, 1, 42, 8, 0x2B2B2B
    .word RECTANGLE, 1, 25, 43, 16, 0x2B2B2B
    .word RECTANGLE, 8, 1, 68, 8, 0x2B2B2B
    .word RECTANGLE, 1, 25, 43, 7, 0x2B2B2B
    .word RECTANGLE, 1, 2, 43, 8, 0xFFFFFF
    .word RECTANGLE, 8, 25, 43, 8, 0xFFFFFF
    .word RECTANGLE, 1, 3, 45, 9, 0x000000
    .word RECTANGLE, 4, 1, 44, 10, 0x000000
    .word RECTANGLE, 1, 3, 45, 14, 0x000000
    .word RECTANGLE, 4, 1, 48, 10, 0x000000
    .word RECTANGLE, 6, 1, 50, 9, 0x000000
    .word RECTANGLE, 1, 1, 51, 9, 0x000000
    .word RECTANGLE, 1, 1, 52, 10, 0x000000
    .word RECTANGLE, 2, 1, 53, 11, 0x000000
    .word RECTANGLE, 1, 1, 51, 14, 0x000000
    .word RECTANGLE, 1, 1, 52, 13, 0x000000
    .word RECTANGLE, 1, 3, 56, 9, 0x000000
    .word RECTANGLE, 4, 1, 55, 10, 0x000000
    .word RECTANGLE, 1, 3, 56, 14, 0x000000
    .word RECTANGLE, 1, 3, 60, 9, 0x000000
    .word RECTANGLE, 1, 1, 62, 10, 0x000000
    .word RECTANGLE, 1, 1, 61, 11, 0x000000
    .word RECTANGLE, 1, 1, 60, 12, 0x000000
    .word RECTANGLE, 1, 1, 60, 13, 0x000000
    .word RECTANGLE, 1, 1, 60, 14, 0x000000
    .word RECTANGLE, 1, 2, 61, 14, 0x000000
    .word RECTANGLE, 1, 1, 61, 12, 0x000000
    .word RECTANGLE, 1, 1, 62, 11, 0x000000
    .word RECTANGLE, 1, 3, 64, 9, 0x000000
    .word RECTANGLE, 1, 1, 64, 10, 0x000000
    .word RECTANGLE, 1, 1, 64, 11, 0x000000
    .word RECTANGLE, 1, 1, 65, 11, 0x000000
    .word RECTANGLE, 1, 1, 66, 11, 0x000000
    .word RECTANGLE, 1, 1, 66, 12, 0x000000
    .word RECTANGLE, 1, 1, 66, 13, 0x000000
    .word RECTANGLE, 1, 1, 65, 14, 0x000000
    .word RECTANGLE, 1, 1, 64, 14, 0x000000

    .word VALOR_DE_CORTE

plane_1_end:




// render_shape:
//   X0 = dirección base del framebuffer
//   X8 = puntero al primer .word del shape (tipo, alto, ancho, x, y, color, …, VALOR_DE_CORTE)
//   Usará la convención:
//     X1 = posX, X2 = posY, X3 = color, X4 = alto, X5 = ancho
//     X20 = framebuffer/contexto de dibujo

.global render_shape
render_shape:
   
    STP     X29, X30, [SP, #-16]!   // guardar FP y LR
    MOV     X29, SP

.loop_component:
    // Cargar tipo y avanzar X8
    LDR     W9, [X8], #4           // W9 = tipo
    CMP     W9, #VALOR_DE_CORTE
    BEQ     .done                   // si es VALOR_DE_CORTE, terminamos

    // Cargar campos: alto, ancho, posX, posY, color
    LDR     W4,  [X8], #4            // W4 = alto
    LDR     W5,  [X8], #4            // W5 = ancho
    LDR     W14, [X8], #4           // W14 = posX
    LDR     W15, [X8], #4           // W15 = posY
    LDR     W6,  [X8], #4           // W6 = color

    // Mover a registros X (extender a 64 bits)
    MOV     W4, W4                  // X4 = alto
    MOV     W5, W5                  // X5 = ancho
    MOV     W1, W14                 // X1 = posX
    MOV     W2, W15                 // X2 = posY
    MOV     W3, W6                 // X3 = color

    // Preparar framebuffer/contexto
    MOV     X0, X20

    CMP     W9, #RECTANGLE
    BEQ     .draw_rect
    CMP     W9, #CIRCLE
    BEQ     .draw_circ
    CMP     W9, #LINE
    BEQ     .draw_line
    CMP     W9, #TRIANGLE
    BEQ     .draw_triang
    // Si no coincide ningún tipo, ignorar y continuar
    B       .loop_component

.draw_rect:
    BL      draw_rectangle
    B      .loop_component

.draw_circ:
    BL      draw_circle
    B       .loop_component

.draw_line:
    BL      draw_line
    B       .loop_component

.draw_triang:
    BL      draw_triangle
    B       .loop_component

.done:
    LDP     X29, X30, [SP], #16      // restaurar FP y LR
    RET




.global move_shape
move_shape:
    STP     X29, X30, [SP, #-16]!    // Guardar FP y LR
    MOV     X29, SP

    // Entradas:
    //   X8 = puntero al primer componente de la forma
    //   W1 = deltaX, W2 = deltaY

    MOV     X11, X1      // X11 = deltaX
    MOV     X12, X2      // X12 = deltaY
    MOV     X10, X8      // X10 = cursor en memoria de la forma

.loop_move:
    LDR     W9, [X10]    // W9 = tipo
    CMP     W9, #VALOR_DE_CORTE
    BEQ     .done_move

    // --- actualizar posX (offset 3*4 = 12 bytes) ---
    LDR     W1, [X10, #12]   // W1 = posX
    ADD    W1, W1, W11      // W1 += deltaX
    STR     W1, [X10, #12]

    // --- actualizar posY (offset 4*4 = 16 bytes) ---
    LDR     W2, [X10, #16]   // W2 = posY
    ADD    W2, W2, W12      // W2 += deltaY
    STR     W2, [X10, #16]

    // --- desplazarse al siguiente componente según tipo ---
    // RECTANGLE (-5) y LINE (-6) tienen 6 campos (6×4 = 24 bytes)
    CMP     W9, #RECTANGLE
    BEQ     .skip_6
    CMP     W9, #LINE
    BEQ     .skip_6

    // CIRCLE (-3) y TRIANGLE (-7) tienen 7 campos (7×4 = 28 bytes)
    CMP     W9, #CIRCLE
    BEQ     .skip_7
    CMP     W9, #TRIANGLE
    BEQ     .skip_7

    // Por defecto, tratar como 6 campos
.skip_6:
    ADD     X10, X10, #24
    B       .loop_move

.skip_7:
    ADD     X10, X10, #28
    B       .loop_move

.done_move:
    LDP     X29, X30, [SP], #16     // Restaurar FP y LR
    RET

// ----------------------------------------------------------------------------
// scale_shape:
//   Escala en el lugar todas las componentes de una figura.
// Entradas:
//   X8 = puntero al primer campo (tipo) de la forma
//   W1 = factor de escala en %, p. ej. 60 → reduce al 60%
// Convención: X1 - X5, X7 pueden clobber; X20 = framebuffer/contexto (no usado aquí)
// ----------------------------------------------------------------------------
.global scale_shape
scale_shape:
    STP     X29, X30, [SP, #-16]!   // prologue: guardar FP y LR
    MOV     X29, SP

    MOV    X2, X1                 // X2 = scale_percent (extendido)
    MOV     W7, #100               // divisor fijo para porcentajes
    MOV     X10, X8                // X10 = cursor sobre componentes

.loop:
    // Leer tipo en W17
    LDR     W17, [X10]             
    CMP     W17, #VALOR_DE_CORTE   
    BEQ     .done1                 // si es VALOR_DE_CORTE, salir

    // --- Escalar alto en offset #4 ---
    LDR     W3, [X10, #4]          // W3 = alto_actual
    MUL     W3, W3, W2             // W3 = alto_actual * scale_percent
    UDIV    W3, W3, W7             // W3 = (alto_actual * scale%) / 100
    STR     W3, [X10, #4]          // guardar alto escalado

    // --- Escalar ancho en offset #8 ---
    LDR     W4, [X10, #8]          // W4 = ancho_actual
    MUL     W4, W4, W2             // W4 = ancho_actual * scale_percent
    UDIV    W4, W4, W7             // W4 = (ancho_actual * scale%) / 100
    STR     W4, [X10, #8]          // guardar ancho escalado

    // --- Escalar posX en offset #12 ---
    LDR     W5, [X10, #12]         // W5 = posX_actual
    MUL     W5, W5, W2             // W5 = posX_actual * scale_percent
    UDIV    W5, W5, W7             // W5 = (posX_actual * scale%) / 100
    STR     W5, [X10, #12]         // guardar posX escalada

    // --- Escalar posY en offset #16 ---
    LDR     W6, [X10, #16]         // W6 = posY_actual
    MUL     W6, W6, W2             // W6 = posY_actual * scale_percent
    UDIV    W6, W6, W7             // W6 = (posY_actual * scale%) / 100
    STR     W6, [X10, #16]         // guardar posY escalada

    // --- Avanzar al siguiente componente ---
    // RECTANGLE y LINE usan 6 campos (6×4 = 24 bytes)
    CMP     W17, #RECTANGLE
    BEQ     .skip6
    CMP     W17, #LINE
    BEQ     .skip6
    // CIRCLE y TRIANGLE usan 7 campos (7×4 = 28 bytes)
    CMP     W17, #CIRCLE
    BEQ     .skip7
    CMP     W17, #TRIANGLE
    BEQ     .skip7
    // Por defecto, tratar como 6 campos
.skip6:
    ADD     X10, X10, #24
    B       .loop

.skip7:
    ADD     X10, X10, #28
    B       .loop

.done1:
    LDP     X29, X30, [SP], #16     // epilogue: restaurar FP y LR
    RET

