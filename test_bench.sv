module test_bench;
	parameter CLOCK_PERIOD = 10; // Clock
	parameter Nbarcos = 4;
	logic clock = 0;
	logic rst = 0;
	logic fsm;
	logic next;
	logic select;
	logic enable=1;
	logic after_next;
	logic after_select;
	logic [4:0] result,barcos1,barcos2,barcos3,barcos4,barcos5;
	logic [2:0] tipobarco ,boats1,boats2,boats3,boats4,boats5;
	
	Selector miselector(.enable(enable),.clk(clock),
	.button_select(select) ,.button_next(next) , .next(after_next) , .select(after_select));
	
	contador micontador(.clk(clock),.rst(rst),.enable(enable),.signal(after_next),.result(result));
	
	contador_barcos_select #(4) miselect(.clk(clock),.rst(rst),.enable(enable),.signal(after_select),
		.result(tipobarco), .FSM_next_State(fsm));
	 
	barcos_escogidos misbarcos(.clk(clock),.enable(enable),.num_barco(tipobarco),
		.casilla_escogida(result), .barco1(barcos1),.barco2(barcos2),.barco3(barcos3),.barco4(barcos4),.barco5(barcos5),
		.tbarco1(boats1),.tbarco2(boats2),.tbarco3(boats3),.tbarco4(boats4),.tbarco5(boats5));
	always #CLOCK_PERIOD clock = ~clock;
	initial begin
  
		//ADDER tests
		 select = 0; //ADDER
		 next= 1;
       #10; // Wait for 10 time units
		 select = 0; //ADDER
		 next= 1;
       #10; // Wait for 10 time units
		 select = 0; //ADDER
		 next= 1;
       #10; // Wait for 10 time units
		 select = 1; //ADDER
		 next= 0;
       #10; // Wait for 10 time units
		 select = 0; //ADDER
		 next= 1;
       #10; // Wait for 10 time units
		 select = 0; //ADDER
		 next= 1;
       #10; // Wait for 10 time units
		 select = 0; //ADDER
		 next= 1;
       #10; // Wait for 10 time units
		  select = 1; //ADDER
		 next= 0;
       #10; // Wait for 10 time units
		 
		 $finish;
	end
endmodule