module contador_select(input clk, rst,enable, button_signal , output logic [2:0] result ,output logic fsm );
	reg [2:0] numBarco; //me dice que numero 
	logic fsm_l
	always_ff @(posedge clk) begin
        if (rst) begin
            numBarco <= 3'b001; // Utiliza <= en lugar de <=
        end 
        else begin
            if (enable && button_signal) begin
                numBarco <= numBarco +1; // Utiliza $countones en lugar de bitcount
					 fsm <=0;
            end
				else if(numBarco > 5)begin
					fsm_l <=1;
				end
        end
    end
	 assign result =numBarco;
	 assign fsm = fsm_l
endmodule