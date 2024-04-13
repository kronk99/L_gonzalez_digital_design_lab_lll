module PLL(
    input wire clk_ref,      // Señal de reloj de referencia
    output reg clk_out       // Señal de reloj de salida generada por el PLL
);

    parameter integer N = 4;    // Factor de multiplicación de frecuencia

    reg [N-1:0] counter;

    always @(posedge clk_ref) begin
        if (counter == (1 << N) - 1) begin
            counter <= 0;
            clk_out <= ~clk_out;  // Invierte la señal de reloj para dividir la frecuencia
        end else begin
            counter <= counter + 1;
        end
    end

endmodule