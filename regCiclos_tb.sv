module regCiclos_tb();

    // Inputs
    logic clk;
    logic rst;
    logic enable;
    
    // Outputs
    logic result;

    // Instantiate the module
    regCiclos dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        #10 rst = 0; // Assert reset for 10 time units
    end

    // Test case
    initial begin
        #20 enable = 1; // Enable counting
        #200 enable = 0; // Disable counting after 60 time units
        #10 $finish; // Finish simulation after 10 time units
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t, Result = %b", $time, result);
    end

endmodule
