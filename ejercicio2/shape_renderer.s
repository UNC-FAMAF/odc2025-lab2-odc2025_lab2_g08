// DEFINE DE FIGURAS
    .equ CIRCLE,    -3
    .equ SQUARE,    -4
    .equ RECTANGLE, -5
    .equ LINE,      -6
    .equ TRIANGLE,  -7
    .equ VALOR_DE_CORTE, -999 //similar a como la stdio.h maneja los strings en printf verificando [\0]

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
    //horas invertidas en este auto: 3 hs :,v)

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
    //Compia de car 4 pero de otro color (el cambio de color podria ser implementado en un procedimiento tambien)
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

.global car_6
car_6:
 .word RECTANGLE, 36, 108, 18, 61, 0x000000
    .word RECTANGLE, 2, 16, 20, 97, 0x000000
    .word RECTANGLE, 2, 16, 108, 97, 0x000000
    .word RECTANGLE, 24, 104, 20, 63, 0x00374CD
    .word RECTANGLE, 5, 12, 22, 85, 0x00374C
    .word RECTANGLE, 5, 12, 108, 85, 0x00374C
    .word RECTANGLE, 4, 70, 38, 83, 0x000000
    .word RECTANGLE, 5, 64, 40, 81, 0x000000
    .word RECTANGLE, 11, 10, 42, 86, 0x60747D
    .word RECTANGLE, 5, 16, 40, 88, 0x60747D
    .word RECTANGLE, 11, 10, 92, 86, 0x60747D
    .word RECTANGLE, 5, 16, 90, 88, 0x60747D
    .word RECTANGLE, 5, 6, 44, 88, 0x000000
    .word RECTANGLE, 2, 10, 42, 92, 0x000000
    .word RECTANGLE, 5, 6, 94, 88, 0x000000
    .word RECTANGLE, 2, 10, 92, 92, 0x000000
    .word RECTANGLE, 2, 30, 56, 88, 0x00374C
    .word RECTANGLE, 7, 90, 26, 68, 0x054E6C
    .word RECTANGLE, 13, 8, 26, 72, 0x054E6C
    .word RECTANGLE, 11, 8, 108, 76, 0x054E6C
    .word RECTANGLE, 5, 2, 36, 76, 0x054E6C
    .word RECTANGLE, 5, 4, 106, 76, 0x054E6C
    .word RECTANGLE, 31, 48, 48, 30, 0x054E6C
    .word RECTANGLE, 31, 56, 44, 32, 0x054E6C
    .word RECTANGLE, 5, 104, 20, 57, 0x054E6C
    .word RECTANGLE, 4, 100, 22, 54, 0x054E6C
    .word RECTANGLE, 5, 96, 24, 52, 0x054E6C
    .word RECTANGLE, 2, 8, 28, 52, 0x054E6C
    .word RECTANGLE, 5, 86, 28, 50, 0x054E6C
    .word RECTANGLE, 7, 78, 34, 48, 0x054E6C
    .word RECTANGLE, 2, 74, 36, 46, 0x054E6C
    .word RECTANGLE, 2, 70, 38, 45, 0x054E6C
    .word RECTANGLE, 5, 24, 24, 59, 0x000000
    .word RECTANGLE, 5, 24, 96, 59, 0x000000
    .word RECTANGLE, 11, 18, 26, 57, 0x000000
    .word RECTANGLE, 11, 18, 100, 57, 0x000000
    .word RECTANGLE, 4, 16, 100, 65, 0x000000
    .word RECTANGLE, 4, 16, 28, 65, 0x000000
    .word RECTANGLE, 5, 16, 26, 59, 0xC7120C
    .word RECTANGLE, 2, 12, 28, 65, 0xC7120C
    .word RECTANGLE, 4, 4, 42, 61, 0xC7120C
    .word RECTANGLE, 7, 12, 102, 59, 0xC7120C
    .word RECTANGLE, 5, 2, 116, 59, 0xC7120C
    .word RECTANGLE, 4, 6, 98, 61, 0xC7120C
    .word RECTANGLE, 4, 10, 30, 61, 0x000000
    .word RECTANGLE, 4, 10, 102, 61, 0x000000
    .word RECTANGLE, 2, 44, 50, 63, 0x000000
    .word RECTANGLE, 2, 8, 28, 50, 0x00374C
    .word RECTANGLE, 4, 6, 38, 50, 0x00374C
    .word RECTANGLE, 2, 60, 42, 54, 0x00374C
    .word RECTANGLE, 4, 6, 100, 50, 0x00374C
    .word RECTANGLE, 2, 8, 106, 50, 0x00374C
    .word RECTANGLE, 15, 2, 40, 41, 0x000000
    .word RECTANGLE, 15, 2, 102, 41, 0x000000
    .word RECTANGLE, 5, 96, 24, 37, 0x00374C
    .word RECTANGLE, 2, 90, 26, 35, 0x054E6C
    .word RECTANGLE, 2, 60, 42, 34, 0x054E6C
    .word RECTANGLE, 4, 90, 26, 41, 0x000000
    .word RECTANGLE, 2, 48, 48, 35, 0x000000
    .word RECTANGLE, 4, 2, 46, 45, 0x000000
    .word RECTANGLE, 5, 2, 96, 43, 0x000000
    .word RECTANGLE, 4, 48, 48, 48, 0x000000
    .word RECTANGLE, 4, 48, 48, 45, 0x0B1D1D
    .word RECTANGLE, 4, 44, 50, 46, 0x0B1D1D
    .word RECTANGLE, 7, 38, 52, 68, 0xE3E3E3
    .word RECTANGLE, 2, 38, 52, 68, 0x000080
    .word RECTANGLE, 5, 6, 56, 70, 0x000000
    .word RECTANGLE, 2, 6, 80, 70, 0x000000
    .word RECTANGLE, 5, 2, 80, 70, 0x000000
    .word RECTANGLE, 2, 6, 80, 76, 0x000000
    .word RECTANGLE, 5, 2, 68, 70, 0x000000
    .word RECTANGLE, 2, 6, 68, 70, 0x000000
    .word RECTANGLE, 2, 4, 70, 76, 0x000000
    .word RECTANGLE, 18, 10, 114, 68, 0x054E6C
    .word RECTANGLE, 20, 12, 20, 68, 0x054E6C
    .word RECTANGLE, 5, 6, 116, 85, 0x054E6C
    .word RECTANGLE, 2, 2, 122, 86, 0x054E6C
    .word RECTANGLE, 7, 2, 34, 74, 0x054E6C
    .word RECTANGLE, 2, 2, 38, 76, 0x054E6C
    .word RECTANGLE, 2, 2, 34, 81, 0x054E6C
    .word RECTANGLE, 2, 2, 40, 77, 0x054E6C
    .word RECTANGLE, 2, 2, 40, 76, 0x054E6C
    .word RECTANGLE, 2, 66, 42, 76, 0x054E6C
    .word RECTANGLE, 5, 6, 28, 83, 0x054E6C
    .word RECTANGLE, 2, 10, 108, 86, 0x054E6C
    .word RECTANGLE, 2, 14, 108, 88, 0x00374C
    .word RECTANGLE, 7, 4, 20, 63, 0x054E6C
    .word RECTANGLE, 2, 2, 24, 66, 0x054E6C
    .word RECTANGLE, 7, 4, 120, 63, 0x054E6C
    .word RECTANGLE, 2, 2, 118, 66, 0x054E6C
    .word RECTANGLE, 2, 2, 114, 59, 0xC7120C
    .word RECTANGLE, 2, 2, 114, 61, 0xC7120C
    .word RECTANGLE, 2, 2, 114, 63, 0xC7120C
    .word RECTANGLE, 2, 2, 114, 65, 0xC7120C
    .word RECTANGLE, 2, 2, 112, 61, 0x000000
    .word RECTANGLE, 2, 2, 112, 63, 0x000000
    .word RECTANGLE, 2, 2, 104, 88, 0x000000
    .word RECTANGLE, 2, 2, 104, 90, 0x000000
    .word RECTANGLE, 2, 2, 104, 92, 0x000000
    .word RECTANGLE, 2, 10, 92, 96, 0x000000
    .word RECTANGLE, 2, 2, 102, 88, 0x000000
    .word RECTANGLE, 2, 2, 92, 90, 0x000000
    .word RECTANGLE, 9, 72, 34, 88, 0x000000
    .word RECTANGLE, 4, 60, 42, 86, 0x000000
    .word RECTANGLE, 4, 78, 34, 86, 0x054E6C
    .word RECTANGLE, 2, 2, 108, 83, 0x000000
    .word RECTANGLE, 2, 2, 108, 85, 0x000000
    .word RECTANGLE, 2, 2, 102, 77, 0x054E6C
    .word RECTANGLE, 2, 12, 22, 99, 0x000000
    .word RECTANGLE, 2, 12, 110, 99, 0x000000
    .word RECTANGLE, 2, 2, 120, 90, 0x00374C
    .word RECTANGLE, 2, 4, 112, 90, 0x00374C
    .word RECTANGLE, 2, 2, 116, 90, 0x00374C
    .word RECTANGLE, 2, 2, 116, 90, 0x00374C
    .word RECTANGLE, 2, 2, 118, 90, 0x00374C
    .word RECTANGLE, 2, 2, 114, 92, 0x00374C
    .word RECTANGLE, 2, 2, 116, 92, 0x00374C
    .word RECTANGLE, 2, 2, 118, 92, 0x00374C
    .word RECTANGLE, 2, 2, 120, 92, 0x00374C
    .word RECTANGLE, 2, 2, 122, 88, 0x00374C
    .word RECTANGLE, 2, 2, 122, 90, 0x00374C
    .word RECTANGLE, 2, 2, 112, 88, 0x054E6C
    .word RECTANGLE, 2, 2, 122, 88, 0x054E6C
    .word RECTANGLE, 2, 2, 122, 88, 0x054E6C
    .word RECTANGLE, 2, 2, 122, 88, 0x054E6C
    .word RECTANGLE, 2, 2, 122, 88, 0x054E6C
    .word RECTANGLE, 2, 2, 122, 88, 0x00374C
    .word RECTANGLE, 2, 2, 112, 88, 0x00374C
    .word RECTANGLE, 2, 2, 110, 90, 0x00374C
    .word RECTANGLE, 2, 2, 112, 77, 0x054E6C
    .word RECTANGLE, 4, 52, 46, 65, 0x00374C
    .word RECTANGLE, 2, 2, 98, 66, 0x00374C
    .word RECTANGLE, 2, 4, 42, 66, 0x00374C
    .word RECTANGLE, 2, 2, 44, 65, 0x00374C
    .word RECTANGLE, 2, 2, 36, 50, 0x00374C
    .word RECTANGLE, 2, 48, 48, 66, 0x054E6C
    .word RECTANGLE, 2, 8, 24, 90, 0x00374C
    .word RECTANGLE, 2, 2, 112, 92, 0x00374C
    .word RECTANGLE, 2, 2, 32, 90, 0x00374C
    .word RECTANGLE, 2, 2, 22, 90, 0x00374C
    .word RECTANGLE, 2, 2, 24, 92, 0x00374C
    .word RECTANGLE, 2, 2, 26, 92, 0x00374C
    .word RECTANGLE, 2, 4, 28, 92, 0x00374C
    .word RECTANGLE, 2, 2, 32, 92, 0x00374C
    .word RECTANGLE, 2, 2, 34, 90, 0x00374C
    .word RECTANGLE, 4, 74, 36, 88, 0x054E6C
    .word RECTANGLE, 2, 2, 20, 88, 0x00374C
    .word RECTANGLE, 2, 2, 122, 90, 0x000000
    .word RECTANGLE, 2, 2, 122, 90, 0x00374C
    .word RECTANGLE, 2, 2, 118, 94, 0x00374C
    .word RECTANGLE, 2, 2, 116, 94, 0x00374C
    .word RECTANGLE, 2, 2, 114, 94, 0x00374C
    .word RECTANGLE, 2, 2, 112, 94, 0x00374C
    .word RECTANGLE, 2, 2, 110, 92, 0x00374C
    .word RECTANGLE, 2, 10, 44, 96, 0xB3B3B3
    .word RECTANGLE, 2, 2, 52, 96, 0xB3B3B3
    .word RECTANGLE, 2, 2, 52, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 54, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 54, 92, 0xB3B3B3
    .word RECTANGLE, 2, 2, 54, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 52, 90, 0xB3B3B3
    .word RECTANGLE, 4, 2, 52, 88, 0xB3B3B3
    .word RECTANGLE, 2, 2, 50, 88, 0xB3B3B3
    .word RECTANGLE, 2, 2, 48, 88, 0xB3B3B3
    .word RECTANGLE, 2, 2, 46, 88, 0xB3B3B3
    .word RECTANGLE, 2, 2, 44, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 42, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 42, 92, 0xB3B3B3
    .word RECTANGLE, 2, 2, 42, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 44, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 44, 88, 0xB3B3B3
    .word RECTANGLE, 5, 6, 46, 90, 0x000000
    .word RECTANGLE, 2, 2, 44, 92, 0x000000
    .word RECTANGLE, 2, 2, 52, 92, 0x000000
    .word RECTANGLE, 2, 2, 100, 92, 0xB3B3B3
    .word RECTANGLE, 2, 2, 100, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 100, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 98, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 98, 94, 0xB3B3B3
    .word RECTANGLE, 2, 8, 92, 96, 0xB3B3B3
    .word RECTANGLE, 2, 2, 90, 96, 0xB3B3B3
    .word RECTANGLE, 2, 2, 90, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 88, 94, 0xB3B3B3
    .word RECTANGLE, 2, 2, 88, 92, 0xB3B3B3
    .word RECTANGLE, 2, 2, 88, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 90, 90, 0xB3B3B3
    .word RECTANGLE, 2, 2, 90, 88, 0xB3B3B3
    .word RECTANGLE, 2, 8, 92, 88, 0xB3B3B3
    .word RECTANGLE, 2, 6, 92, 90, 0x000000
    .word RECTANGLE, 2, 2, 60, 72, 0x000000
    .word RECTANGLE, 2, 2, 58, 72, 0xFFFFFF
    .word RECTANGLE, 2, 2, 74, 72, 0xFFFFFF
    .word RECTANGLE, 2, 2, 72, 70, 0xFFFFFF
    .word RECTANGLE, 2, 2, 72, 72, 0x000000
    .word RECTANGLE, 2, 2, 70, 74, 0x000000
    .word RECTANGLE, 2, 2, 82, 74, 0x000000
    .word RECTANGLE, 2, 2, 84, 74, 0x000000
    .word RECTANGLE, 2, 2, 26, 94, 0x00374C
    .word RECTANGLE, 2, 2, 28, 94, 0x00374C
    .word RECTANGLE, 2, 2, 30, 94, 0x00374C
    .word RECTANGLE, 2, 2, 32, 94, 0x00374C
    .word RECTANGLE, 2, 2, 34, 92, 0x00374C
    .word RECTANGLE, 2, 1, 36, 79, 0x054E6C
    .word RECTANGLE, 4, 1, 35, 78, 0x054E6C
    .word RECTANGLE, 12, 82, 34, 75, 0x054E6C
    .word RECTANGLE, 8, 38, 52, 70, 0xFFFFFF
    .word RECTANGLE, 11, 1, 52, 69, 0x054E6C
    .word RECTANGLE, 1, 6, 26, 68, 0x000000
    .word RECTANGLE, 5, 1, 55, 71, 0x000000
    .word RECTANGLE, 1, 4, 56, 76, 0x000000
    .word RECTANGLE, 5, 1, 60, 71, 0x000000
    .word RECTANGLE, 1, 4, 56, 70, 0x000000
    .word RECTANGLE, 6, 1, 62, 71, 0x000000
    .word RECTANGLE, 5, 1, 66, 71, 0x000000
    .word RECTANGLE, 1, 4, 69, 70, 0x000000
    .word RECTANGLE, 5, 1, 68, 71, 0x000000
    .word RECTANGLE, 1, 4, 69, 76, 0x000000
    .word RECTANGLE, 1, 5, 75, 70, 0x000000
    .word RECTANGLE, 1, 6, 81, 71, 0x000000
    .word RECTANGLE, 3, 1, 81, 71, 0x000000
    .word RECTANGLE, 1, 4, 82, 73, 0x000000
    .word RECTANGLE, 4, 1, 85, 73, 0x000000
    .word RECTANGLE, 1, 5, 81, 76, 0x000000
    .word RECTANGLE, 1, 6, 81, 71, 0xFFFFFF
    .word RECTANGLE, 1, 5, 82, 70, 0x000000
    .word RECTANGLE, 2, 12, 102, 65, 0xC7120C
    .word RECTANGLE, 1, 3, 114, 67, 0x000000
    .word RECTANGLE, 1, 3, 114, 68, 0x000000
    .word RECTANGLE, 4, 1, 102, 61, 0xC7120C
    .word RECTANGLE, 4, 63, 43, 82, 0x000000
    .word RECTANGLE, 4, 3, 41, 82, 0x000000
    .word RECTANGLE, 4, 6, 39, 82, 0x000000
    .word RECTANGLE, 1, 32, 56, 92, 0x054E6C
    .word RECTANGLE, 5, 32, 58, 85, 0x000000
    .word RECTANGLE, 1, 7, 91, 86, 0x000000
    .word RECTANGLE, 2, 15, 89, 86, 0x000000
    .word RECTANGLE, 3, 22, 40, 85, 0x000000
    .word RECTANGLE, 2, 7, 54, 88, 0x000000
    .word RECTANGLE, 1, 30, 57, 92, 0x000000
    .word RECTANGLE, 5, 2, 56, 89, 0x000000
    .word RECTANGLE, 4, 2, 86, 89, 0x000000
    .word RECTANGLE, 6, 2, 38, 87, 0x000000
    .word RECTANGLE, 5, 1, 37, 86, 0x000000
    .word RECTANGLE, 5, 3, 39, 88, 0x000000
    .word RECTANGLE, 3, 2, 42, 87, 0x000000
    .word RECTANGLE, 3, 6, 100, 87, 0x000000
    .word RECTANGLE, 3, 5, 102, 90, 0x000000
    .word RECTANGLE, 8, 3, 105, 84, 0x000000
    .word RECTANGLE, 2, 2, 104, 82, 0x054E6C
    .word RECTANGLE, 8, 1, 108, 87, 0x054E6C
    .word RECTANGLE, 2, 1, 107, 92, 0x000000
    .word RECTANGLE, 15, 12, 103, 81, 0x054E6C
    .word RECTANGLE, 2, 10, 111, 94, 0x00374C
    .word RECTANGLE, 11, 3, 102, 85, 0x000000
    .word RECTANGLE, 10, 3, 104, 87, 0x000000
    .word RECTANGLE, 1, 2, 107, 94, 0x000000
    .word RECTANGLE, 2, 1, 107, 90, 0x000000
    .word RECTANGLE, 2, 1, 106, 91, 0x000000
    .word RECTANGLE, 7, 8, 110, 89, 0x00374C
    .word RECTANGLE, 1, 6, 109, 88, 0x00374C
    .word RECTANGLE, 4, 2, 109, 88, 0x00374C
    .word RECTANGLE, 4, 2, 108, 88, 0x00374C
    .word RECTANGLE, 8, 14, 31, 72, 0x054E6C
    .word RECTANGLE, 10, 2, 120, 62, 0x054E6C
    .word RECTANGLE, 6, 2, 22, 63, 0x054E6C
    .word RECTANGLE, 4, 6, 37, 75, 0x054E6C
    .word RECTANGLE, 3, 12, 107, 89, 0x00374C
    .word RECTANGLE, 1, 1, 108, 88, 0x00374C
    .word RECTANGLE, 1, 1, 108, 86, 0x054E6C
    .word RECTANGLE, 1, 1, 108, 86, 0x054E6C
    .word RECTANGLE, 1, 1, 108, 87, 0x054E6C
    .word RECTANGLE, 1, 1, 104, 81, 0x054E6C
    .word RECTANGLE, 1, 1, 104, 81, 0x054E6C
    .word RECTANGLE, 2, 7, 103, 80, 0x054E6C
    .word RECTANGLE, 2, 2, 107, 81, 0x054E6C
    .word RECTANGLE, 1, 4, 104, 81, 0x054E6C
    .word RECTANGLE, 1, 1, 104, 82, 0x054E6C
    .word RECTANGLE, 1, 1, 105, 83, 0x054E6C
    .word RECTANGLE, 1, 1, 106, 85, 0x054E6C
    .word RECTANGLE, 1, 1, 106, 86, 0x054E6C
    .word RECTANGLE, 1, 1, 40, 77, 0x054E6C
    .word RECTANGLE, 3, 7, 38, 76, 0x054E6C
    .word RECTANGLE, 1, 1, 102, 59, 0xC7120C
    .word RECTANGLE, 1, 1, 48, 61, 0x054E6C
    .word RECTANGLE, 1, 1, 48, 61, 0x000000
    .word RECTANGLE, 1, 1, 94, 61, 0x000000
    .word RECTANGLE, 1, 1, 94, 61, 0x054E6C
    .word RECTANGLE, 1, 1, 120, 61, 0x054E6C
    .word RECTANGLE, 1, 1, 20, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 21, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 22, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 23, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 120, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 121, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 122, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 123, 62, 0x054E6C
    .word RECTANGLE, 1, 1, 26, 64, 0xC7120C
    .word RECTANGLE, 1, 1, 27, 64, 0xC7120C
    .word RECTANGLE, 1, 1, 28, 64, 0xC7120C
    .word RECTANGLE, 1, 1, 29, 64, 0xC7120C
    .word RECTANGLE, 1, 1, 40, 64, 0xC7120C
    .word RECTANGLE, 1, 1, 41, 64, 0xC7120C
    .word RECTANGLE, 1, 1, 97, 64, 0x000000
    .word RECTANGLE, 1, 1, 40, 65, 0xC7120C
    .word RECTANGLE, 1, 1, 44, 65, 0x000000
    .word RECTANGLE, 1, 1, 45, 65, 0x000000
    .word RECTANGLE, 1, 1, 46, 65, 0x000000
    .word RECTANGLE, 1, 1, 97, 65, 0x000000
    .word RECTANGLE, 1, 1, 98, 65, 0x000000
    .word RECTANGLE, 1, 1, 40, 66, 0xC7120C
    .word RECTANGLE, 1, 1, 42, 68, 0x054E6C
    .word RECTANGLE, 1, 1, 43, 68, 0x054E6C
    .word RECTANGLE, 1, 1, 62, 70, 0x000000
    .word RECTANGLE, 1, 1, 63, 70, 0x000000
    .word RECTANGLE, 1, 1, 64, 70, 0x000000
    .word RECTANGLE, 1, 1, 79, 70, 0x000000
    .word RECTANGLE, 1, 1, 81, 70, 0x000000
    .word RECTANGLE, 1, 1, 86, 70, 0xFFFFFF
    .word RECTANGLE, 1, 1, 65, 71, 0x000000
    .word RECTANGLE, 1, 1, 66, 71, 0xFFFFFF
    .word RECTANGLE, 1, 1, 68, 71, 0x000000
    .word RECTANGLE, 1, 1, 74, 71, 0x000000
    .word RECTANGLE, 1, 1, 75, 71, 0x000000
    .word RECTANGLE, 1, 1, 79, 71, 0x000000
    .word RECTANGLE, 1, 1, 81, 71, 0x000000
    .word RECTANGLE, 1, 1, 34, 72, 0x054E6C
    .word RECTANGLE, 1, 1, 60, 72, 0x000000
    .word RECTANGLE, 1, 1, 60, 72, 0xFFFFFF
    .word RECTANGLE, 1, 1, 74, 72, 0x000000
    .word RECTANGLE, 1, 1, 77, 72, 0x000000
    .word RECTANGLE, 1, 1, 78, 72, 0x000000
    .word RECTANGLE, 1, 1, 76, 73, 0x000000
    .word RECTANGLE, 1, 1, 77, 73, 0x000000
    .word RECTANGLE, 1, 1, 75, 74, 0x000000
    .word RECTANGLE, 1, 1, 76, 74, 0x000000
    .word RECTANGLE, 1, 1, 76, 74, 0xFFFFFF
    .word RECTANGLE, 1, 1, 64, 75, 0x000000
    .word RECTANGLE, 1, 1, 64, 75, 0xFFFFFF
    .word RECTANGLE, 1, 1, 65, 75, 0x000000
    .word RECTANGLE, 1, 1, 66, 75, 0xFFFFFF
    .word RECTANGLE, 1, 1, 75, 75, 0x000000
    .word RECTANGLE, 1, 1, 76, 75, 0x000000
    .word RECTANGLE, 1, 1, 76, 75, 0xFFFFFF
    .word RECTANGLE, 1, 1, 63, 76, 0x000000
    .word RECTANGLE, 1, 1, 64, 76, 0x000000
    .word RECTANGLE, 1, 1, 74, 76, 0x000000
    .word RECTANGLE, 1, 1, 75, 76, 0x000000
    .word RECTANGLE, 1, 1, 76, 76, 0x000000
    .word RECTANGLE, 1, 1, 77, 76, 0x000000
    .word RECTANGLE, 1, 1, 78, 76, 0x000000
    .word RECTANGLE, 1, 1, 79, 76, 0x000000
    .word RECTANGLE, 1, 1, 38, 77, 0x054E6C
    .word RECTANGLE, 1, 1, 40, 77, 0x054E6C
    .word RECTANGLE, 1, 1, 41, 77, 0x054E6C
    .word RECTANGLE, 1, 1, 104, 77, 0x054E6C
    .word RECTANGLE, 1, 1, 40, 78, 0x000000
    .word RECTANGLE, 1, 1, 41, 78, 0x000000
    .word RECTANGLE, 1, 1, 41, 78, 0x054E6C
    .word RECTANGLE, 1, 1, 36, 80, 0x054E6C
    .word RECTANGLE, 1, 1, 37, 80, 0x054E6C
    .word RECTANGLE, 1, 1, 46, 80, 0x054E6C
    .word RECTANGLE, 1, 1, 38, 82, 0x054E6C
    .word RECTANGLE, 1, 1, 39, 82, 0x054E6C
    .word RECTANGLE, 1, 1, 103, 82, 0x000000
    .word RECTANGLE, 1, 1, 104, 82, 0x000000
    .word RECTANGLE, 1, 1, 105, 82, 0x000000
    .word RECTANGLE, 1, 1, 105, 82, 0x054E6C
    .word RECTANGLE, 1, 1, 103, 83, 0x000000
    .word RECTANGLE, 1, 1, 104, 83, 0x000000
    .word RECTANGLE, 1, 1, 105, 83, 0x000000
    .word RECTANGLE, 1, 1, 106, 83, 0x000000
    .word RECTANGLE, 1, 1, 106, 83, 0x054E6C
    .word RECTANGLE, 1, 1, 38, 84, 0x000000
    .word RECTANGLE, 1, 1, 102, 84, 0x000000
    .word RECTANGLE, 1, 1, 103, 84, 0x000000
    .word RECTANGLE, 1, 1, 104, 84, 0x000000
    .word RECTANGLE, 1, 1, 105, 84, 0x000000
    .word RECTANGLE, 1, 1, 107, 84, 0x054E6C
    .word RECTANGLE, 1, 1, 38, 85, 0x000000
    .word RECTANGLE, 1, 1, 39, 85, 0x000000
    .word RECTANGLE, 1, 1, 105, 85, 0x000000
    .word RECTANGLE, 1, 1, 106, 85, 0x000000
    .word RECTANGLE, 1, 1, 108, 85, 0x000000
    .word RECTANGLE, 1, 1, 108, 85, 0x054E6C
    .word RECTANGLE, 1, 1, 38, 86, 0x000000
    .word RECTANGLE, 1, 1, 39, 86, 0x000000
    .word RECTANGLE, 1, 1, 104, 86, 0x000000
    .word RECTANGLE, 1, 1, 105, 86, 0x000000
    .word RECTANGLE, 1, 1, 106, 86, 0x000000
    .word RECTANGLE, 1, 1, 107, 86, 0x054E6C
    .word RECTANGLE, 1, 1, 108, 86, 0x000000
    .word RECTANGLE, 1, 1, 108, 86, 0x054E6C
    .word RECTANGLE, 1, 1, 104, 87, 0x000000
    .word RECTANGLE, 1, 1, 107, 87, 0x000000
    .word RECTANGLE, 1, 1, 107, 87, 0x054E6C
    .word RECTANGLE, 1, 1, 108, 87, 0x000000
    .word RECTANGLE, 1, 1, 34, 88, 0x00374C
    .word RECTANGLE, 1, 1, 35, 88, 0x00374C
    .word RECTANGLE, 1, 1, 36, 88, 0x00374C
    .word RECTANGLE, 1, 1, 107, 88, 0x000000
    .word RECTANGLE, 1, 1, 107, 88, 0x054E6C
    .word RECTANGLE, 1, 1, 107, 88, 0x00374C
    .word RECTANGLE, 1, 1, 108, 88, 0x000000
    .word RECTANGLE, 1, 1, 111, 88, 0x00374C
    .word RECTANGLE, 1, 1, 33, 89, 0x00374C
    .word RECTANGLE, 1, 1, 34, 89, 0x00374C
    .word RECTANGLE, 1, 1, 35, 89, 0x00374C
    .word RECTANGLE, 1, 1, 36, 89, 0x00374C
    .word RECTANGLE, 1, 1, 43, 89, 0x000000
    .word RECTANGLE, 1, 1, 107, 89, 0x000000
    .word RECTANGLE, 1, 1, 108, 89, 0x000000
    .word RECTANGLE, 1, 1, 110, 89, 0x00374C
    .word RECTANGLE, 1, 1, 110, 89, 0x054E6C
    .word RECTANGLE, 1, 1, 111, 89, 0x00374C
    .word RECTANGLE, 1, 1, 36, 90, 0x00374C
    .word RECTANGLE, 1, 1, 108, 90, 0x000000
    .word RECTANGLE, 1, 1, 109, 90, 0x00374C
    .word RECTANGLE, 1, 1, 36, 91, 0x000000
    .word RECTANGLE, 1, 1, 37, 91, 0x000000
    .word RECTANGLE, 1, 1, 107, 91, 0x000000
    .word RECTANGLE, 1, 1, 108, 91, 0x054E6C
    .word RECTANGLE, 1, 1, 108, 91, 0x000000
    .word RECTANGLE, 1, 1, 109, 91, 0x000000
    .word RECTANGLE, 1, 1, 109, 91, 0x00374C
    .word RECTANGLE, 1, 1, 87, 92, 0x000000
    .word RECTANGLE, 1, 1, 107, 92, 0x000000
    .word RECTANGLE, 1, 1, 108, 92, 0x000000
    .word RECTANGLE, 1, 1, 108, 92, 0x00374C
    .word RECTANGLE, 1, 1, 109, 92, 0x00374C
    .word RECTANGLE, 1, 1, 107, 93, 0x000000
    .word RECTANGLE, 1, 1, 108, 93, 0x000000
    .word RECTANGLE, 1, 1, 108, 93, 0x00374C
    .word RECTANGLE, 1, 1, 109, 93, 0x054E6C
    .word RECTANGLE, 1, 1, 109, 93, 0x00374C
    .word RECTANGLE, 1, 1, 108, 94, 0x000000
    .word RECTANGLE, 1, 1, 109, 94, 0x00374C
    .word RECTANGLE, 1, 1, 110, 94, 0x00374C
    .word RECTANGLE, 1, 1, 111, 94, 0x00374C
    .word RECTANGLE, 1, 1, 102, 95, 0x000000
    .word RECTANGLE, 1, 1, 107, 95, 0x000000
    .word RECTANGLE, 1, 1, 108, 95, 0x000000
    .word RECTANGLE, 1, 1, 109, 95, 0x00374C
    .word RECTANGLE, 1, 1, 111, 95, 0x00374C
    .word RECTANGLE, 1, 1, 100, 96, 0xFFFFFF
    .word RECTANGLE, 1, 1, 100, 96, 0x000000
    .word RECTANGLE, 1, 1, 101, 96, 0xFFFFFF
    .word RECTANGLE, 1, 1, 101, 96, 0x000000
    .word RECTANGLE, 1, 1, 100, 97, 0xFFFFFF
    .word RECTANGLE, 1, 1, 101, 97, 0xFFFFFF
 
    .word VALOR_DE_CORTE
