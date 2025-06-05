/*  
    NOMBRE DE ARCHOVO: constants.s
    DESC: En este archivo se encuentran las usadas ampliamente en el lab.

 */

.ifndef CONSTANTS_INC        

    .set   CONSTANTS_INC, 1      

    .equ SCREEN_WIDTH,     640
    .equ SCREEN_HEIGHT,    480
    .equ GPIO_BASE,        0x3f200000
    .equ GPIO_GPFSEL0,     0x00
    .equ GPIO_GPLEV0,      0x34
    
    //PARA QUE VAYA MAS RAPIDO EL GAMELOOP MODIFICAR [DELAY_VALUE_1]
    .equ DELAY_VALUE_1,    0x01FF
    .equ DELAY_VALUE_2,    0xFFFF

.endif   // fin de include guard
