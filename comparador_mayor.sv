module comparador_mayor #(parameter n = 5) (
	input wire [n-1:0] a,    // Entrada A del comparador
	input wire [n-1:0] b,    // Entrada B del comparador
	output reg mayor         // Salida que indica si A es mayor que B
);

	always @* begin
		// Lógica para determinar si A es mayor que B
		if (a > b) begin
			mayor = 1;   // Si A es mayor que B, se establece la salida en 1
		end
		else begin
			mayor = 0;   // Si A no es mayor que B, se establece la salida en 0
		end
	end
	
endmodule