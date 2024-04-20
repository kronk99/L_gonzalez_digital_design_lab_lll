module asignarRegistros ( //logica para colocar los registros.
    input logic clk,
    input logic rst,
    input logic enable,
    input logic [2:0] select,
    input logic [4:0] next,
    output logic [4:0] barco1,
    output logic [4:0] barco2,
    output logic [4:0] barco3,
    output logic [4:0] barco4,
    output logic [4:0] barco5
);

    // Registros para almacenar los valores de los barcos
    logic [4:0] barco1_reg, barco2_reg, barco3_reg, barco4_reg, barco5_reg;

    // Proceso para asignar los valores a los registros de los barcos
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reiniciar los valores de los barcos si rst es alto
            barco1_reg <= 5'b00000;
            barco2_reg <= 5'b00000;
            barco3_reg <= 5'b00000;
            barco4_reg <= 5'b00000;
            barco5_reg <= 5'b00000;
        end else if (enable) begin
            // Asignar valores basados en el select
            case (select)
                3'b001: barco1_reg <= next;
                3'b010: barco2_reg <= next;
                3'b011: barco3_reg <= next;
                3'b100: barco4_reg <= next;
                3'b101: barco5_reg <= next;
                default: // No hacer nada si el select no coincide con ningún caso
            endcase
        end
    end
    // Asignar los valores de los registros a las salidas
    assign barco1 = barco1_reg;
    assign barco2 = barco2_reg;
    assign barco3 = barco3_reg;
    assign barco4 = barco4_reg;
    assign barco5 = barco5_reg;
endmodule