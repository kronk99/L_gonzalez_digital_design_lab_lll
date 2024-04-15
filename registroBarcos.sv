
//Hace falta settear los valores de los barcos 
module registroBarcos#(parameter numBarcos=5)(input logic clk, rst,setter,output reg [4:0] barcos [4:0]);
//que reciba un numero y que en base a ese numero haga una busqueda en todos los registros
//para ver si la casilla existe, los registros guarda
//el numero de casilla , por ejemplo 23, si la casilla existe en los registros, entonces
//la coloca en 0
//output una lista de 5 bits, 00000 , implica que ningun barco esta muerto
//cada bit corresponde a cada barco, bit menos significativo implica barco mas pequeño
//bit más significativo, considerando que no son 5 barcos siempre, utilizar un numero
//y en base a ese numero llenar los registros con 0, para implicar que esos barcos no juegan
//o no se utilizan  
	//reg [4:0] barcos [4:0]; //registro de barcos 
	always @(posedge clk) begin
		if(rst) begin
			for (int i = 0; i < numBarcos; i++) begin
				for (int j = 0; j < 5; j++) begin
					barcos [i][j] <=0;
				end
			 end
		end
		else begin
			for (int i = 0; i < numBarcos; i++) begin //coomo es variable , se compara con el numero
			//de barcos seteados a jugar para buscar, si solo hay un barco no tiene gracia buscar en toda la matriz
				for (int j = 0; j < 5; j++) begin
					if (barcos [i][j]==setter) begin //si en la matriz se encuentra el numero , lo setea en 0
						barcos[i][j] <= 0; // asigna los valores a 0, busca la casilla 26 que fue golpeada
						//y lo cambia aca en 0
					end
				end
			 end
		end
	end
endmodule