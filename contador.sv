module contador(input logic clk, rst, enable, signal, output logic [4:0] result);
    reg [4:0] numActual = 5'b00001; // Inicialización de numActual

    always_ff @(posedge clk) begin
        if (rst) begin
            numActual <= 5'b00001;
        end else begin
            if (signal && enable) begin
                numActual <= numActual + 1;
                if (numActual > 5'b11001) begin
                    numActual <= 5'b00001;
                end
            end
        end
    end

    assign result = numActual; // Asignación del resultado
endmodule