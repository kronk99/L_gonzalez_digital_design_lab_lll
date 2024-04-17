module regBarcosperdidos_tb;

    // Parameters
    parameter numBarcos = 5;

    // Inputs
    logic clk;
    logic rst;
    logic enable;
    logic [4:0] barcos [4:0];

    // Outputs
    logic [4:0] result;

    // Instantiate the module
    regBarcosperdidos #(.numBarcos(numBarcos)) dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .barcos(barcos),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        // Initialize barcos matrix
        for (int i = 0; i < numBarcos; i++) begin
            for (int j = 0; j < 5; j++) begin
                barcos[i][j] = 1; // Initialize all boats as not destroyed
            end
        end
        #10 rst = 0; // De-assert reset after 10 time units
    end

    // Test case
    initial begin
        // Wait for some time
        #20;

        // Disable reset and enable the module
        rst = 0;
        enable = 1;
		  
		  #20;

        // Simulate destruction of boats
        // Assume boat 2 and boat 4 are destroyed
        barcos[1] = 5'b00000;
        barcos[3] = 5'b00000;
		  barcos[4] = 5'b11000; //Boat 5 is partially destroyed, should still be a 1

        // Wait for some time
        #20;

        // Finish simulation
        $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t, Result = %b", $time, result);
    end

endmodule
