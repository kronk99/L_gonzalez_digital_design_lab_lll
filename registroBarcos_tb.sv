module registroBarcos_tb();

    // Parameters
    parameter numBarcos = 5;

    // Inputs
    logic clk;
    logic rst;
    logic enable;
    logic setter;
    logic [4:0] casilla;
    logic [4:0] barco1, barco2, barco3, barco4, barco5;
    logic [2:0] tbarco1, tbarco2, tbarco3, tbarco4, tbarco5;

    // Outputs
    logic [4:0] barcosout [4:0]; // Assuming each barco has 5 positions

    // Instantiate the module
    registroBarcos #(.numBarcos(numBarcos)) dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .setter(setter),
        .casilla(casilla),
        .barco1(barco1),
        .barco2(barco2),
        .barco3(barco3),
        .barco4(barco4),
        .barco5(barco5),
        .tbarco1(tbarco1),
        .tbarco2(tbarco2),
        .tbarco3(tbarco3),
        .tbarco4(tbarco4),
        .tbarco5(tbarco5),
        .barcosout(barcosout)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        setter = 0;
        casilla = 5'b00000;
        barco1 = 5'b00000;
        barco2 = 5'b00000;
        barco3 = 5'b00000;
        barco4 = 5'b00000;
        barco5 = 5'b00000;
        tbarco1 = 0;
        tbarco2 = 0;
        tbarco3 = 0;
        tbarco4 = 0;
        tbarco5 = 0;
        #10 rst = 0; // Assert reset for 10 time units
    end

    // Test case
    initial begin
        // Wait for reset to be de-asserted
        #20;

        // Set the positions of the ships (assuming 5 positions for each ship)
        barco1 = 5'b00010;
        barco2 = 5'b01000;
        barco3 = 5'b01111;
        barco4 = 5'b10100;
        barco5 = 5'b11001;

        // Set the sizes of the ships
        tbarco1 = 1;
        tbarco2 = 2;
        tbarco3 = 3;
        tbarco4 = 4;
        tbarco5 = 5;

        // Enable setter to initialize the barcos array
        setter = 1;
        #10 setter = 0;

        // Enable the module to process hits
        enable = 1;

        // Simulate hits on the ships
        casilla = 5'b00010; // Hit on ship 1
        #20 casilla = 5'b11000; // Hit on ship 5
		  #20 casilla = 5'b00111; // Hit on ship 5
        #20 casilla = 5'b00101; // Missed hit

        // Finish simulation
        #10 $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t", $time);
        for (int i = 0; i < numBarcos; i++) begin
            $write("Barco[%0d]: ", i);
            for (int j = 0; j < 5; j++) begin
                $write("%0d ", barcosout[i][j]);
            end
            $display("");
        end
    end

endmodule
