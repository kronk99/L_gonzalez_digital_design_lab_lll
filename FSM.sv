module FSM(input Btn, rst, clk,T,V, VJ, VP,RBarcos, input logic [2:0] NBarcos, output Timer, Turno, TurnoPC, SBarcos, CBarcos, CVictoria, CDerrota, Ec,Ecp);

/*

ENTRADAS

Btn es el boton de la FPGA
rst es el reset
clk clock
T es que han pasado 15 segundos
V es que la casilla a jugar es valida (disparo)
VJ es que el jugador ha ganado
VP es que la maquina ha ganado
NBarcos es la cantidad de barcos con los que jugar
RBarcos es que ya se han terminado de colocar los NBarcos


SALIDAS

Timer es la senal para que el timer cuente
Turno es 1 para jugador
TurnoPC es 1 para PC
SBarcos es 1 cuando estoy eligiendo la cantidad de barcos (enable del registro)
CBarcos es 1 cuando se estan colocando barcos (enable del registro)
CVictoria es 1 cuando se quiere comprobar victoria del jugador
CDerrota es 1 cuando se quiere comprobar derrota del jugador 
EC //estado de comprobacion de victoria, implica habilitar registro barcos para 
//verificar si hubo un golpe en un barco, el resultado  1111 , o 10111 
se introduce a registro barcos perdidos, ese registro me indica si el jugador gana o no.
*/

logic [3:0] state, next_state; //Necesito 3 bits porque son 6 estados

//Reset
always_ff @ (posedge clk or posedge rst)
	if (rst) state = 4'b0000;
	else
		state = next_state;

//Logica del siguiente estado
always_comb
	case(state)
		4'b0000: if (Btn) next_state = 4'b1000; else next_state = 4'b0000; //Estado de seleccion de # barcos
		4'b1000: if (RBarcos) next_state = 4'b0001; else next_state = 4'b0001; //Estado de colocar los barcos del jugador
		4'b0001: if (Btn) next_state = 4'b0010; else if (T) next_state = 4'b0100; else next_state = 4'b0001; //Estado de turno de jugador
		4'b0010: if (V) next_state = 4'b0011; else next_state = 4'b0001; //Estado comprobar casilla jugador
		4'b0011: if (VJ) next_state=4'b0111; else next_state = 4'b0100; //Estado comprobar victoria jugador
		4'b0100: next_state = 4'b0101;//Estado turno PC
		4'b0101: if (V) next_state = 4'b0110; else next_state = 4'b0100;//Estado comprobar casilla PC
		4'b0110: if (VP) next_state = 4'b0111; else next_state = 4'b0001;//Estado comprobar victoria PC
		4'b0111: next_state = 4'b0111;//Fin del juego
		default: next_state = 4'b0000;
	endcase

//output logic

assign Timer = (state == 4'b0001);// El timer se hace 1 para indicar que se debe iniciar la cuenta de 15 segundos para el turno del jugador
assign Turno = (state == 4'b0001); // Es 1 cuando es el turno del jugador
assign TurnoPC = (state == 4'b0100); //Turno de la PC
assign SBarcos = (state == 4'b0000); 
assign CBarcos = (state == 4'b1000); 
assign CVictoria = (state == 4'b0011); 
assign CDerrota = (state == 4'b0110); 
assign Ec = (state == 4'b0011); //estado de comprobacion de victoria jugador
assign Ecp=(state == 4'b0110); //estado comprobacion de victoria pc;
endmodule