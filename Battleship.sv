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
module Battleship(input logic [4:0] switches,input logic clk, rst,boton,btn_select,btn_next);
	logic Tiempo; //cable para decirle a la FSM que pasaron o no 15 segundos
	logic inicioTiempo; //cable para hacer enable al contador de tiempo de 15 segundos
	logic turnoJugador; //este le dice al select de las casillas que se puede utilizar.
	logic cbarcos;
	logic cvalida; //este es para ver si la casilla es valida, se retroalimenta a la fsm;
	logic Ecom //bandera de estado de comprobacion del golpe, se activa cuando estoy en el estado de comprobacion de 
	//victoria, este estado es para comprobar si golpie a un enemigo o no.
	logic Ecp; //bandera de enable para comprobar el estado de victoria del pc;
	logic victoriaJugador;
	logic victoriaPC;
	logic next //para mover la casilla
	logic select //para seleccionar la casilla , turno jugador
	//maquina de estados 
	logic [4:0] casilla; //casilla seleccionada;
	logic isSelected //bandera para decir que en el contador se selecciono dicha casilla
	
	logic [4:0] bAenemy[4:0] //me indica los barcos activos del enemigo , es decir 1101 0 1111 , y asi
	logic [4:0] LBenemy; //me indica los barcos perdidos de enemy.
	
	logic Sbarco;
	logic [2:0] numeroBarcos;
	logic [4:0] bJugador;
	logic [4:0] LJugador;
	logic cBarcos;
	//para colocar los barcos***
	logic [4:0] casillaescogida;
	logic [2:0] tipoBarco; ***
	//end colocar barcos
	//
	//los inputs de los registros a los barcos: 
	logic [4:0] barco1;
	logic [4:0] barco2;
	logic [4:0] barco3;
	logic [4:0] barco4;
	logic [4:0] barco5;
	//los outputs de los registros de los barcos
	logic [4:0] barco1_s;
	logic [4:0] barco2_s;
	logic [4:0] barco3_s;
	logic [4:0] barco4_s;
	logic [4:0] barco5_s;
	//los tipós de barcos 
	logic [2:0] Tbarco1_s;
	logic [2:0] Tbarco2_s;
	logic [2:0] Tbarco3_s;
	logic [2:0] Tbarco4_s;
	logic [2:0] Tbarco5_s;
	logic barcosRegistrados;
	
	FSM maquinaEstado(.Btn(boton), .rst(rst), .clk(clk),.T(Tiempo),.V(cvalida), .VJ(victoriaJugador), .VP(victoriaPC),.RBarcos(barcosRegistrados),
	.NBarcos(),//outputs
	.Timer(inicioTiempo), .Turno(turnoJugador), .TurnoPC(), .SBarcos(Sbarco), .CBarcos(cBarcos), .CVictoria(), .CDerrota(),.Ec(Ecom),.Ecp(Ecp));
	//REGISTROS DE BARCOS
	
	//PARA SETEAR LOS BARCOS CON SWITCHES:
	setearBarcos barcostoset(.clk(clk),.enable(Sbarco),.rst(rst),.numeroBarcos(switches),.numeroB(numeroBarcos));
	//contador de tiempo de juego del jugador.
	regCiclos contadorCiclos(.clk(clk), // Señal de reloj
    .rst(rst), // Señal de reset,
	 .enable(inicioTiempo), //saber cuando colocarle el enable.
    .result(Tiempo));
	  //comparador de ciclos de relog
	 //PARA COLOCAR LOS BARCOS://*****************************
	 contador_casillas contador_inst ( //modulo para mover la casilla
    .clk(clk),       // Entrada: Reloj
    .rst(rst),       // Entrada: Señal de reinicio
    .enable(cBarcos), // Entrada: Habilitador
    .signal(btn_next), // Entrada: Señal de activación
    .result(casillaescogida)  // Salida: Resultado del contador
	 );
	 contador_select select_inst (
    .clk(clk),             // Entrada: Reloj
    .rst(rst),             // Entrada: Señal de reinicio
    .enable(cBarcos),       // Entrada: Habilitador
    .button_signal(btn_select), // Entrada: Señal de botón
    .result(tipoBarco),
	 .fsm(barcosRegistrados)// Salida: Resultado del contador
	 );
	 asignarRegistros asignar_inst (
    .clk(clk),          // Entrada: Reloj
    .rst(rst),          // Entrada: Señal de reinicio
    .enable(cBarcos),    // Entrada: Habilitador
    .select(tipoBarco),    // Entrada: Selección
    .next(casillaescogida),        // Entrada: Siguiente valor
    .barco1(barco1),    // Salida: Barco 1
    .barco2(barco2),    // Salida: Barco 2
    .barco3(barco3),    // Salida: Barco 3
    .barco4(barco4),    // Salida: Barco 4
    .barco5(barco5)     // Salida: Barco 5
	 );
	 registroB barco1 (
    .clk(clk),          // Entrada: Reloj
    .rst(rst),          // Entrada: Señal de reinicio
    .enable(cBarcos),    // Entrada: Habilitador
    .tipo(3'b001),        // Entrada: Tipo de barco
    .casilla(barco1),  // Entrada: Casilla
    .barco(barco1_s),      // Salida: Valor de la casilla
    .tipob(Tbarco1_s)       // Salida: Tipo de barco
	 );	 
	 registroB barco2(
    .clk(clk),          // Entrada: Reloj
    .rst(rst),          // Entrada: Señal de reinicio
    .enable(cBarcos),    // Entrada: Habilitador
    .tipo(3'b010),        // Entrada: Tipo de barco
    .casilla(barco2),  // Entrada: Casilla
    .barco(barco2_s),      // Salida: Valor de la casilla
    .tipob(Tbarco2_s)       // Salida: Tipo de barco
	 );
	 registroB barco3(
    .clk(clk),          // Entrada: Reloj
    .rst(rst),          // Entrada: Señal de reinicio
    .enable(cBarcos),    // Entrada: Habilitador
    .tipo(3'b011),        // Entrada: Tipo de barco
    .casilla(barco3),  // Entrada: Casilla
    .barco(barco3_s),      // Salida: Valor de la casilla
    .tipob(Tbarco3_s)       // Salida: Tipo de barco
	 );
	 registroB barco4 (
    .clk(clk),          // Entrada: Reloj
    .rst(rst),          // Entrada: Señal de reinicio
    .enable(cBarcos),    // Entrada: Habilitador
    .tipo(3'b100),        // Entrada: Tipo de barco
    .casilla(barco4),  // Entrada: Casilla
    .barco(barco4_s),      // Salida: Valor de la casilla
    .tipob(Tbarco4_s)       // Salida: Tipo de barco
	 );
	 registroB barco5 (
    .clk(clk),          // Entrada: Reloj
    .rst(rst),          // Entrada: Señal de reinicio
    .enable(cBarcos),    // Entrada: Habilitador
    .tipo(3'b101),        // Entrada: Tipo de barco
    .casilla(barco5),  // Entrada: Casilla
    .barco(barco5_s),      // Salida: Valor de la casilla
    .tipob(Tbarco5_s)       // Salida: Tipo de barco
	 );	 
	 //******************************
	//PARA EL TURNO DEL JUGADOR:
	//selecciona una casilla o la cambia, es enable con el turno jugador de la FSM
	//para seleccionar la casilla
	
	casillatoSelect casillactual(.clk(clk), .rst(rst), .enable(turnoJugador), .signal(next), .select_signal(select) ,
	.result(casilla),.isSelected(isSelected)); //resultado es la casilla, del 1 al 25.
	//si el jugador presiona el boton select, entonces selecciono una casilla, luego de buscarla
	//esto produce, la casilla como tal, y una bandera o flag que dice selecionado, esto activa un enable
	//del comprobador casillas de abajo, para ver si es valida la casilla. isSelected es una bandera para
	//indicar que si se selecciono y que el validar de casillas se activa.
	regCasillas casillaValida(.clk(clk), .enable(isSelected), .reset(rst),.in(casilla), .valid(cvalida));
	
	//PARA COMPROBAR LA CASILLA DISPARADA(cASO VALIDO) PARA EL JUGADOR.
	registroBarcos#(5) barcoenemigos(.clk(clk), .rst(rst), .enable(Ecom),.setter(Cbarcos), .casilla(casilla),
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
	regBarcosperdidos#(5) enemigosperdidos(.clk(clk), .rst(rst) , .enable(Ecom),.barcos(bAenemy),.result(Lenemy));
	comparadorPerdidos enemigoPerdido(.barcosPerdidos(Lenemy) , .windcon(victoriaJugador));
	
	//PARA LOS ENEMIGOS cuando es el turno del enemigo. 
	//necesita un seleccionador random de casilla y un setter, eso se lo manda a registro casillas para ver si es valida
	//si es valida se lo manda acá
	registroBarcos#(5) barcosAliados(.clk(clk), .rst(rst), .enable(Ecp),.setter(Cbarcos), .casilla(casilla),
	.barco1(), .tbarco1(),
	.barco2(), .tbarco2(),
	.barco3(), .tbarco3(),
	.barco4(), .tbarco4(),
	.barco5(), .tbarco5(), //Debe recibir de input las salidas de cada registroB
	.barcosout(bJugador));
	regBarcosperdidos#(5) enemigosperdidos(.clk(clk), .rst(rst) , .enable(Ecom),.barcos(bJugador),.result(Ljugador));
	//CASILLA Y CBARCOS NO HAN CAMBIADO, SE NECESITA CAMBIAR , CASILLA ES LA CASILLA QUE ESCOGE EL ENEMIGO PARA 
	//DISPARAR
	comparadorPerdidos jugadorPerdido(.barcosPerdidos(Ljugador) , .windcon(victoriaPC));
endmodule