.include "constants.inc"

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

    //BANQUINA IZQ
    MOV x0, x20
    MOV x1, #48
    MOV x2, #495
    LDR x3, =0xf7caa2
    MOV x4, #7
    MOV X5,#350
    BL draw_lft_shoulder


    //BANQUINA DER
    MOV x0, x20
    MOV x1, #241
    MOV x2, #500
    LDR x3, =0xf7caa2
    MOV x4, #7
    MOV X5,#350
    BL draw_rgt_shoulder
    
    //RUTA
    MOV X0,X20
    MOV X1, #120
    MOV X2,#480
    LDR X3, =0x50748c
    MOV X4,#2
    MOV X5,#400
    BL draw_route

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

    //LINEAS DE RUTA
    BL draw_route_lines
    
    //MONTAÑAS
    BL draw_mountain 


    //CARTELES
    BL draw_signals

    //NUBES
    BL draw_clouds


    LDP X29,X30,[SP],#16
    RET
