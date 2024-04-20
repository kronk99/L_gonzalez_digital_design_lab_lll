module comparadorPerdidos(input logic [4:0] barcosperdidos , output logic Windcond );
	assign windcond = (barcosperdidos == 5'b11111) ? 1 : 0; //asigna la condicion de gane
end