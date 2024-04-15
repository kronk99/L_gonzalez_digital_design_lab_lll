module regBarcosperdidos#(parameter numeroBarcos=5)(input logic clk, rst,input logic [4:0] barcos [4:0]
,output logic [4:0] result);
//logica: cada fila de la matriz representa un barco, entonces el busca si en la fila N, todas sus columnas son 0
// es decir barco 1 = 00000, si es asi, entonces indica que el barco esta destruido
	reg [4:0] boatcount = 5'b0;
	always_ff @(posedge clk or posedge rst)
    begin
        if (reset) begin
            boatcount <= 0; // Reset value
        end
        else begin//si la cuenta es distinta al numero maximo de barcos //pone la variable de busqueda para comparar al valor actual del contador
				for (int j=0 ; j < numBarcos; j++) begin
					if (!|matriz[j]) begin
						boatcount[j]<=1; //la idea es que solo agregue 1s cuando las filas de las matrices 
					//del barco especifico	sean 0, barco 1 =fila 1, barco2=fila2,barco3=fila3
						//recuerde, son 5 baros maximo, entonces cuando encuentra un barcodestruido, lo suma
						//y en el siguiente ciclo de relog, inicia la busqueda en la fija j , donde j es el numero
						//de barcos destruidos , por tanto, si se destruyó
						//produciria un resultado tipo 01010 , el menos significativo indica la destruccion del barco1
						//del barco 2 y asi sucesivamente.
					end
				end
        end
    end
    // Output the count value
    assign result = boatcount;
endmodule