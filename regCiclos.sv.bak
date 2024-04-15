module regCiclos(
    input logic clk, // Señal de reloj
    input logic rst, // Señal de reset,
    output reg [3:0] result // Salida del contador
);
	 
    logic [3:0] counter_value; //cable local

    // Bloque always_ff para la lógica del contador
    always_ff @(posedge clk) begin
        if (rst) begin //si el reset es 1, ponga el contador en cero
            counter_value <= 4'b00000; // Valor de reset
        end else begin
            if (counter_value != 4'b11111) begin
                counter_value <= counter_value + 1; // Incrementa en cada flanco de reloj
            end
        end
    end
    
    // Asigna el valor del contador a la salida
    assign result = counter_value;
endmodule