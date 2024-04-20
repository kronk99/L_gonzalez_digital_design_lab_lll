module contador_casillas ( //se utiliza para moverme entre las cassillas
//parte de la logica de colocar los barcos, fsm state 2;
    input logic clk, rst, enable, signal,
    output logic [4:0] result
);
    reg [4:0] numActual; // Inicialización de numActual
	 
    always_ff @(posedge clk) begin
        if (rst) begin
            numActual <= 5'b00001;
        end else begin
            if (signal && enable) begin
                numActual <= numActual + 1;
                if (numActual > 5'b11001) begin
                    numActual <= 5'b00001;
                end 
					 else begin
						numActual <= numActual;
					 end
            end else begin
					numActual <= numActual;
				end
        end
    end
	 assign result = numActual;
endmodule