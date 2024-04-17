module regCasillas_tb;

    // Inputs
    logic clk;
    logic [4:0] in;
    logic enable;
    logic reset;

    // Output
    logic valid;

    // Instantiate the module
    regCasillas dut (
        .clk(clk),
		  .in(in),
        .enable(enable),
        .reset(reset),
        .valid(valid)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
		  in = 0;
        enable = 0;
        reset = 0;
    end

    // Test cases
    initial begin
        // Wait for some time
		  reset = 1;
        #10;

        // Enable the module and interact with cells
		  reset = 0;
		  #10
        enable = 1;

        // Interact with cell at row 2, column 3
        in = 10;
        #10;

        // Interact with cell at row 0, column 0
        in = 25;
        #10;

        // Interact with cell at row 4, column 2
        in = 22;
        #10;

        // Interact with cell at row 3, column 3
        in = 25;
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t, Valid = %b", $time, valid);
    end

endmodule
