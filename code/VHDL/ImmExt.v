module ImmExt (output reg [31:0]out,
			   input  [31:0]in,
			   input  [1:0]sel
			   );
	
	always @ (in or sel) begin
		case(sel)
			2'b00: out = {{21{in[31]}}, in[30:20]};                        // Type R and I
			2'b01: out = {{21{in[31]}}, in[30:25], in[11:7]};              // Type S
			2'b10: out = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0}; // Type B
			2'b11: out = {in[31:12], 12'b0};                               // Type U
			
			default: out = 32'b0;

		endcase
			
	end
		
endmodule