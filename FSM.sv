module FSM(input Btn, rst, clk,T,V, VJ, VP,NBarcos, output Timer, Turno, output logic CJug[4:0], CPC[4:0], Barcos[2:0], Casilla[4:0]);

logic [2:0] state, next_state; //Necesito 3 bits porque son 6 estados

//Reset
always_ff @ (posedge clk or posedge rst)
	if (rst) state = 2'b00;
	else
		state = next_state;

//Logica del siguiente estado
always_comb
	case(state)
		3'b000: if (Btn) next_state = 3'b001; else next_state = 3'b000; //Estado de seleccion de # barcos
		3'b001: if (Btn) next_state = 3'b010; else if (T) next_state = 3'b100; else next_state = 3'b001; //Estado de turno de jugador
		3'b010: if (V) next_state = 3'b011; else next_state = 3'b001; //Estado comprobar casilla jugador
		3'b011: if (VJ) next_state=3'b111; else next_state = 3'b100; //Estado comprobar victoria jugador
		3'b100: next_state = 3'b101;//Estado turno PC
		3'b101: if (V) next_state = 3'b110; else next_state = 3'b100;//Estado comprobar casilla PC
		3'b110: if (VP) next_state = 3'b111; else next_state = 3'b001;//Estado comprobar victoria PC
		3'b111: next_state = 3'b111;//Fin del juego
		default: next_state = 3'b000;
	endcase

//output logic

assign Timer = (state == 3'b001);// El timer se hace 1 para indicar que se debe iniciar la cuenta de 15 segundos para el turno del jugador
assign Turno = (state == 3'b001); // Es 1 cuando es el turno del jugador, es 0 cuando es el turno de la PC
assign cont = (state == 2'b01); //este es para decirle al registro que cuente

assign sel_state = (state == 2'b11);//supongo que es el estado de error
//debo hacer uno para el mux, antes estaba en b11 , que es el estado 3
endmodule