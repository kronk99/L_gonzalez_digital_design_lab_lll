//Este archivo es el que controla el juego como tal. Instancia los módulos e interpreta el input del usuario
/*
Btn es el boton de la FPGA
rst es el reset
clk clock
T es que han pasado 15 segundos
V es que la casilla a jugar es valida (disparo)
VJ es que el jugador ha ganado
VP es que la maquina ha ganado
NBarcos es la cantidad de barcos con los que jugar hace falta un modulo que lea input y dependiendo de
//los switches es 0 1 2 3 4 5, hagalo con el contador de unos.
RBarcos es que ya se han terminado de colocar los NBarcos*/
module Battleship(input logic clk, rst,boton,btn_select,btn_next);
	logic Tiempo; //cable para decirle a la FSM que pasaron o no 15 segundos
	logic inicioTiempo; //cable para hacer enable al contador de tiempo de 15 segundos
	logic turnoJugador; //este le dice al select de las casillas que se puede utilizar.
	logic cvalida; //este es para ver si la casilla es valida, se retroalimenta a la fsm;
	logic Ecom //bandera de estado de comprobacion del golpe, se activa cuando estoy en el estado de comprobacion de 
	//victoria, este estado es para comprobar si golpie a un enemigo o no.
	
	logic next //para mover la casilla
	logic select //para seleccionar la casilla , turno jugador
	//maquina de estados 
	logic [4:0] casilla; //casilla seleccionada;
	logic isSelected //bandera para decir que en el contador se selecciono dicha casilla
	
	logic [4:0] bAenemy[4:0] //me indica los barcos activos del enemigo , es decir 1101 0 1111 , y asi
	
	FSM maquinaEstado(.Btn(boton), .rst(rst), .clk(clk),.T(Tiempo),.V(cvalida), .VJ(), .VP(),.RBarcos(),
	.NBarcos(),//outputs
	.Timer(inicioTiempo), .Turno(turnoJugador), .TurnoPC(), .SBarcos(), .CBarcos(), .CVictoria(), .CDerrota(),.Ec(Ecom));
	
	//contador de tiempo de juego del jugador.
	regCiclos contadorCiclos(.clk(clk), // Señal de reloj
    .rst(rst), // Señal de reset,
	 .enable(inicioTiempo), //saber cuando colocarle el enable.
    .result(Tiempo));
	  //comparador de ciclos de relog
	  
	//PARA EL TURNO DEL JUGADOR:
	//selecciona una casilla o la cambia, es enable con el turno jugador de la FSM
	selectorCasillas(.enable(turnoJugador),.clk(clk),.button_select(btn_select),
	.button_next(btn_next) , .next(next) , .select(select));
	//para seleccionar la casilla
	casillatoSelect casillactual(.clk(clk), .rst(rst), .enable(turnoJugador), .signal(next), .select_signal(select) ,
	.result(casilla),.isSelected(isSelected)); //resultado es la casilla, del 1 al 25.
	//si el jugador presiona el boton select, entonces selecciono una casilla, luego de buscarla
	//esto produce, la casilla como tal, y una bandera o flag que dice selecionado, esto activa un enable
	//del comprobador casillas de abajo, para ver si es valida la casilla. isSelected es una bandera para
	//indicar que si se selecciono y que el validar de casillas se activa.
	regCasillas casillaValida(.clk(clk), .enable(isSelected), .reset(rst),.in(casilla), .valid(cvalida));
	
	//PARA COMPROBAR LA CASILLA DISPARADA(cASO VALIDO) PARA EL JUGADOR.
	registroBarcos#(5) barcoenemigos(.clk(clk), .rst(rst), .enable(Ecom),.setter(), .casilla(casilla),
	.barco1(), .tbarco1(),
	.barco2(), .tbarco2(),
	.barco3(), .tbarco3(),
	.barco4(), .tbarco4(),
	.barco5(), .tbarco5(), //Debe recibir de input las salidas de cada registroB
	.barcosout(bAenemy));//salida de barcos activos de la pc
	
	//colocarle aca el registro barcows perdidos, SOLICITAR CAMBIO, QUE EN VEZ DE DARME UN NUMERO DE N BITS, ME DE 0 O 1
	//PARA INDICAR SI TODOS FUERON DESTRUIDOS y colocarlo aca, de esta manera , el resultado es 0 o 1 e indica
	//si todos fueron destruidos, el jugador ganó , si no , turno del jugador
	
	//falta incluir el 7 segmentos y los 4 modulos faltantes.
	
endmodule