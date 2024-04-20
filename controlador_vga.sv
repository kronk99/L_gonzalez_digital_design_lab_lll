module controlador_vga(
	input  clock,
	input  reset,
	input  [2:0] matrix_player [0:4][0:4],
	output [7:0] red,
	output [7:0] green,
	output [7:0] blue,
	output vgaclock,
	output hsync,
	output vsync,
	output n_blank
);

	// Contadores de píxeles y líneas
	logic [0:9] pixel_num;
	logic [0:9] linea_num;
	logic cambio_linea;

	// Matrices para las imágenes del jugador y la PC
	//reg [2:0] matrix_player [0:4][0:4] = '{'{1, 2, 3, 4, 5}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};
	reg [2:0] matrix_pc [0:4][0:4] = '{'{1, 2, 3, 1, 5}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};
	
	logic clock_25;

	// Generación del reloj de 25MHz
	clock25mh clock_iml(clock, clock_25);
	
	// Instanciación de contadores horizontales y verticales
	contador_horizontal contador_horizontal (
		.reloj(clock_25),
		.reset(reset),
		.numero_pixel(pixel_num),
		.cambio_linea(cambio_linea)
	);
														
	contador_vertical contador_vertical (
		.reloj(cambio_linea),
		.reset(reset),
		.numero_linea(linea_num)
	);
								
	// Sincronización de las señales de sincronización
	sincronizador sincronizador(
		.pixel_num(pixel_num),
		.linea_num(linea_num),
		.hsync(hsync),
		.vsync(vsync),
		.n_blank(n_blank)
	);
	
	// Generación de la cuadrícula de píxeles
	generadorMatriz generadorCuadricula (
		.x(pixel_num),
		.y(linea_num),
		.matrix_player(matrix_player),
		.matrix_pc(matrix_pc),
		.red(red),
		.green(green),
		.blue(blue)
	);
	 
	// Asignación del reloj de 25MHz al vgaclock
	assign vgaclock = clock_25;

endmodule
