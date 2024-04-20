module contador_horizontal(
	input logic reloj,           // Señal de reloj
	input logic reset,           // Señal de reset
	output [0:9] numero_pixel,  // Número de píxeles en la línea
	output cambio_linea         // Indicador de cambio de línea
);

	logic reset_interno;         // Señal interna de reset
	logic [0:9] maxColumnas;    // Número máximo de columnas

	//generate 

	// Instancia del contador parametrizable
	contador_parametrizable #(10) contador(
		.reloj(reloj),           // Señal de reloj para el contador
		.reset(reset_interno),   // Señal de reset interna del contador
		.out(numero_pixel)       // Número de píxeles en la línea generado por el contador
	);
	
	// Instancia del comparador de igualdad
	comparador_igual #(10) comparador_igual(
		.a(maxColumnas),         // Valor máximo de columnas
		.b(numero_pixel),        // Número de píxeles en la línea
		.iguales(cambio_linea)   // Indicador de cambio de línea
	);
	
	// Asignaciones de valores y señales
	//assign maxColumnas = 10'd799;
	assign maxColumnas = 10'd800;           // Definición del valor máximo de columnas
	assign reset_interno = reset || cambio_linea;  // Reset interno cuando hay un cambio de línea
	
	//endgenerate
	
endmodule