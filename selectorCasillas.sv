module SelectorCasillas(input logic enable,clk,button_select ,button_next , output logic next , select);
//consultar si esto ocupa un clock o no
	reg nextO=1'b0;
	reg selectO=1'b0;
	always_ff @(posedge clk) begin
		if(enable)begin
			if(button_next || button_select)begin
				nextO <= button_next; //consultar si el boton asigna 1 o asigna 0 en la fpga
				selectO <= button_select;
			end
			else begin
				nextO <= 0;
				selectO <= 0;
			end
		end
   end
	assign next=nextO;
	assign select=selectO;
endmodule