//Registra donde esta la primera casilla del barco, y que tamano tiene. 
//Con esta informacion se puede predecir las casillas del barco

module registroB(input clk, rst, enable,input [2:0] tipo, input [4:0] casilla, output [4:0] barco, output [2:0] tipob);

logic [4:0] temporal ; //Para trabajar de manera interna con el arreglo
logic [2:0] tipo_s; //Almacena el tipo de barco

always @(posedge clk) begin
		if(rst) begin //El reset coloca la casilla en 0 (esto indica que el barco no esta colocado/esta muerto)
			for (int i = 0; i < 5; i++) begin
					temporal[i] <=0;
			 end
			 tipo_s = 3'b000;
		end
		
		else if (enable) begin //Si esta el enable, significa que se va a asignar un nuevo valor al registro.
			temporal = casilla;
			tipo_s = tipo;
		end
	end
	assign barco = temporal; //La salida se asigna al valor de la casilla
	assign tipob = tipo_s;
	
	
endmodule