module FSM_tb;

  // Inputs
  logic Btn, rst, clk, T, V, VJ, VP, RBarcos;
  logic [2:0] NBarcos;
  
  // Outputs
  logic Timer, Turno, TurnoPC, SBarcos, CBarcos, CVictoria, CDerrota;
  
  // Instantiate the module under test
  FSM uut (
    .Btn(Btn),
    .rst(rst),
    .clk(clk),
    .T(T),
    .V(V),
    .VJ(VJ),
    .VP(VP),
    .RBarcos(RBarcos),
    .NBarcos(NBarcos),
    .Timer(Timer),
    .Turno(Turno),
    .TurnoPC(TurnoPC),
    .SBarcos(SBarcos),
    .CBarcos(CBarcos),
    .CVictoria(CVictoria),
    .CDerrota(CDerrota)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Initial values
  initial begin
    clk = 0;
    rst = 1;
    Btn = 0;
    T = 0;
    V = 0;
    VJ = 0;
    VP = 0;
    RBarcos = 0;
    NBarcos = 0;
    #10 rst = 0; // De-assert reset after some time
    #50;
    // Test scenario
    // Add your test scenarios here
    #10 Btn = 1; // Simulate button press
    #10 Btn = 0; // Simulate button release
    #10 T = 1;   // Simulate condition T being true
    #10 T = 0;   // Simulate condition T being false
    // Add more test scenarios as needed
    #100 $finish; // End simulation
  end

endmodule
