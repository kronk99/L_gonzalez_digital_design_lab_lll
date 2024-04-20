module Battleship(input logic clk, rst ,button, output logic [7:0] red, green, blue, output logic vgaclock, hsync, vsync, n_blank);

	logic nextResult;
	logic selecResult;
	logic [4:0] resultado;
	logic [2:0] resultSelec;
	logic FSM;
	logic [4:0] barco1,barco2,barco3,barco4,barco5;
	logic [2:0] tbarco1,tbarco2,tbarco3,tbarco4,tbarco5;
	logic [2:0] matrix_player [4:0][4:0];
	logic [2:0] matrix_pc [4:0][4:0];
	logic nextButton;
	winner winner_inst (
    .clk(clk),                           // Entrada: Reloj
    .id(buton),                             // Entrada: Identificador
    .enable(1),                     // Entrada: Habilitador
    .matrix_player(matrix_player),       // Salida: Matriz del jugador
    .matrix_pc(matrix_pc)                // Salida: Matriz de la PC
);
	controlador_vga miControladorVGA(.clock(clk), .reset(rst), .matrix_player(matrix_player), .red(red), .green(green), .blue(blue), .vgaclock(vgaclock),
	.hsync(hsync), .vsync(vsync), .n_blank(n_blank));
	
	

endmodule