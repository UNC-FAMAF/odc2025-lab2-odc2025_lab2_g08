.include "constants.inc"



.global draw_sky
draw_sky:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP

    //CIELO 
    MOV X0,X20
    MOV x1, #0 // x
    MOV x2, #0 // y
    LDR x3, =0x08b9ce //color
    MOV x4, #168 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle

    //SOL
    MOV X0,X20
    MOV X1,#465
    MOV X2,#20
    LDR X3,=0xF5BF42
    MOV X4,#70
    BL draw_circle

    
    
    //MONTAÑAS
    BL draw_mountain 

      //NUBES
    BL draw_clouds
    LDP X29,X30,[SP],#16

    RET


.global "draw_static_background"
draw_static_background:
    STP X29,X30,[SP,#-16]!
    MOV X29,SP
    
    //background
    MOV X0,X20
    MOV x1, #0 // x
    MOV x2, #0 // y
    LDR x3, =0x52b589 //color
    MOV x4, #SCREEN_HEIGHT // alto
    MOV x5, #SCREEN_WIDTH // ancho
    BL draw_rectangle

    //PASTO 2
    MOV X0,X20
    MOV x1, #0 // x
    MOV x2, #240 // y
    LDR x3, =0x309E6F // //color
    MOV x4, #165 // alto
    MOV x5, #640 // ancho
    BL draw_rectangle



  //BANQUINA 2
    MOV X0,X20
    MOV X1, #296
    MOV X2,#160
    LDR X3, =0x7a523c
    MOV X4,#7
    MOV X5,#80
    BL draw_shoulder_1

    //BANQUINA 1
    MOV X0,X20
    MOV X1, #285
    MOV X2,#160
    LDR X3, =0xf7caa2
    MOV X4,#7
    MOV X5,#80
    BL draw_shoulder_1

   

    //BANQUINA 4
    MOV X0,X20
    MOV X1, #239
    MOV X2,#160
    LDR X3, =0x7a523c
    MOV X4,#8
    MOV X5,#70
    BL draw_shoulder_2
    //BANQUINA 3
    MOV X0,X20
    MOV X1, #250
    MOV X2,#160
    LDR X3, =0xf7caa2
    MOV X4,#7
    MOV X5,#80
    BL draw_shoulder_2

   
    
    //RUTA
    MOV X0,X20
    MOV X1, #286
    MOV X2,#135
    LDR X3, =0x50748c
    MOV X4,#4
    MOV X5,#45
    BL draw_route
    //LINEAS DE RUTA
    //BL draw_route_lines

    BL draw_sky
    //CARTELES
    BL draw_signals


    LDP X29,X30,[SP],#16
    RET
