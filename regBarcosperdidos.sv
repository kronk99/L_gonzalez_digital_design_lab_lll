module regBarcosperdidos#(parameter numBarcos=5)(input logic clk, rst, enable,input logic [4:0] barcos [4:0]
,output logic [4:0] result); //me da 11111 si los barcos murieron.
//logica: cada fila de la matriz representa un barco, entonces el busca si en la fila N, todas sus columnas son 0
// es decir barco 1 = 00000, si es asi, entonces indica que el barco esta destruido
	reg [4:0] boatcount = 5'b00000; 
	always_ff @(posedge clk or posedge rst)
    begin
        if (rst) begin
            boatcount = 5'b00000; // Reset value
        end
        else if (enable) begin //pone la variable de busqueda para comparar al valor actual del contador
				for (int j=0 ; j < numBarcos; j++) begin
					if (!barcos[j]) begin
						boatcount[j]<=0; //la idea es que solo agregue 1s cuando las filas de las matrices 
					end
					else begin
						boatcount[j] <= 1;
						end
				end
        end
    end
    // Output the count value
    assign result = boatcount;
endmodule