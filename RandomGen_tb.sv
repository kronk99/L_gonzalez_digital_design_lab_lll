module RandomGen_tb;

    // Declare signals
    logic clk = 0;
    logic rst_n = 0;
    logic [7:0] seed = 8'hFF; // Initial seed value
    logic [7:0] rand_out;

    // Instantiate the RandomGen module
    RandomGen randomGen_inst (
        .clk(clk),
        .rst_n(rst_n),
        .seed(seed),
        .rand_out(rand_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Assuming a 50% duty cycle clock with 10ns period

    // Reset generation
    initial begin
        rst_n = 0; // Assert reset
        #20;
        rst_n = 1; // Deassert reset
        #1000; // Run for some time
        $finish; // End simulation
    end

    // Display random numbers
    always @(posedge clk) begin
        $display("Random number: %h", rand_out);
    end

endmodule
