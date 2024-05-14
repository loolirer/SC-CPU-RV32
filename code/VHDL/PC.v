module PC (// Entradas
		   input [31:0] PCin, // PC de entrada
		   input clk,         // Clock
		   input rst,         // Reset
		
		   // Saídas
		   output reg [31:0] PC
		   );  	
							
	// Registradores de 8-bits
	reg [31:0] register; 
 
	// Escrita Síncrona (Reset Síncrono)
	always @ (posedge clk or negedge rst)
		begin
 
		if(~rst) 
			begin
				PC = 32'b0;
				
			end 
			
		else 
			begin
				PC = PCin;
			
			end 
 
	end
							
endmodule 