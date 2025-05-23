
    .equ SCREEN_WIDTH, 640
    .equ SCREEN_HEIGH, 480
    .equ BITS_PER_PIXEL, 32

    .equ GPIO_BASE, 0x3f200000
    .equ GPIO_GPFSEL0, 0x00
    .equ GPIO_GPLEV0, 0x34

.globl main

main:
    // x0 contiene la direccion base del framebuffer
    mov x20, x0 // Guarda la dirección base del framebuffer en x20
    //---------------- CODE HERE ------------------------------------

    movz x10, 0xFFFF, lsl00     //Bits 0-15
    movk x10, 0xFFFF, lsl16     // del 16-31

    mov x2, SCREEN_HEIGH // Y Size
loop1:
    mov x1, SCREEN_WIDTH // X Size
loop0:
    stur w10, [x0]// Colorear el pixel N
    add x0, x0, 4          // Siguiente pixel
    sub x1, x1, 1          // Decrementar contador X
    cbnz x1, loop0 // Si no terminó la fila, salto
    sub x2, x2, 1 // Decrementar contador Y
    cbnz x2, loop1 // Si no es la última fila, salto

    // Ejemplo de uso de gpios
    mov x9, GPIO_BASE

    // Atención: se utilizan registros w porque la documentación de broadcom
    // indica que los registros que estamos leyendo y escribiendo son de 32 bits

    // Setea gpios 0 - 9 como lectura
    str wzr, [x9, GPIO_GPFSEL0]

    // Lee el estado de los GPIO 0 - 31
    ldr w10, [x9, GPIO_GPLEV0]

    // And bit a bit mantiene el resultado del bit 2 en w10
    and w11, w10, 0b10

    // w11 será 1 si había un 1 en la posición 2 de w10, si no será 0
    // efectivamente, su valor representará si GPIO 2 está activo
    lsr w11, w11, 1

    bl draw_background
    
    bl render_car

    //---------------------------------------------------------------
    // Infinite Loop
InfLoop:
    b InfLoop

//--------------------------------------------------------------------
// SUBRUTINAS
// -------------------------------------------------------------------


start:
    //Cargo el auto en memoria
    
    ret

update:

    b update


draw_from_memory:

    ret


input_loop:

    bl readchar
    cmp w3, #'d'
    b.eq move_right
    // Si era 'd', avanzamos el auto

    cmp w3, #'a'
    b.eq move_left

    cmp w3, #'w'
    b.eq move_up

    cmp w3, #'s'
    b.eq move_down
    b input_loop

move_right:
    add x19, x19, #50 // mueve 5 píxeles a la derecha
    bl draw_background
    bl draw_car_1

    b input_loop

move_left:
    sub x19, x19, #50 // mueve 5 píxeles a la izquierda
    bl draw_background
    bl draw_car_1
    b input_loop

move_up:
    sub x27, x27, #5 // mueve 5 píxeles  arriba
    bl draw_background

    //sub x24,x24,4
    //sub x25,x25,1

    bl draw_car_1
    b input_loop

move_down:
    add x27, x27, #5 // mueve 5 píxeles  abajo
    bl draw_background

    //add x24,x24,1  //lo deforma mucho al auto
    //add x25,x25,1 //lo deforma mucho al auto
    bl draw_car_1
    b input_loop

readchar:
    // PERIPHERAL_BASE ya en .equ
    ldr x0, =GPIO_BASE

    // Carga el offset FR en x2
    movz x2, #0x1018          // UART0_FR
    add x1, x0, x2            // x1 = PERIPHERAL_BASE + UART0_FR

waitchar:
    ldr w2, [x1]// leer UART0_FR
    and w2, w2, #0x10
    cbnz w2, waitchar

    // Carga el offset DR en x2
    movz x2, #0x1000          // UART0_DR
    add x1, x0, x2            // x1 = PERIPHERAL_BASE + UART0_DR

    ldr w3, [x1]// leer UART0_DR
    ret


