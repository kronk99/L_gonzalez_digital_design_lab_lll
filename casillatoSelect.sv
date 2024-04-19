module casillatoSelect(input logic clk, rst, enable, signal,select_signal, output logic [4:0] result,
output logic isSelected); //isSelected es una señal para decir que registro escoge.
    reg [4:0] numActual = 5'b00001; // Inicialización de numActual
	 reg [4:0] seleccionado =5'b00000;
	 logic seleccionadoF =0;
    always_ff @(posedge clk) begin
        if (rst) begin
            numActual <= 5'b00001;
				seleccionado <=5'b00000;
        end else begin
            if (signal && enable) begin
                numActual <= numActual + 1;
                if (numActual > 5'b11001) begin
                    numActual <= 5'b00001;
                end
					 seleccionadoF <=0;
            end
				else begin
					if(select_signal && enable)begin
						seleccionado <=numActual;
						seleccionadoF <=1;
					end
				end
        end
    end
    assign result = seleccionado; // Asignación del resultado
	 assign isSelected =seleccionadoF;
	 
endmodule