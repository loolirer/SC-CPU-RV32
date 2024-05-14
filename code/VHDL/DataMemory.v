module DataMemory (// Entradas
				   input [31:0] a,  // Endereço a ser armazenado
				   input [31:0] wd, // Dado a ser escrito
				   input we,        // Permissão para escrita
				   input clk,       // Clock
				   input rst,       // Reset
							
				   //Saídas
				   output [31:0] rd // Valor acessado
				   );
							
	// 2048 registradores de 32-bits
	reg [31:0] register [2047:0]; // 8 KiB
 
	// Escrita Síncrona (Reset Síncrono)
	always @ (posedge clk or negedge rst)
		begin
 
		if(~rst) 
			begin
				integer i;
				for(i = 0; i < 2048; i = i + 1)
					begin 
						register[i] <= 32'b0;
						
					end
					
			end 

		else if(we) 
			begin
				register[a] <= wd; 
				
			end 
 
	end
	
	// Leitura Assíncrona
	assign rd = register[a];
							
endmodule 