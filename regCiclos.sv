module regCiclos(
    input logic clk, // Señal de reloj
    input logic rst, // Señal de reset,
	 input logic enable,
    output logic result // Salida del contador
	 );
	 
    logic [3:0] counter_value; //cable local
	 logic finished = 0;

    // Bloque always_ff para la lógica del contador
    always_ff @(posedge clk) begin
        if (rst) begin //si el reset es 1, ponga el contador en cero
            counter_value <= 4'b0000; // Valor de reset
				finished <= 0;
        end
		  else begin
            if (counter_value != 4'b1111 && enable) begin
                counter_value <= counter_value + 1; // Incrementa en cada flanco de reloj si hay enable
					 finished <= 0;
            end
				if (counter_value == 4'b1111 && enable) begin
					counter_value <= 4'b0000;
					finished <= 1;
					end
        end
    end
    
    // Asigna el valor del contador a la salida
    assign result = finished;
endmodule