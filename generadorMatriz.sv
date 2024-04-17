module generadorMatriz #(parameter ancho = 4'd5) (
	input [0:9] x,                                    // Entrada de coordenada x
	input [0:9] y,                                    // Entrada de coordenada y
	input reg [1:0] matrix_player [0:4][0:4],         // Matriz 10x5 del jugador
	input reg [1:0] matrix_pc [0:4][0:4],             // Matriz 10x5 de la PC
	output logic [7:0] red,                           // Salida del componente rojo
	output logic [7:0] green,                         // Salida del componente verde
	output logic [7:0] blue                           // Salida del componente azul
);

	logic blanco;                                     // Variable para indicar blanco
	logic azul;                                       // Variable para indicar azul
	logic rojo;                                       // Variable para indicar rojo
	logic verde;                                      // Variable para indicar verde
	logic negro;                                      // Variable para indicar negro
	logic gano;                                       // Variable para indicar si se ha ganado
	logic [0:9] stepx;                                // Paso en la dirección x
	logic [0:9] stepy;                                // Paso en la dirección y
	logic [0:9] x0;                                   // Posición inicial en x
	logic [0:9] y0;                                   // Posición inicial en y
	logic [0:9] i;                                    // Iterador para filas
	logic [0:9] j;                                    // Iterador para columnas
	logic [0:4] ajuste_x;                             // Ajuste en la dirección x
	logic [0:4] ajuste_y;                             // Ajuste en la dirección y

	// Proceso combinacional para determinar el color de cada píxel
	always_comb begin
		negro = 0;                                    // Inicializar negro a 0
		blanco = 0;                                   // Inicializar blanco a 0
		azul = 0;                                     // Inicializar azul a 0
		rojo = 0;                                     // Inicializar rojo a 0
		verde = 0;                                    // Inicializar verde a 0
		gano = 0;                                     // Inicializar gano a 0

		i = 0;                                        // Inicializar el iterador i a 0
		j = 0;                                        // Inicializar el iterador j a 0

		stepx = (10'd640 - ancho) / 10'd10;           // Calcular el paso en x
		stepy = (10'd480 - ancho) / 10'd5;            // Calcular el paso en y
		x0 = stepx / 10'd2 + ancho / 10'd2;           // Calcular la posición inicial en x
		y0 = stepy / 5'd2 + ancho / 10'd2;            // Calcular la posición inicial en y

		ajuste_x = 30;                                // Establecer el ajuste en x
		ajuste_y = 29;                                // Establecer el ajuste en y

		// Comprobar si se ha ganado para determinar el siguiente paso
		if (gano) begin 
			caso_turno_player();                      // Llamar a la función correspondiente
		end else begin
			// Iterar sobre las filas
			for (i = 0; i < 10; i = i + 1) begin       // Iterar sobre las 10 filas
				x0 = stepx / 10'd2 + ancho / 10'd2;   // Actualizar la posición inicial en x
				// Iterar sobre las columnas
				for (j = 0; j < 10; j = j + 1) begin   // Iterar sobre las 10 columnas
					x0 = x0 + (j == 5 ? 5 : 0);        // Ajustar la posición inicial en x
					// Comprobar si el punto actual está dentro de un área específica
					if (((x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + stepy / 2 + ancho / 2 > y0 && y + stepy / 2 < y0 + ancho / 2) 
						|| (x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + ancho / 2 > y0 + stepy / 2 && y < y0 + stepy / 2 + ancho / 2) 
						|| (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x + stepx / 2 + ancho / 2 > x0 && x + stepx / 2 < x0 + ancho / 2) 
						|| (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x > x0 - ancho / 2 + stepx / 2 && x < x0 + stepx / 2 + ancho / 2)) && (j < 5)) begin
						negro = 1;                        // Establecer negro a 1 si el punto está dentro del área
					end else if (((x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + stepy / 2 + ancho / 2 > y0 && y + stepy / 2 < y0 + ancho / 2) 
						|| (x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + ancho / 2 > y0 + stepy / 2 && y < y0 + stepy / 2 + ancho / 2) 
						|| (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x + stepx / 2 + ancho / 2 > x0 && x + stepx / 2 < x0 + ancho / 2) 
						|| (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x > x0 - ancho / 2 + stepx / 2 && x < x0 + stepx / 2 + ancho / 2)) && (j >= 5)) begin
						negro = 1;                        // Establecer negro a 1 si el punto está dentro del área
					end 
					x0 = x0 + stepx;                     // Avanzar en la dirección x
				end
				y0 = y0 + stepy;                        // Avanzar en la dirección y
			end

			// Iterar sobre las filas
			for (i = 0; i < 5; i = i + 1) begin           // Iterar sobre las 5 filas
				x0 = stepx / 10'd2 + ancho / 10'd2;       // Actualizar la posición inicial en x
				// Iterar sobre las columnas
				for (j = 0; j < 5; j = j + 1) begin       // Iterar sobre las 5 columnas
					// Llamar a la función correspondiente basada en los valores de las matrices
					if (matrix_player[i][j] == 2'd1) begin
						caso_destruido_player();
					end else if (matrix_player[i][j] == 2'd2) begin
						caso_fallo_player();
					end else if (matrix_player[i][j] == 2'd3) begin
						caso_barco();
					end
					if (matrix_pc[i][j] == 2'd1) begin 
						caso_seleccionado();
					end else if (matrix_pc[i][j] == 2'd2) begin 
						caso_destruido_pc();
					end else if (matrix_pc[i][j] == 2'd3) begin 
						caso_fallo_pc();
					end 
					x0 = x0 + stepx;                        // Avanzar en la dirección x
				end
				y0 = y0 + stepy;                           // Avanzar en la dirección y
			end
		end

		// Determinar el color de salida basado en las variables de estado
		if (blanco) begin
			red = 8'b11111111;
			green = 8'b11111111;
			blue = 8'b11111111; 
		end else if (negro) begin 
			red = 8'b00000000;
			green = 8'b00000000;
			blue = 8'b00000000;
		end else if (rojo) begin 
			red = 8'b11111111;
			green = 8'b00000000;
			blue = 8'b00000000;
		end else if (verde) begin 
			red = 8'b00000000;
			green = 8'b11111111;
			blue = 8'b00000000;
		end else begin
			red = 8'b00000000;
			green = 8'b00000000;
			blue = 8'b11111111;
		end 
	end

	// Función para manejar el caso destruido del jugador
	function void caso_destruido_player();
		if (x >= x0 - ajuste_x && x < x0 - ajuste_x + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
			rojo = 1;                                // Establecer rojo a 1 si se cumple la condición
		end 
	endfunction

	// Función para manejar el caso de fallo del jugador
	function void caso_fallo_player();
		if (x >= x0 - ajuste_x && x < x0 - ajuste_x + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
			verde = 1;                               // Establecer verde a 1 si se cumple la condición
		end 
	endfunction

	// Función para manejar el caso seleccionado
	function void caso_seleccionado();
		if (x >= x0 - ajuste_x + 320 && x < x0 - ajuste_x + 317 + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
			blanco = 1;                              // Establecer blanco a 1 si se cumple la condición
		end 
	endfunction

	// Función para manejar el caso destruido de la PC
	function void caso_destruido_pc();
		if (x >= x0 - ajuste_x + 320 && x < x0 - ajuste_x + 317 + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
			rojo = 1;                                // Establecer rojo a 1 si se cumple la condición
		end 
	endfunction

	// Función para manejar el caso de fallo de la PC
	function void caso_fallo_pc();
		if (x >= x0 - ajuste_x + 320 && x < x0 - ajuste_x + 320 + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
			verde = 1;                               // Establecer verde a 1 si se cumple la condición
		end
	endfunction

	// Función para manejar el caso de barco
	function void caso_barco();
		if (x >= x0 - ajuste_x && x < x0 - ajuste_x + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
			azul = 1;                                // Establecer azul a 1 si se cumple la condición
		end 
	endfunction

endmodule
