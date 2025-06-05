//.global input_loop
//input_loop:
//
//    bl readchar
//    cmp w3, #'d'
//    b.eq move_right
//    // Si era 'd', avanzamos el auto
//
//    cmp w3, #'a'
//    b.eq move_left
//
//    cmp w3, #'w'
//    b.eq move_up
//
//    cmp w3, #'s'
//    b.eq move_down
//    b input_loop
//.global move_right
//move_right:
//    add x19, x19, #50 // mueve 5 píxeles a la derecha
//    bl draw_background
//    bl draw_car_1
//
//    b input_loop
//
//.global move_left
//move_left:
//    sub x19, x19, #50 // mueve 5 píxeles a la izquierda
//    bl draw_background
//    bl draw_car_1
//    b input_loop
//
//.global move_up
//move_up:
//    sub x27, x27, #5 // mueve 5 píxeles  arriba
//    bl draw_background
//
//    bl render_car
//    b input_loop
//
//.global move_down
//move_down:
//    add x27, x27, #5 // mueve 5 píxeles  abajo
//    bl draw_background
//
//    //add x24,x24,1  //lo deforma mucho al auto
//    //add x25,x25,1 //lo deforma mucho al auto
//    bl draw_car_1
//    b input_loop
//
//.global readchar
//readchar:
//    // PERIPHERAL_BASE ya en .equ
//    ldr x0, =GPIO_BASE
//
//    // Carga el offset FR en x2
//    movz x2, #0x1018          // UART0_FR
//    add x1, x0, x2            // x1 = PERIPHERAL_BASE + UART0_FR
//
//.global waitchar
//waitchar:
//    ldr w2, [x1]// leer UART0_FR
//    and w2, w2, #0x10
//    cbnz w2, waitchar
//
//    // Carga el offset DR en x2
//    movz x2, #0x1000          // UART0_DR
//    add x1, x0, x2            // x1 = PERIPHERAL_BASE + UART0_DR
//
//    ldr w3, [x1]// leer UART0_DR
//    ret
//
