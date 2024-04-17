
//El registro de casillas contiene las casillas que ya han sido utilizadas.
//Es como tal una matriz que corresponde al tablero
//Si hay un 1 la casilla fue disparada, 
module regCasillas(input logic clk, fila , columna, enable, reset, output logic valid);
	reg [4:0] matriz [4:0]; //crea la matriz del tablero
	logic casilla = 0;
	always @(posedge clk or posedge reset) begin
		if(reset) begin
          for (int i = 0; i < 5; i++) begin
				for (int j = 0; j < 5; j++) begin
					matriz [i][j] <=0;
				end
			 end
      end
      else if (enable) begin
			if (!matriz[fila][columna]) begin
			 casilla = 1;
          matriz [fila][columna] <=1;
			 end
			 else begin
			 casilla = 0;
			end
		end
	 end
	 assign valid = casilla;
endmodule