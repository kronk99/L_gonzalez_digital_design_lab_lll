module Selector(input logic enable,clk,button_select ,button_next , output logic next , select);
//consultar si esto ocupa un clock o no
	reg nextO=0;
	reg selectO=0;
	always_ff @(posedge clk) begin
		if(enable)begin
			if(button_next || button_select)begin
				nextO <= button_next;
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