module RandomGen (
    input wire clk,       // Clock input
    input wire rst_n,     // Reset input (active low)
    input wire [7:0] seed, // Input for initial seed value
    output reg [7:0] rand_out // Output 8-bit random number
);

reg [7:0] lfsr; // Register for LFSR

// Initial seed value for LFSR
initial begin
    lfsr = seed; // Use the input seed value
end

// LFSR operation
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        lfsr <= seed; // Reset LFSR to initial seed value
    end else begin
        // LFSR shift and feedback
        lfsr <= {lfsr[6:0], lfsr[5] ^ lfsr[3] ^ lfsr[2] ^ lfsr[0]}; // Maximal-length LFSR tap positions
    end
end

// Output 8-bit random number
always @(posedge clk) begin
    rand_out <= lfsr;
end

endmodule