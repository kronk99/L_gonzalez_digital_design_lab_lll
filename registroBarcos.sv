/*
Recibe un numero, este numero indica la casilla donde se jugo
La casilla se va a buscar en cada registroB, tomando en cuenta el tamano del barco para hacer la prediccion de casillas
Si la casilla jugada corresponde a donde deberia de estar un barco, se modifica la matriz para mostrar ese golpe
El modulo registroBarcosperdidos se encargara de interpretar esos golpes, y, si es el caso, interpretar al barco como caido

Ejemplo de matriz de salida:

[00001]
[00011]
[00111]
[01011]
[11100]

Primer, segundo y tercer barcos estan intactos
Cuarto barco tiene un golpe en su tercera casilla
Quinto barco tiene dos golpes en su casilla 0 y 1

Recordando que el registroB solamente almacena la casilla que corresponde al bit mas significativo
Las casillas que estan golpeadas en el ejemplo no aparecen en registroB, se sabe que pertenecen a esos barcos
por prediccion y por el tamano del barco

*/

//Setter corresponde a la casilla 
module registroBarcos#(parameter numBarcos=5)(

input logic clk, rst, enable,setter, input [4:0] casilla,
input [4:0] barco1, input [2:0] tbarco1,
input [4:0] barco2, input [2:0] tbarco2,
input [4:0] barco3, input [2:0] tbarco3,
input [4:0] barco4, input [2:0] tbarco4,
input [4:0] barco5, input [2:0] tbarco5, //Debe recibir de input las salidas de cada registroB
output logic [4:0] barcosout [4:0]);

logic [4:0] barcos [4:0];


	always @(posedge clk) begin //Se ejecuta cada ciclo de reloj
		if(rst) begin
			for (int i = 0; i < numBarcos; i++) begin
				for (int j = 0; j < 5; j++) begin
					barcos [i][j] <=0; //El reset coloca todos los barcos en 0. Esto se interpreta como todos los barcos muertos
				end
			 end
		end
		else if (setter) begin //Variable que indica que se deben settear los barcos, proviene de FSM
			for (int i = 0; i < numBarcos; i++) begin
                for (int j = 0; j <= i; j++) begin
                    barcos[i][j] = 1;
                end
                for (int j = i+1; j < 5; j++) begin
                    barcos[i][j] = 0;
                end
            end
            for (int i = numBarcos; i < 5; i++) begin
                for (int j = 0; j < 5; j++) begin
                    barcos[i][j] = 0;
                end
            end
			
		end
		else if (enable) begin //Indica que se habilita la edicion de la matriz de salida, por lo que se debe comprobar si el golpe pertenece a un barco
			for(int i = 0; i < tbarco1; i++) begin
				if(casilla == (barco1 - i) && i < 5) begin
				barcos[0][i] = 0; //Golpe en el barco 1
				end
			end
			for(int i = 0; i < tbarco2; i++) begin
				if(casilla == (barco2 - i) && i < 5) begin
				barcos[1][i] = 0; //Golpe en el barco 2
				end
			end
			for(int i = 0; i < tbarco3; i++) begin
				if(casilla == (barco3 - i) && i < 5) begin
				barcos[2][i] = 0; //Golpe en el barco 3
				end
			end
			for(int i = 0; i < tbarco4; i++) begin
				if(casilla == (barco4 - i) && i < 5) begin
				barcos[3][i] = 0; //Golpe en el barco 4
				end
			end
			for(int i = 0; i < tbarco5; i++) begin
				if(casilla == (barco5 - i) && i < 5) begin
				barcos[4][i] = 0; //Golpe en el barco 5
				end
			end
			
	
		end
	end
	assign barcosout = barcos;
endmodule