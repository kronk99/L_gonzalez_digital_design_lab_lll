//No se va a utilizar, se incluye directamente en el registro de ciclos

module comparadorSegundos(input logic [4:0] num1 , output logic result);
	 assign result = (num1 == 4'b1111) ? 1 : 0; //si los segundos son 15, retorna true
endmodule
	
