



//------SECCION BACKUP DE CODIGO DE TESTEO------------

//      // TEST RECTANGULO
//      // CARA :-|
//      // dibujar cabeza
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 200 // alto del rectangullo
//      mov x2, 200 // ancho del rectangulo
//      mov x9, 140 // posicion y del rectangulo
//      mov x3, 50 // posicion x del rectangulo
//
//      movz x6, 0xC8, lsl 16 // color #c874f2
//      movk x6, 0x74f2, lsl 00
//
//      bl draw_rectangle
//      //mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//      // dibujar ojo izquierdo
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 20 // alto del rectangullo
//      mov x2, 20 // ancho del rectangulo
//      mov x9, 200 // posicion y del rectangulo
//      mov x3, 100 // posicion x del rectangulo
//
//      movz x6, 0x00, lsl 16 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//      //mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//
//      //Ceja izquierda
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 5 // alto del rectangullo
//      mov x2, 20 // ancho del rectangulo
//      mov x9, 190// posicion y del rectangulo
//      mov x3, 100 // posicion x del rectangulo
//
//      movz x6, 0x00, lsl 00 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//      //mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//      // dibujar ojo derecho
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 20 // alto del rectangullo
//      mov x2, 20 // ancho del rectangulo
//      mov x9, 200 // posicion y del rectangulo
//      mov x3, 180 // posicion x del rectangulo
//
//      movz x6, 0x00, lsl 16 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//      //mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//      // dibujar ceja derecha
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 5 // alto del rectangulo
//      mov x2, 20 // ancho del rectangulo
//    mov x9, 190 // pos y
//      mov x3, 180 // pos x
//
//      movz x6, 0x00, lsl 00 // color negro
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//      //mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//
//      // dibujar boca
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 20 // alto del rectangullo
//      mov x2, 100 // ancho del rectangulo
//      mov x9, 270 // posicion y del rectangulo
//      mov x3, 100 // posicion x del rectangulo
//
//      movz x6, 0x00, lsl 16 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//      //mov x8, 5000  // Duración del delay
//    //bl funcion_delay
//
//      //TEST CIRCULO
//      // cara :)
//      mov x0, x20
//      mov x1, 450 // centro a(x)
//      mov x2, 240 // centro b(y)
//      mov x3, 100 // radio
//
//      movz x6, 0xF5, lsl 16 // color
//      movk x6, 0xBF42, lsl 00
//
//      bl draw_circle
//
//      // boca
//      mov x0, x20
//      mov x1, 450 // centro a(x)
//      mov x2, 260 // centro b(y)
//      mov x3, 70 // radio
//
//      movz x6, 0x00, lsl 16 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_circle
//
//      // tapar mitad boca
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 90 // alto del rectangullo
//      mov x2, 140 // ancho del rectangulo
//      mov x9, 180// posicion y del rectangulo
//      mov x3, 380 // posicion x del rectangulo
//
//      movz x6, 0xF5, lsl 16 // color
//      movk x6, 0xBF42, lsl 00
//
//      bl draw_rectangle
//
//      // ojo izquierdo
//      mov x0, x20
//      mov x1, 415 // centro a(x)
//      mov x2, 220 // centro b(y)
//      mov x3, 20 // radio
//
//      movz x6, 0x00, lsl 16
//      movk x6, 0x0000, lsl 00
//
//      bl draw_circle
//
//      //Ceja izquierda
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 5 // alto del rectangullo
//      mov x2, 30 // ancho del rectangulo
//      mov x9, 190// posicion y del rectangulo
//      mov x3, 400 // posicion x del rectangulo
//
//      movz x6, 0x00, lsl 00 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//
//      // ojo izquierdo
//      mov x0, x20
//      mov x1, 480 // centro a(x)
//      mov x2, 220 // centro b(y)
//      mov x3, 20 // radio
//
//      movz x6, 0x00, lsl 16
//      movk x6, 0x0000, lsl 00
//
//      bl draw_circle
//
//
//
//      //Ceja derecha
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 5 // alto del rectangullo
//      mov x2, 30 // ancho del rectangulo
//      mov x9, 190// posicion y del rectangulo
//      mov x3, 465 // posicion x del rectangulo
//
//      movz x6, 0x00, lsl 00 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle
//
//
//      //TEST PIXEL ART: (ODC)
////     .equ PIXEL_SIZE, 4
////     .equ DIR ,1
////     .equ PADDING, 10
//      // movz x6, 0x00, lsl 00 // color
//      // movk x6, 0x0000, lsl 00
//      // mov     x0, x20 //RESETEO FB
//      // mov     x1, 1*DIR*PIXEL_SIZE+OFFSET_X
//      // mov     x2, 2*DIR*PIXEL_SIZE+OFFSET_Y
//      // mov     x3, PIXEL_SIZE         // tamaño PIXEL_SIZE
//      // mov     x4, x6
//      // bl      draw_square
//
////    mov x0,x20
////    mov x1, 7*PIXEL_SIZE //ALTO
////    mov x2, PIXEL_SIZE //ANCHO
////    mov x9, 2       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 15 *    PIXEL_SIZE + PADDING//X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////    mov x0,x20
////    mov x1, 7*PIXEL_SIZE //ALTO
////    mov x2, PIXEL_SIZE //ANCHO
////    mov x9, 2       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 19 *    PIXEL_SIZE + PADDING  //X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////
////    mov x0,x20
////    mov x1, PIXEL_SIZE //ALTO
////    mov x2, 4*PIXEL_SIZE //ANCHO
////    mov x9, 2       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 15 *    PIXEL_SIZE + PADDING//X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////    mov x0,x20
////    mov x1, PIXEL_SIZE //ALTO
////    mov x2, 5*PIXEL_SIZE //ANCHO
////    mov x9, 9       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 15 *    PIXEL_SIZE + PADDING//X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////    //LETRA D
////    .equ PADDING_L,27
////
////    mov x0,x20
////    mov x1, 7*PIXEL_SIZE //ALTO
////    mov x2, PIXEL_SIZE //ANCHO
////    mov x9, 2       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 15 *    PIXEL_SIZE + PADDING+ PADDING_L//X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////    mov x0,x20
////    mov x1, 6*PIXEL_SIZE //ALTO
////    mov x2, PIXEL_SIZE //ANCHO
////    mov x9, 3       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 19 *    PIXEL_SIZE + PADDING+ PADDING_L //X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////
////    mov x0,x20
////    mov x1, PIXEL_SIZE //ALTO
////    mov x2, 3*PIXEL_SIZE //ANCHO
////    mov x9, 2       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 15 *    PIXEL_SIZE + PADDING+ PADDING_L//X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
////    mov x0,x20
////    mov x1, PIXEL_SIZE //ALTO
////    mov x2, 3*PIXEL_SIZE //ANCHO
////    mov x9, 9       *       PIXEL_SIZE      + PADDING //Y
////    mov x3, 15 *    PIXEL_SIZE + PADDING + PADDING_L//X
////    movz x6, 0x00, lsl 00 // color
////    movk x6, 0x0000, lsl 00
////    bl draw_rectangle
////
//
//      //test linea
//      mov x0, x20
//      mov x1, 320
//      mov x2, 240
//      mov x3, 300
//      mov x4, 300
//      movz x8, 0xFF, lsl 16
//      movk x8, 0xFF0F, lsl 00
//
//      bl draw_line
//
//      mov x0, x20
//      mov x1, 300
//      mov x2, 300
//      mov x3, 350
//      mov x4, 260
//      movz x8, 0xFF, lsl 16
//      movk x8, 0xFF0F, lsl 00
//
//      bl draw_line
//
//      mov x0, x20
//      mov x1, 350
//      mov x2, 260
//      mov x3, 290
//      mov x4, 260
//      movz x8, 0xFF, lsl 16
//      movk x8, 0xFF0F, lsl 00
//
//      bl draw_line
//
//      mov x0, x20
//      mov x1, 290
//      mov x2, 260
//      mov x3, 340
//      mov x4, 300
//      movz x8, 0xFF, lsl 16
//      movk x8, 0xFF0F, lsl 00
//
//      bl draw_line
//
//      mov x0, x20
//      mov x1, 340
//      mov x2, 300
//      mov x3, 320
//      mov x4, 240
//      movz x8, 0xFF, lsl 16
//      movk x8, 0xFF0F, lsl 00
//
//// Triángulo rectangulo 1 a (x=250, y=10)
//      mov x0, x20
//      mov x8, 120   // tamaño
//      mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
//      mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
//      mov x4, 250    // Y inicial
//      mov x5, 50   // X inicial
//      movz x6, 0xFF, lsl 16 // color
//      movk x6, 0xF0F0, lsl 00
//      bl  draw_right_triangle
//
//      //Triangulo equilatero
//      mov x0, x20
//      mov x8, 120   // tamaño
//      mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
//      mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
//      mov x4, 25    // Y inicial
//      mov x18, 388   // X inicial
//      movz x6, 0x00, lsl 16 // color
//      movk x6, 0x0000, lsl 00
//      bl  draw_triangle
//
//
//      mov x0, x20
//      mov x8, 120   // tamaño
//      mov x16, 1    // alto = 1 //pixel_size NO CAMBIAR
//      mov x17, 1    // ancho base = 1 //dejar en 1 porque se va ir ensanchando solo
//      mov x4, 250    // Y inicial
//      mov x18, 130  // X inicial
//      movz x6, 0xF8, lsl 16 // color
//      movk x6, 0xF9F9, lsl 00
//      bl  draw_right_triangle_inverted
//
//
//      //TEST POST LLAMADA A draw_right_triangle
//      mov x0, x20 // reinicia framebuffer
//      mov x1, 5 // alto del rectangullo
//      mov x2, 30 // ancho del rectangulo
//      mov x9, 10// posicion y del rectangulo
//      mov x3, 465 // posicion x del rectangulo
//      movz x6, 0x00, lsl 00 // color
//      movk x6, 0x0000, lsl 00
//
//      bl draw_rectangle

//mov x19, 1 //para mover la pos del auto en pos x
//mov x18, 1 //mover el auto en pos y
//bl draw_car_2
//mov x19,76 //para mover la pos del auto en pos x
//mov x18, -60 //mover el auto en pos y
//bl draw_car_1
//bl draw_background
//b input_loop
