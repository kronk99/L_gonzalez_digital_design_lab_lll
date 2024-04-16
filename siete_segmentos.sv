module siete_segmentos(input logic clk, input logic [4:0] barcos , output logic [6:0] segmentos); //logica provisional para los 7 segmentos
	always_ff @(posedge clk) begin//creo que le falta un reset
	//puede ser en cualquier orden que esten apagados, tomar eso en cuenta puede que el barco 4 fue 
	//destruido y el barco 1 tambien, que da : 10110 , me quedan 3 barcos, pero tambien puedo destruir
	//el 3 y el 2 e igual tengo 3 barcos restantes : 11001 , entonces cambiar esto en logica o utilizar
	//la logica de aca , aca de momento quick fix usa la funcion countones , que me devuelve el numero 
	//de 1s
		case (countones(barcos))
			5: segmentos = 7'b0100100; //caso 5 barcos en registro , el menos significativo es el 6
		//mas significativo es el 0, considere que con 1 se apaga la señal en la fpga
			4: segmentos = 7'b1001100; //caso 4 baros en registro
			3: segmentos = 7'b0000110;//caso 3
			2: segmentos = 7'b0100100;//caso 2
			1: segmentos = 7'b1001111;//casp 1
			default: segmentos = 7'b0000001; //caso 0, no hay barcos.
		endcase
	end	
endmodule