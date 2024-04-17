module barcos_escogidos(input logic clk,rst,enable,input logic[2:0] num_barco ,
input logic [4:0] casilla_escogida, output logic [4:0] barco1,barco2,barco3,barco4,barco5,
output logic [2:0] tbarco1,tbarco2,tbarco3,tbarco4,tbarco5);

	reg [4:0] boat1=5'b00000;
	reg [4:0] boat2=5'b00000;
	reg [4:0] boat3=5'b00000;
	reg [4:0] boat4=5'b00000;
	reg [4:0] boat5=5'b00000;
	reg [2:0] Tboat1 = 3'b000;
	reg [2:0] Tboat2 = 3'b000;
	reg [2:0] Tboat3 = 3'b000;
	reg [2:0] Tboat4 = 3'b000;
	reg [2:0] Tboat5 = 3'b000;
	always_ff @(posedge clk) begin
		if(rst)begin
			boat1=5'b00000;
		   boat2=5'b00000;
			boat3=5'b00000;
			boat4=5'b00000;
			boat5=5'b00000;
			Tboat1 = 3'b000;
			Tboat2 = 3'b000;
			Tboat3 = 3'b000;
			Tboat4 = 3'b000;
			Tboat5 = 3'b000;
		end
		if(enable)begin
			case (num_barco)
				3'b001:begin
					boat1 <= casilla_escogida;
					Tboat1 <= num_barco;
				end
				3'b010:begin
					boat2 <= casilla_escogida;
					Tboat2 <= num_barco;
				end
				3'b011:begin
					boat3 <= casilla_escogida;
					Tboat3 <= num_barco;
				end
				3'b100:begin
					boat4 <= casilla_escogida;
					Tboat4 <= num_barco;
				end
				3'b101:begin
					boat5 <= casilla_escogida;
					Tboat5 <= num_barco;
				end
				default:begin
					boat1 <= casilla_escogida;
					Tboat1 <= num_barco;
				end
			endcase
		end
   end
	assign barco1= boat1;
	assign barco2= boat2;
	assign barco3= boat3;
	assign barco4= boat4;
	assign barco5= boat5;
	assign tbarco1 = Tboat1;
	assign tbarco2 = Tboat2;
	assign tbarco3 = Tboat3;
	assign tbarco4 = Tboat4;
	assign tbarco5 = Tboat5;
endmodule