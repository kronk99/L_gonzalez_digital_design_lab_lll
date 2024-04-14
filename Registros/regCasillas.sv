module regCasillas(input logic clk ,rst , fila , columna, output reg resultado[4:0][4:0]);
	reg [4:0] matriz [4:0]; //crea la matriz del jugador
	//lo que va a hacer es poner en 1 las casillas que ya utilizo, si es 1 entonces no puede
	//atacar o interactuar con dicha casilla.
	//cambiar entre 0 1 y 2 , para lo que es la vga, donde por ejemplo el 0 represente casilla no disparada
	//1 represente casilla disparada que no es barco, 2 represente casilla disparada que es barco
	//y sus respectivos colores
	always @(posedge clk or posedge reset) begin
		if(reset) begin
          for (int i = 0; i < 6; i++) begin
				for (int j = 0; j < 6; j++) begin
					matriz [i][j] <=0;
				end
			 end
      end
      else begin
          matriz [fila][columna] <=1;
      end
    end
endmodule