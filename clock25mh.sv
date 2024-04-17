module clock25mh(
	input logic clock_50,    // Entrada de reloj de 50 MHz
	output logic clock_25    // Salida de reloj de 25 MHz
);

	logic [0:1] counter_clock;   // Contador para dividir la frecuencia del reloj
	logic reset = 0;             // Señal de reset inicializada a cero
	
	// Instancia de un contador parametrizable para dividir la frecuencia del reloj
	contador_parametrizable #(2) divisor_clock(
		.reloj(clock_50),
		.reset(reset),
		.out(counter_clock)
	);
	//endgenerate

	// Siempre combinacional para asignar la salida del reloj de 25 MHz
	always_comb begin
		clock_25 = counter_clock[1]; // La salida del reloj de 25 MHz proviene del segundo bit del contador
	end

endmodule
