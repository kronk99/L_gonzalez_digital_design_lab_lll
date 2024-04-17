module regCasillas_tb;

    // Inputs
    logic clk;
    logic fila;
    logic columna;
    logic enable;
    logic reset;

    // Output
    logic valid;

    // Instantiate the module
    regCasillas dut (
        .clk(clk),
        .fila(fila),
        .columna(columna),
        .enable(enable),
        .reset(reset),
        .valid(valid)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Reset generation
    initial begin
        clk = 0;
        fila = 0;
        columna = 0;
        enable = 0;
        reset = 0;
    end

    // Test cases
    initial begin
        // Wait for some time
        #20;

        // Enable the module and interact with cells
        enable = 1;

        // Interact with cell at row 2, column 3
        fila = 2;
        columna = 3;
        #10;

        // Interact with cell at row 0, column 0
        fila = 0;
        columna = 0;
        #10;

        // Interact with cell at row 4, column 2
        fila = 4;
        columna = 2;
        #10;

        // Interact with cell at row 3, column 3
        fila = 2;
        columna = 3;
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time = %0t, Valid = %b", $time, valid);
    end

endmodule
