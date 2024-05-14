module MUX2 #(parameter len=32)(output [len-1:0]out,
								input  [len-1:0]i0,
								input  [len-1:0]i1,
								input  sel
								);
	
	assign out = ~sel ? i0 : i1;

endmodule