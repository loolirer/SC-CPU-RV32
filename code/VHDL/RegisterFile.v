module RegisterFile (// Entradas
					 input [31:0] wd, // Dado a ser escrito
					 input [4:0] wa,  // Endereço do registrador da escrita
					 input we,        // Permissão para escrita
					 input clk,       // Clock
					 input rst,       // Reset
					 input [4:0] ra1, // Endereços dos registradores a serem acessados
					 input [4:0] ra2, 
						
					 //Saídas
					 output [31:0] rd1, // Valores dos registradores acessados
					 output [31:0] rd2, 
						
					 // Saídas Auxiliares
					 output [31:0] x30,
					 output [31:0] x31
					 );
							
	// 32 registradores de 32-bits
	reg [31:0] register [31:0]; 
 
	// Escrita Síncrona (Reset Síncrono)
	always @ (posedge clk or negedge rst)
		begin
 
		if(~rst) 
			begin
				integer i;
				for(i = 0; i < 32; i = i + 1)
					begin 
					
						register[i] <= 32'b0;
						
					end
			end 

		else if(we) 
			begin
			
			if(wa != 0)
				begin
				
					register[wa] <= wd; 
					
				end
			
			end 
 
	end
	
	// Leitura Assíncrona
	assign rd1 = register[ra1];
    assign rd2 = register[ra2];
	
	// Leitura Auxiliar
	assign x30 = register[30];
	assign x31 = register[31];
							
endmodule 