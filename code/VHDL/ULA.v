module ULA (input [31:0] SrcA, 
		    input [31:0] SrcB, 
            input [2:0] ULAControl, 
		    output reg [31:0] ULAResult, 
			output Zero
			);
	
	always @(*) begin
		case(ULAControl)
				3'b000: ULAResult = SrcA + SrcB; 
				3'b001: ULAResult = SrcA + ~SrcB + 1;
				3'b010: ULAResult = SrcA & SrcB;
				3'b011: ULAResult = SrcA | SrcB;
				3'b100: ULAResult = SrcA ^ SrcB;
				3'b101: ULAResult = SrcA < SrcB ? 1 : 0;
				3'b110: ULAResult = SrcA << SrcB;
				3'b111: ULAResult = SrcA >> SrcB;
				
				default: ULAResult = 0;

		endcase

	end
	
	assign Zero = ULAResult == 0 ? 1 : 0;

endmodule