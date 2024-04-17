module sincronizador(
	input [0:9] pixel_num,   // Número de píxeles en una línea
	input [0:9] linea_num,   // Número de líneas en el cuadro
	output hsync,            // Señal de sincronización horizontal
	output vsync,            // Señal de sincronización vertical
	output n_blank           // Señal de activación de pantalla
);

	logic hback_porch;       // Variable para el porche posterior horizontal
	logic hfront_porch;      // Variable para el porche frontal horizontal
	logic hsync_aux;         // Variable auxiliar para la sincronización horizontal
	logic vback_porch;       // Variable para el porche posterior vertical
	logic vfront_porch;      // Variable para el porche frontal vertical
	logic vsync_aux;         // Variable auxiliar para la sincronización vertical
	
	//generate 
	
	// Comparaciones horizontales
	comparador_mayor #(10) comparador_hfront_porch(
		.a(pixel_num),       // Número de píxeles en una línea
		.b(10'd640),         // Valor del píxel para el porche frontal horizontal
		.mayor(hfront_porch)  // Resultado de la comparación
	);
	
	comparador_mayor #(10) comparador_hsync(
		.a(pixel_num),       // Número de píxeles en una línea
		.b(10'd656),         // Valor del píxel para la sincronización horizontal
		.mayor(hsync_aux)    // Resultado de la comparación
	);
	
	comparador_mayor #(10) comparador_hback_porch(
		.a(pixel_num),       // Número de píxeles en una línea
		.b(10'd752),         // Valor del píxel para el porche posterior horizontal
		.mayor(hback_porch)  // Resultado de la comparación
	);

	// Comparaciones verticales
	comparador_mayor #(10) comparador_vfront_porch(
		.a(linea_num),       // Número de líneas en el cuadro
		.b(10'd480),         // Valor de la línea para el porche frontal vertical
		.mayor(vfront_porch)  // Resultado de la comparación
	);
	
	comparador_mayor #(10) comparador_vsync(
		.a(linea_num),       // Número de líneas en el cuadro
		.b(10'd490),         // Valor de la línea para la sincronización vertical
		.mayor(vsync_aux)    // Resultado de la comparación
	);
	
	comparador_mayor #(10) comparador_vback_porch(
		.a(linea_num),       // Número de líneas en el cuadro
		.b(10'd492),         // Valor de la línea para el porche posterior vertical
		.mayor(vback_porch)  // Resultado de la comparación
	);
	
	// Asignaciones de las señales de sincronización y pantalla
	assign vsync = ~(vsync_aux ^ vback_porch);   // Determina la señal de sincronización vertical
	assign hsync = ~(hsync_aux ^ hback_porch);   // Determina la señal de sincronización horizontal
	assign n_blank = ~(hfront_porch || vfront_porch);  // Determina la señal de activación de pantalla
	
	//endgenerate
	
endmodule
