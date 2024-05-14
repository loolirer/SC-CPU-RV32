module InstructionMemory (input [31:0] A, 
						  output reg [31:0] RD
						  );
	
	always @(*) begin
		case(A)
			32'h00: RD = 32'h0ab00293;
			32'h04: RD = 32'h0cd00313;
			32'h08: RD = 32'h006283b3;
			32'h0c: RD = 32'h40700e33;
			32'h10: RD = 32'h007e2eb3;
			32'h14: RD = 32'h01c3f333;
			32'h18: RD = 32'h006e63b3;
			32'h1c: RD = 32'h01d342b3;
			32'h20: RD = 32'h0ef37393;
			32'h24: RD = 32'h0fe3ee13;
			32'h28: RD = 32'h0dce4e13;
			32'h2c: RD = 32'habcdeeb7;
			32'h30: RD = 32'h00239313;
			32'h34: RD = 32'h002ed393;
			32'h38: RD = 32'h00730e33;
			32'h3c: RD = 32'h01c32023;
			32'h40: RD = 32'h00032283;
			32'h44: RD = 32'h00028f13;
			
			default: RD = 32'h0;

		endcase

	end

endmodule