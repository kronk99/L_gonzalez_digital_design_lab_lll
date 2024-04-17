module comparador_igual #(parameter n = 5) (
	input wire [n-1:0] a,      // Entrada A del comparador
	input wire [n-1:0] b,      // Entrada B del comparador
	output reg iguales         // Salida que indica si A es igual a B
);

	always @* begin
		// Lógica para determinar si A es igual a B
		if (a == b) begin
			iguales = 1;   // Si A es igual a B, se establece la salida en 1
		end
		else begin
			iguales = 0;   // Si A no es igual a B, se establece la salida en 0
		end
	end
	
endmodule
