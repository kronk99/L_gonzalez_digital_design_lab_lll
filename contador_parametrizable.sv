module contador_parametrizable #(parameter n = 5) (
	input logic reloj,      // Entrada del reloj
	input logic reset,       // Entrada de reset
	output reg [n-1:0] out  // Salida del contador
);

	reg [n-1:0] contador = 0; // Registro que almacena el valor del contador
	
	// Proceso siempre activo que se ejecuta en el flanco de subida del reloj
	always @ (posedge reloj) begin
		if (reset) // Si la señal de reset está activa
			contador <= 0; // Reiniciar el contador a cero
		else
			contador <= contador + 1'd1; // Incrementar el contador en uno
	end
	
	// Asignación de la salida del contador
	assign out = contador;

endmodule
