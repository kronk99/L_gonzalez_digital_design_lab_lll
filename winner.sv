module  	winner(input clk,  id, enable, output logic [2:0] matrix_player [0:4][0:4],
output logic [2:0] matrix_pc [0:4][0:4]);
  
logic [2:0] player [0:4][0:4];
logic [2:0] pc [0:4][0:4];

  always_ff @(posedge clk) begin
		if(enable)begin
			for(int i =0; i < 5; i++)begin
				case(id)
					// Case del 1 al 25
					0: begin
						pc  = '{'{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};
						player  = '{'{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};
					end
					1: begin
						pc  = '{'{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}};
						player  = '{'{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}};
					end
					2: begin
						pc  = '{'{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}, '{3, 3, 3, 3, 3}};
						player  = '{'{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}, '{2, 2, 2, 2, 2}};
					end
					
				endcase
			end
		end
		
	assign matrix_player = player;
	assign matrix_pc = pc;
endmodule