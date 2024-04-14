//Este modulo genera un numero aleatorio entre 1 y 25. Funciona para el turno de la pc
module Random (
    input logic clk,
    input logic enable,
    output logic [4:0] rand_num
);

// Define LFSR parameters
parameter LFSR_WIDTH = 5;  // LFSR width
parameter TAP_POSITION = 2; // Tap position for maximum period

// LFSR state
logic [LFSR_WIDTH-1:0] lfsr_state;

// Main functionality
always_ff @(posedge clk) begin
    if (enable) begin
        lfsr_state[LFSR_WIDTH-1:0] <= {lfsr_state[LFSR_WIDTH-2:0], lfsr_state[LFSR_WIDTH-1] ^ lfsr_state[TAP_POSITION-1]};
		  
    end
end

// Output random number

assign rand_num = lfsr_state;
endmodule
