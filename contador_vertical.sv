module contador_vertical(
	input logic reloj,
	input logic reset,
	output [0:9] numero_linea
);

	// Declaración de variables locales
	logic cambio_linea;
	logic reset_interno;
	logic [0:9] maxFilas; // Máximo número de filas
	logic maxAlcanzado; // Indica si se ha alcanzado el máximo
	
	// Generación de un contador parametrizable de 10 bits
	contador_parametrizable #(10) contador(
		.reloj(reloj),
		.reset(reset_interno),
		.out(numero_linea)
	);
	
	// Comparador que verifica si el número de línea es igual al máximo
	comparador_igual #(10) comparador_igual(
		.a(maxFilas),
		.b(numero_linea),
		.iguales(maxAlcanzado)
	);
	
	// Asignación del valor máximo de filas
	// assign maxFilas = 10'd523; // Este valor se puede utilizar si se desea un número específico de filas
	assign maxFilas = 10'd525; // Se asigna un valor máximo de 525 filas según la especificación VGA
	
	// La señal de reset interno se activa si se alcanza el número máximo de filas
	assign reset_interno = reset || maxAlcanzado;
	
endmodule