car_6_end:


.global car_9
car_9:
    
    .word RECTANGLE, 5, 57, 44, 39, 0x000000
    .word RECTANGLE, 9, 65, 40, 41, 0x000000
    .word RECTANGLE, 8, 71, 37, 48, 0x000000
    .word RECTANGLE, 3, 50, 47, 42, 0x00FFFF
    .word RECTANGLE, 5, 53, 46, 44, 0x00FFFF
    .word RECTANGLE, 5, 57, 44, 48, 0x00FFFF
    .word RECTANGLE, 4, 58, 44, 35, 0x808080
    .word RECTANGLE, 2, 71, 37, 56, 0x808080
    .word RECTANGLE, 5, 3, 101, 36, 0x808080
    .word RECTANGLE, 5, 1, 103, 37, 0x808080
    .word RECTANGLE, 7, 3, 105, 41, 0x808080
    .word RECTANGLE, 5, 3, 41, 36, 0x808080
    .word RECTANGLE, 6, 2, 38, 42, 0x808080
    .word RECTANGLE, 8, 3, 37, 41, 0x808080
    .word RECTANGLE, 7, 3, 34, 49, 0x808080
    .word RECTANGLE, 6, 2, 108, 49, 0x808080
    .word RECTANGLE, 6, 2, 108, 47, 0x808080
    .word RECTANGLE, 7, 60, 43, 28, 0x000080
    .word RECTANGLE, 8, 44, 51, 25, 0x000080
    .word RECTANGLE, 6, 5, 38, 30, 0x000080
    .word RECTANGLE, 5, 2, 39, 36, 0x000080
    .word RECTANGLE, 5, 5, 35, 36, 0x000080
    .word RECTANGLE, 9, 2, 35, 41, 0x000080
    .word RECTANGLE, 8, 3, 32, 41, 0x000080
    .word RECTANGLE, 8, 4, 30, 48, 0x000080
    .word RECTANGLE, 6, 5, 102, 30, 0x000080
    .word RECTANGLE, 6, 2, 104, 35, 0x000080
    .word RECTANGLE, 5, 4, 105, 36, 0x000080
    .word RECTANGLE, 8, 3, 108, 39, 0x000080
    .word RECTANGLE, 8, 3, 110, 47, 0x000080
    .word RECTANGLE, 2, 3, 34, 56, 0x000000
    .word RECTANGLE, 2, 3, 108, 56, 0x000000
    .word RECTANGLE, 5, 2, 108, 51, 0x808080
    .word RECTANGLE, 6, 1, 111, 49, 0x0000FF
    .word RECTANGLE, 7, 1, 111, 48, 0x000080
    .word RECTANGLE, 6, 4, 110, 50, 0x000080
    .word RECTANGLE, 1, 1, 42, 35, 0x000080
    .word RECTANGLE, 1, 1, 42, 34, 0x000080
    .word RECTANGLE, 1, 1, 42, 35, 0x000080
    .word RECTANGLE, 4, 3, 41, 33, 0x000080
    .word RECTANGLE, 6, 11, 57, 25, 0xFFFFFF
    .word RECTANGLE, 10, 13, 74, 25, 0xFFFFFF
    .word RECTANGLE, 10, 12, 57, 25, 0xFFFFFF
    .word RECTANGLE, 10, 6, 58, 58, 0xFFFFFF
    .word RECTANGLE, 5, 88, 28, 59, 0x000080
    .word RECTANGLE, 9, 9, 25, 56, 0x000080
    .word RECTANGLE, 7, 2, 111, 56, 0x000080
    .word RECTANGLE, 11, 7, 112, 54, 0x000080
    .word RECTANGLE, 15, 79, 34, 58, 0x000080
    .word RECTANGLE, 15, 12, 59, 58, 0xFFFFFF
    .word RECTANGLE, 13, 10, 78, 59, 0xFFFFFF
    .word RECTANGLE, 15, 10, 77, 58, 0xFFFFFF
    .word RECTANGLE, 12, 9, 78, 57, 0xFFFFFF
    .word RECTANGLE, 1, 1, 96, 102, 0xFFFFFF
    .word RECTANGLE, 2, 31, 77, 57, 0x808080
    .word RECTANGLE, 2, 49, 37, 57, 0x808080
    .word RECTANGLE, 2, 16, 65, 57, 0x000000
    .word RECTANGLE, 3, 19, 63, 58, 0x000000
    .word RECTANGLE, 6, 2, 61, 58, 0x808080
    .word RECTANGLE, 5, 1, 82, 58, 0x808080
    .word RECTANGLE, 4, 1, 82, 59, 0x808080
    .word RECTANGLE, 5, 2, 82, 59, 0x808080
    .word RECTANGLE, 4, 18, 64, 53, 0x808080
    .word RECTANGLE, 5, 15, 65, 55, 0x000000
    .word RECTANGLE, 2, 10, 64, 57, 0x000000
    .word RECTANGLE, 2, 21, 62, 60, 0x000000
    .word RECTANGLE, 2, 65, 39, 73, 0x808080
    .word RECTANGLE, 14, 2, 104, 74, 0x808080
    .word RECTANGLE, 11, 2, 37, 75, 0x808080
    .word RECTANGLE, 3, 2, 39, 85, 0x808080
    .word RECTANGLE, 3, 2, 102, 87, 0x808080
    .word RECTANGLE, 2, 64, 40, 89, 0x808080
    .word RECTANGLE, 2, 3, 40, 88, 0x808080
    .word RECTANGLE, 11, 65, 39, 75, 0x000000
    .word RECTANGLE, 2, 62, 42, 85, 0x000000
    .word RECTANGLE, 4, 61, 41, 85, 0x000000
    .word RECTANGLE, 6, 9, 43, 79, 0xFFFF00
    .word RECTANGLE, 6, 9, 91, 79, 0xFFFF00
    .word RECTANGLE, 3, 7, 44, 78, 0xFFFF00
    .word RECTANGLE, 3, 2, 52, 81, 0xFFFF00
    .word RECTANGLE, 5, 2, 42, 80, 0xFFFF00
    .word RECTANGLE, 3, 6, 44, 84, 0xFFFF00
    .word RECTANGLE, 3, 6, 92, 78, 0xFFFF00
    .word RECTANGLE, 4, 1, 90, 80, 0xFFFF00
    .word RECTANGLE, 1, 6, 93, 85, 0xFFFF00
    .word RECTANGLE, 5, 1, 100, 80, 0xFFFF00
    .word RECTANGLE, 2, 5, 45, 86, 0xFFFF00
    .word RECTANGLE, 2, 1, 49, 85, 0xFFFF00
    .word RECTANGLE, 2, 1, 50, 85, 0xFFFF00
    .word RECTANGLE, 1, 3, 94, 86, 0xFFFF00
    .word RECTANGLE, 26, 14, 23, 63, 0x000080
    .word RECTANGLE, 23, 6, 21, 64, 0x000080
    .word RECTANGLE, 19, 10, 106, 70, 0x000080
    .word RECTANGLE, 23, 9, 111, 64, 0x000080
    .word RECTANGLE, 4, 15, 25, 88, 0x000080
    .word RECTANGLE, 4, 15, 104, 88, 0x000080
    .word RECTANGLE, 7, 3, 116, 83, 0x000080
    .word RECTANGLE, 21, 5, 119, 65, 0x000080
    .word RECTANGLE, 13, 8, 115, 57, 0x000080
    .word RECTANGLE, 18, 4, 121, 61, 0x000080
    .word RECTANGLE, 19, 4, 122, 68, 0x000080
    .word RECTANGLE, 9, 6, 119, 81, 0x000080
    .word RECTANGLE, 16, 4, 23, 59, 0x000080
    .word RECTANGLE, 20, 4, 20, 66, 0x000080
    .word RECTANGLE, 5, 94, 23, 91, 0xC0C0C0
    .word RECTANGLE, 4, 92, 24, 94, 0xC0C0C0
    .word RECTANGLE, 3, 64, 40, 90, 0x808080
    .word RECTANGLE, 4, 66, 39, 71, 0x808080
    .word RECTANGLE, 11, 2, 37, 75, 0x808080
    .word RECTANGLE, 10, 1, 105, 75, 0x808080
    .word RECTANGLE, 2, 1, 20, 84, 0x0000FF
    .word RECTANGLE, 3, 94, 24, 97, 0x000080
    .word RECTANGLE, 3, 93, 24, 99, 0x000080
    .word RECTANGLE, 6, 5, 118, 89, 0x000080
    .word RECTANGLE, 4, 3, 117, 91, 0x000080
    .word RECTANGLE, 3, 3, 20, 84, 0x000080
    .word RECTANGLE, 5, 4, 21, 86, 0x000080
    .word RECTANGLE, 4, 2, 21, 90, 0x000080
    .word RECTANGLE, 5, 1, 21, 90, 0x000080
    .word RECTANGLE, 6, 3, 20, 87, 0x000080
    .word RECTANGLE, 17, 2, 19, 73, 0x000080
    .word RECTANGLE, 3, 21, 25, 101, 0x000080
    .word RECTANGLE, 2, 23, 92, 102, 0x000080
    .word RECTANGLE, 15, 3, 19, 92, 0x000000
    .word RECTANGLE, 17, 11, 21, 94, 0x000000
    .word RECTANGLE, 14, 7, 19, 96, 0x000000
    .word RECTANGLE, 10, 5, 29, 99, 0x000000
    .word RECTANGLE, 3, 80, 33, 104, 0x000000
    .word RECTANGLE, 17, 13, 110, 94, 0x000000
    .word RECTANGLE, 9, 15, 109, 101, 0x000000
    .word RECTANGLE, 6, 5, 110, 97, 0x000000
    .word RECTANGLE, 11, 3, 121, 96, 0x000000
    .word RECTANGLE, 3, 52, 43, 95, 0x000000
    .word RECTANGLE, 1, 1, 25, 92, 0x808080
    .word RECTANGLE, 4, 92, 24, 91, 0xC0C0C0
    .word RECTANGLE, 1, 1, 56, 77, 0xC0C0C0
    .word RECTANGLE, 1, 1, 56, 80, 0xC0C0C0
    .word RECTANGLE, 1, 1, 56, 83, 0xC0C0C0
    .word RECTANGLE, 1, 1, 56, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 59, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 62, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 65, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 69, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 73, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 76, 87, 0xC0C0C0
    .word RECTANGLE, 1, 1, 78, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 81, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 87, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 83, 86, 0xC0C0C0
    .word RECTANGLE, 1, 1, 60, 77, 0xC0C0C0
    .word RECTANGLE, 1, 1, 60, 81, 0xC0C0C0
    .word RECTANGLE, 1, 1, 60, 84, 0xC0C0C0
    .word RECTANGLE, 1, 1, 64, 84, 0xC0C0C0
    .word RECTANGLE, 1, 1, 65, 82, 0xC0C0C0
    .word RECTANGLE, 1, 1, 64, 77, 0xC0C0C0
    .word RECTANGLE, 1, 1, 68, 78, 0xC0C0C0
    .word RECTANGLE, 1, 1, 74, 78, 0xC0C0C0
    .word RECTANGLE, 1, 1, 78, 78, 0xC0C0C0
    .word RECTANGLE, 1, 1, 85, 78, 0xC0C0C0
    .word RECTANGLE, 1, 1, 85, 82, 0xC0C0C0
    .word RECTANGLE, 1, 1, 81, 81, 0xC0C0C0
    .word RECTANGLE, 1, 1, 77, 81, 0xC0C0C0
    .word RECTANGLE, 1, 1, 72, 81, 0xC0C0C0
    .word RECTANGLE, 1, 1, 70, 83, 0xC0C0C0
    .word RECTANGLE, 1, 1, 74, 83, 0xC0C0C0
    .word RECTANGLE, 1, 1, 79, 83, 0xC0C0C0
    .word RECTANGLE, 12, 30, 55, 92, 0x000000
    .word RECTANGLE, 5, 14, 85, 99, 0x000080
    .word RECTANGLE, 5, 12, 43, 99, 0x000080
    .word RECTANGLE, 1, 5, 62, 95, 0xFFFFFF
    .word RECTANGLE, 6, 1, 61, 96, 0xFFFFFF
    .word RECTANGLE, 1, 6, 62, 98, 0xFFFFFF
    .word RECTANGLE, 4, 3, 66, 99, 0xFFFFFF
    .word RECTANGLE, 2, 5, 62, 102, 0xFFFFFF
    .word RECTANGLE, 5, 2, 60, 97, 0xFFFFFF
    .word RECTANGLE, 1, 6, 72, 95, 0xFFFFFF
    .word RECTANGLE, 5, 1, 77, 95, 0xFFFFFF
    .word RECTANGLE, 4, 2, 72, 95, 0xFFFFFF
    .word RECTANGLE, 2, 5, 73, 98, 0xFFFFFF
    .word RECTANGLE, 4, 2, 77, 100, 0xFFFFFF
    .word RECTANGLE, 1, 3, 74, 103, 0xFFFFFF
    .word RECTANGLE, 2, 2, 58, 94, 0xFFFFFF
    .word RECTANGLE, 3, 1, 59, 95, 0xFFFFFF
    .word RECTANGLE, 10, 32, 55, 77, 0x000000
    .word RECTANGLE, 7, 16, 71, 81, 0x000000
    .word RECTANGLE, 8, 1, 61, 79, 0xFFFFFF
    .word RECTANGLE, 2, 2, 61, 79, 0xFFFFFF
    .word RECTANGLE, 2, 2, 62, 80, 0xFFFFFF
    .word RECTANGLE, 2, 1, 64, 81, 0xFFFFFF
    .word RECTANGLE, 2, 2, 64, 82, 0xFFFFFF
    .word RECTANGLE, 2, 2, 65, 83, 0xFFFFFF
    .word RECTANGLE, 2, 2, 66, 85, 0xFFFFFF
    .word RECTANGLE, 9, 1, 68, 78, 0xFFFFFF
    .word RECTANGLE, 9, 1, 73, 78, 0xFFFFFF
    .word RECTANGLE, 2, 3, 73, 81, 0xFFFFFF
    .word RECTANGLE, 5, 2, 73, 79, 0xFFFFFF
    .word RECTANGLE, 2, 2, 76, 80, 0xFFFFFF
    .word RECTANGLE, 2, 1, 78, 79, 0xFFFFFF
    .word RECTANGLE, 1, 3, 74, 83, 0xFFFFFF
    .word RECTANGLE, 2, 1, 77, 84, 0xFFFFFF
    .word RECTANGLE, 1, 1, 78, 85, 0xFFFFFF
    .word RECTANGLE, 1, 1, 79, 86, 0xFFFFFF
    .word RECTANGLE, 1, 2, 79, 87, 0xFFFFFF
    .word RECTANGLE, 2, 4, 116, 53, 0xFFFFFF
    .word RECTANGLE, 2, 2, 117, 53, 0xFFFFFF
    .word RECTANGLE, 3, 3, 117, 53, 0x000080
    .word RECTANGLE, 6, 7, 118, 49, 0x000080
    .word RECTANGLE, 4, 5, 123, 52, 0x000080
    .word RECTANGLE, 2, 4, 119, 54, 0x000080
    .word RECTANGLE, 2, 6, 23, 55, 0x000080
    .word RECTANGLE, 3, 6, 20, 53, 0x000080
    .word RECTANGLE, 4, 6, 18, 54, 0x000080
    .word RECTANGLE, 1, 1, 19, 52, 0x000080
    .word RECTANGLE, 1, 1, 18, 53, 0x000080
    .word RECTANGLE, 1, 1, 20, 54, 0x000080
    .word RECTANGLE, 2, 1, 18, 52, 0x000080
    .word RECTANGLE, 1, 2, 19, 54, 0x000080
    .word RECTANGLE, 2, 1, 20, 54, 0x000080
    .word RECTANGLE, 1, 1, 19, 54, 0x000080
    .word RECTANGLE, 2, 1, 20, 52, 0x000080
    .word RECTANGLE, 2, 1, 21, 52, 0x000080
    .word RECTANGLE, 1, 1, 21, 54, 0x000080
    .word RECTANGLE, 1, 2, 19, 54, 0x000080
    .word RECTANGLE, 2, 1, 18, 53, 0x000080
    .word RECTANGLE, 1, 1, 17, 53, 0x000080
    .word RECTANGLE, 5, 2, 17, 53, 0x000080
    .word RECTANGLE, 2, 1, 19, 53, 0x000080
    .word RECTANGLE, 1, 1, 22, 57, 0x000080
    .word RECTANGLE, 1, 4, 17, 58, 0x000080
    .word RECTANGLE, 2, 5, 18, 57, 0x000080
    .word RECTANGLE, 2, 3, 122, 55, 0x000080
    .word RECTANGLE, 3, 8, 119, 47, 0xFFFFFF
    .word RECTANGLE, 2, 4, 117, 48, 0xFFFFFF
    .word RECTANGLE, 6, 3, 127, 51, 0xFFFFFF
    .word RECTANGLE, 2, 2, 123, 56, 0xFFFFFF
    .word RECTANGLE, 2, 1, 123, 56, 0xFFFFFF
    .word RECTANGLE, 2, 1, 123, 56, 0xFFFFFF
    .word RECTANGLE, 1, 1, 122, 56, 0xFFFFFF

    .word VALOR_DE_CORTE

