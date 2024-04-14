`timescale 1ns / 1ps

module Random_TB;

// Parameters
parameter CLK_PERIOD = 10; // Clock period in ns

// Signals
logic clk;
logic enable;
logic [4:0] lfsr_state; // Change here from rand_num

// Instantiate the module under test
Random dut (
    .clk(clk),
    .enable(enable),
    .rand_num(lfsr_state) // Change here from rand_num
);

// Clock generation
always #((CLK_PERIOD)/2) clk = ~clk;

// Stimulus generation
initial begin
    clk = 0;
    enable = 0;
    #100; // Wait for initial stabilization

    // Enable the LFSR
    enable = 1;
    #100; // Wait for some time

    // Disable the LFSR
    enable = 0;
    #100; // Wait for some time

    // Re-enable the LFSR
    enable = 1;
    #100; // Wait for some time

    // Finish simulation
    $finish;
end

// Waveform dump


endmodule
