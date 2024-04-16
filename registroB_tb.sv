module registroB_tb();

    // Inputs
    logic clk;
    logic rst;
    logic enable;
    logic [2:0] tipo;
    logic [4:0] casilla;
    
    // Outputs
    logic [4:0] barco;
    logic [2:0] tipob;

    // Instantiate the module
    registroB dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .tipo(tipo),
        .casilla(casilla),
        .barco(barco),
        .tipob(tipob)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        tipo = 3'b000;
        casilla = 5'b00000;
        #10 rst = 0; // Assert reset for 10 time units
    end

    // Test case
    initial begin
        // Wait for reset to be de-asserted
        #20;

        // Set enable to 1 to update the barco register
        enable = 1;

        // Assign some values to casilla and tipo
        casilla = 5'b11010;
        tipo = 3'b010;

        // Wait for some time
        #50;

        // Set enable to 0 to stop updating the barco register
        enable = 0;

        // Finish simulation
        #10 $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t, barco = %b, tipob = %b", $time, barco, tipob);
    end

endmodule
