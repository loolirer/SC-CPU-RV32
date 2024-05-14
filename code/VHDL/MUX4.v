module MUX4 #(parameter len=32)(output reg [len-1:0]out,
								input  [len-1:0]i0,
								input  [len-1:0]i1,
								input  [len-1:0]i2,
								input  [len-1:0]i3,
								input  [1:0]sel
								);
	
	always @ (i0 or i1 or i2 or i3 or sel) begin
      case(sel)
			2'b00: out = i0;
			2'b01: out = i1;
			2'b10: out = i2;
			2'b11: out = i3;
			
			default: out = 32'b0;

		endcase

	end
			
endmodule