module ControlUnit (// Entradas
					input [6:0] OP, 
					input [6:0] Funct7, 
			        input [2:0] Funct3, 
						  
					// Saídas
				    output reg RegWrite, 
					output reg ULASrcA, 
				    output reg ULASrcB, 
				    output reg [2:0] ULAControl,
					output reg [1:0] ImmSrc,
					output reg MemWrite,
					output reg ResultSrc,
					output reg Branch
					);

    wire [16:0] word; 
    assign word = {OP, Funct3, Funct7};
      
	always @ (*) begin
        casez(word)
			// ---------- Type R ----------
			17'b0110011_000_0000000: // ADD
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b000;
				ImmSrc = 2'b00;
			    MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			17'b0110011_000_0100000: // SUB
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b001;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			17'b0110011_111_0000000: // AND
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b010;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			17'b0110011_110_0000000: // OR
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b011;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			17'b0110011_100_0000000: // XOR
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b100;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			17'b0110011_010_0000000: // SLT
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b101;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0110011_001_0000000: // SLL
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b110;
				ImmSrc = 2'b00;
			    MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0110011_101_0000000: // SLR
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b111;
				ImmSrc = 2'b00;
			    MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			// ---------- Type I ----------
			17'b0010011_000_zzzzzzz: // ADDI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b000;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0010011_111_zzzzzzz: // ANDI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b010;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0010011_110_zzzzzzz: // ORI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b011;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0010011_100_zzzzzzz: // XORI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b100;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0010011_010_zzzzzzz: // SLTI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b101;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0010011_001_zzzzzzz: // SLLI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b110;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end

			17'b0010011_101_zzzzzzz: // SLRI
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b111;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			17'b0000011_010_zzzzzzz:  // LW
			begin
				RegWrite = 1;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b000;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 1;
				Branch = 0;
			end

			// ---------- Type U ----------
			17'b0110111_zzz_zzzzzzz: // LUI
			begin
				RegWrite = 1;
				ULASrcA = 1;
				ULASrcB = 1;
				ULAControl = 3'b000;
				ImmSrc = 2'b11;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
			// ---------- Type S ----------
			17'b0100011_010_zzzzzzz:  // SW
			begin
				RegWrite = 0;
				ULASrcA = 0;
				ULASrcB = 1;
				ULAControl = 3'b000;
				ImmSrc = 2'b01;
				MemWrite = 1;
				ResultSrc = 0;
				Branch = 0;
			end
			
			// ---------- Type B ----------
			17'b1100011_000_zzzzzzz: // BEQ
			begin
				RegWrite = 0;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b001;
				ImmSrc = 2'b10;
				MemWrite = 0;
				ResultSrc = 0;
				Branch = 1;
			end
			
			default:
			begin
				RegWrite = 0;
				ULASrcA = 0;
				ULASrcB = 0;
				ULAControl = 3'b000;
				ImmSrc = 2'b00;
				MemWrite = 0;
			    ResultSrc = 0;
				Branch = 0;
			end
			
		endcase
	end

endmodule