car_9_end:


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



/*
    Funcion: [render_shape]
    Descripcion:Este renderizador viene de la idea en como la stdio.h maneja el printeo de los arreglos de caracteres,
    como los autos estan alineados en memoria, el procedimiento va recorriendo desde la primera word dada por el puntero almacenado en x8 
    siempre comprobando primero que estamos en un valor distinto al [VALOR_DE_CORTE], de esta manera nos aseguramos que el procedimiento termine 
    de recorrer la memoria cuando es debido, cuando no teniamos esta condicion de corte el programa se buggeaba dado que seguia recorriendo la memoria
    trayendo la basura que habia en esos offsets.
    Esta manera de renderizar los autos nos ahorró mucho tiempo,lineas de codigo y lo mas importante nos permitió siempre tener referencia a los autos,
    al tenerlos en memoria, podemos apuntar a ellos y modificar su tamaño,posicion, etc..

    Parametros:
        FB_BASE_ADDRESS --> X20    (dirección base del framebuffer; debe estar en X20 antes de llamar)
        SHAPE_PTR       --> X8     (puntero a la primera palabra del arreglo que describe la figura)

    Salidas:
        No retorna valor explícito en registros. El resultado es la imagen dibujada en memoria de video.

    Registros usados (recap):
        input:  {X8, X20}                 X8 recorre la lista de componentes en memoria; X20 es base del framebuffer
        temp:   {X9, X4, X5, X14, X15, X6}  
            - W9  <- tipo
            - W4  <- alto
            - W5  <- ancho
            - W14 <- posX
            - W15 <- posY
            - W6  <- color
        output: {}                        ninguna salida por registro

    Guardar/Restaurar:
        Se guarda en pila X29,X30. No se guardan otros registros ya que todas las llamadas a 
        draw_* preservan (o asumen responsabilidad de guardar) sus propios registros temporales.
*/
.global render_shape
render_shape:
    // Guardar frame pointer y link register
    STP     X29, X30, [SP, #-16]!   // Reserva 16 bytes y almacena X29 y X30
    MOV     X29, SP                 // Establece el nuevo frame pointer

.loop_component:
    // Cargar el "tipo" del próximo componente y avanzar X8 en 4 bytes
    LDR     W9, [X8], #4            // W9 = tipo
    CMP     W9, #VALOR_DE_CORTE
    BEQ     .done                   // Si encontramos el VALOR_DE_CORTE, terminamos

    // Cargar los parámetros del componente uno a uno
    LDR     W4,  [X8], #4           // W4 = alto
    LDR     W5,  [X8], #4           // W5 = ancho
    LDR     W14, [X8], #4           // W14 = posX
    LDR     W15, [X8], #4           // W15 = posY
    LDR     W6,  [X8], #4           // W6 = color

    // Mover datos a registros de convención para las rutinas draw_*
    MOV     W4, W4                  // X4  = alto
    MOV     W5, W5                  // X5  = ancho
    MOV     W1, W14                 // X1  = posX
    MOV     W2, W15                 // X2  = posY
    MOV     W3, W6                  // X3  = color

    // Preparar argumento para framebuffer (X0)
    MOV     X0, X20                 // X0 = FB_BASE_ADDRESS

    // switch según el tipo de componente
    CMP     W9, #RECTANGLE
    BEQ     .draw_rect
    CMP     W9, #CIRCLE
    BEQ     .draw_circ
    CMP     W9, #LINE
    BEQ     .draw_line
    CMP     W9, #TRIANGLE
    BEQ     .draw_triang
    // Si no coincide ningún tipo conocido, ignorar y continuar
    B       .loop_component

.draw_rect:
    BL      draw_rectangle          // Llama a draw_rectangle(X0, X1, X2, X3, X4, X5)
    B       .loop_component

.draw_circ:
    //TODO           
    B       .loop_component

.draw_line:
    //TODO                          
    B       .loop_component

.draw_triang:
    //TODO           
    B       .loop_component

.done:
    // Restaurar frame pointer y link register, y devolver
    LDP     X29, X30, [SP], #16     // Restaura X29,X30 y libera 16 bytes de pila
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

/*
    Funcion: [scale_shape]
    Descripcion: Recorre en memoria los componentes de una figura ("shape") y escala 
                 sus parámetros (alto, ancho, posX, posY) según el porcentaje indicado. 
                 Cada componente se almacena como una secuencia de .word. El bucle avanza 
                 hasta encontrar el VALOR_DE_CORTE, que indica el fin de la lista. 
                 Para cada componente, lee los campos, aplica la operación:
                     campo_escalado = (campo_actual * scale_percent) / 100
                 y sobrescribe el valor en memoria.

    Parametros:
        SHAPE_PTR       --> X8    (puntero al primer campo "tipo" de la figura)
        SCALE_PERCENT   --> W1    (factor de escala en %, p. ej. 60 → reduce al 60%)

    Salidas:
        No retorna valor explícito en registros. Modifica en memoria los campos escalados 
        de cada componente en el arreglo original.

    Registros usados (recap):
        input:  {X8, W1}              ; X8 apunta al arreglo de componentes; W1 = porcentaje de escala
        temp:   {X2, W7, W17, W3, W4, W5, W6} 
                 ; X2  = scale_percent extendido (W1 → X2)
                 ; W7  = divisor fijo (100)
                 ; W17 = tipo de componente leído
                 ; W3  = alto temporal
                 ; W4  = ancho temporal
                 ; W5  = posX temporal
                 ; W6  = posY temporal
        output: {}                    ; sobrescribe en memoria los valores escalados

    Guardar/Restaurar:
        Se guarda en pila X29,X30 (frame pointer y link register). No se guardan otros 
        registros, asumiendo que cualquier llamado posterior preserva sus propios usados.
*/
.global scale_shape
scale_shape:
    // Prologue: guardar frame pointer y link register
    STP     X29, X30, [SP, #-16]!   // Reserva 16 bytes en pila y almacena X29,X30
    MOV     X29, SP                 // Nuevo frame pointer

    // Preparar registros para cálculo
    MOV     X2, X1                  // X2 = scale_percent (W1 extendido a X2)
    MOV     W7, #100                // W7 = 100 (divisor para porcentajes)
    MOV     X10, X8                 // X10 = cursor que recorre componentes en memoria

.loop:
    // Leer el "tipo" del componente actual sin desplazar X10 todavía
    LDR     W17, [X10]              // W17 = tipo (offset #0)
    CMP     W17, #VALOR_DE_CORTE
    BEQ     .done1                  // Si es VALOR_DE_CORTE, terminamos

    // --- Escalar campo "alto" en offset #4 ---
    LDR     W3, [X10, #4]           // W3 = alto_actual
    MUL     W3, W3, W2              // W3 = alto_actual * scale_percent
    UDIV    W3, W3, W7              // W3 = (alto_actual * scale%) / 100
    STR     W3, [X10, #4]           // Sobrescribir alto escalado

    // --- Escalar campo "ancho" en offset #8 ---
    LDR     W4, [X10, #8]           // W4 = ancho_actual
    MUL     W4, W4, W2              // W4 = ancho_actual * scale_percent
    UDIV    W4, W4, W7              // W4 = (ancho_actual * scale%) / 100
    STR     W4, [X10, #8]           // Sobrescribir ancho escalado

    // --- Escalar campo "posX" en offset #12 ---
    LDR     W5, [X10, #12]          // W5 = posX_actual
    MUL     W5, W5, W2              // W5 = posX_actual * scale_percent
    UDIV    W5, W5, W7              // W5 = (posX_actual * scale%) / 100
    STR     W5, [X10, #12]          // Sobrescribir posX escalada

    // --- Escalar campo "posY" en offset #16 ---
    LDR     W6, [X10, #16]          // W6 = posY_actual
    MUL     W6, W6, W2              // W6 = posY_actual * scale_percent
    UDIV    W6, W6, W7              // W6 = (posY_actual * scale%) / 100
    STR     W6, [X10, #16]          // Sobrescribir posY escalada

    // --- Avanzar al siguiente componente según el tipo ---
    // RECTANGLE y LINE: 6 campos → 6 × 4 bytes = 24 bytes totales
    CMP     W17, #RECTANGLE
    BEQ     .skip6
    CMP     W17, #LINE
    BEQ     .skip6

    // CIRCLE y TRIANGLE: 7 campos → 7 × 4 bytes = 28 bytes totales
    CMP     W17, #CIRCLE
    BEQ     .skip7
    CMP     W17, #TRIANGLE
    BEQ     .skip7

    // Por defecto, tratar como 6 campos
.skip6:
    ADD     X10, X10, #24            // Avanzar apuntador 24 bytes
    B       .loop

.skip7:
    ADD     X10, X10, #28            // Avanzar apuntador 28 bytes
    B       .loop

.done1:
    // Epilogue: restaurar frame pointer y link register, y retornar
    LDP     X29, X30, [SP], #16      // Restaura X29,X30 y libera 16 bytes de pila
    RET
