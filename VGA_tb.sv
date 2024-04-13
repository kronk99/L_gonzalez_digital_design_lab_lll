module VGA_tb(input logic rst, output logic [7:0] VGA_G,VGA_R,VGA_B, output logic VGA_HS, VGA_VS, VGA_SYNC_N, VGA_CLK, VGA_BKANK_N
);
//reloj 
logic clk; // Declaración de la señal de reloj

// Generar un reloj de 100 MHz
always #(10) clk = ~clk; // 5 unidades de tiempo (por ejemplo, 10 ns) para un reloj de 100 MHz
//
/*reg btn_prev;       // Estado previo del botón

always @(posedge clk) begin
 // Si el botón estaba en bajo y ahora está en alto
	if (rst) begin
		rst <= 1;    // Establece el reset en alto
   end else begin
      rst <= 0;    // De lo contrario, mantén el reset en bajo
   end
      btn_prev <= btn;  // Actualiza el estado previo del botón
end*/


PLL pllmanger(.clk_ref(clk), .clk_out(vga_pll));
vga_driver draw   ( .clock(vga_pll),        // 25 MHz PLL si el relog de referencia es de 100 mhz
                    .reset(btn_prev),      // Active high reset, manipulated by instantiating module
                    .color_in(111000000), // Pixel color (RRRGGGBB) for pixel being drawn
                    .next_x(next_x),        // X-coordinate (range [0, 639]) of next pixel to be drawn
                    .next_y(next_y),        // Y-coordinate (range [0, 479]) of next pixel to be drawn
                    .hsync(VGA_HS),         // All of the connections to the VGA screen below
                    .vsync(VGA_VS),
                    .red(VGA_R),
                    .green(VGA_G),
                    .blue(VGA_B),
                    .sync(VGA_SYNC_N),
                    .clk(VGA_CLK),
                    .blank(VGA_BLANK_N)
);                  
endmodule 