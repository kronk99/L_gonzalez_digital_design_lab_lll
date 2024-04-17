module contador_barcos_select#(parameter numBarcos=5)(input logic clk,rst,enable,signal,output logic [2:0] result, 
output logic FSM_next_State);
	reg fsm_state=0;
	reg [3:0]contador_de_select = 3'b001; //al ser maximo 5 barcos
	always_ff @(posedge clk) begin
		if(rst)begin
			contador_de_select = 3'b001;
			fsm_state=0;
			
		end
		else begin
			if(signal && (contador_de_select < numBarcos) && enable)begin 
				contador_de_select+=3'b001;
			end
			if (contador_de_select ==numBarcos)begin
				fsm_state = 1; //aca pone el siguiente estado de la maquina de estados en 
				//su siguiente estado y deberia de setear los enables de los modulos en 0.
			end
		end
   end	
	assign result = contador_de_select;
	assign FSM_next_State = fsm_state;
endmodule 