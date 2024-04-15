module registroBarcos_tb();

    // Parameters
    parameter numBarcos = 5;

    // Inputs
    logic clk;
    logic rst;
    logic setter;
    
    // Outputs
    reg [4:0] barcos [0:numBarcos-1];

    // Instantiate the module
    registroBarcos #(.numBarcos(numBarcos)) dut (
        .clk(clk),
        .rst(rst),
        .setter(setter),
        .barcos(barcos)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        setter = 0;
        #10 rst = 0; // Assert reset for 10 time units
    end

    // Test case
    initial begin
        // Wait for reset to be de-asserted
        #20;

        // Write some values to the barcos array
        barcos[0][0] = 20;
        barcos[1][1] = 1;
        barcos[2][2] = 1;

        // Wait for some time
        #50;

        // Set the setter value to 1 to clear some values in the array
        setter = 0;

        // Wait for some time
        #50;

        // Reset the setter value
        setter = 0;

        // Finish simulation
        #10 $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t", $time);
        for (int i = 0; i < numBarcos; i++) begin
            $write("Barco[%0d]: ", i);
            for (int j = 0; j < 6; j++) begin
                $write("%0d ", barcos[i][j]);
            end
            $display("");
        end
    end

endmodule
