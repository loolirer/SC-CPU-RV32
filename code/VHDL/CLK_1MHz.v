module CLK_1MHz(output reg clk_1MHz, 
				input clk_50MHz
				);

	reg [24:0]counter;

	always @ (posedge clk_50MHz) 
		begin
			if(counter == 25'd24) 
				begin 
					counter = 25'd0; 
					clk_1MHz = ~clk_1MHz; 

				end

			else 
				begin
					counter = counter + 1; 

				end

		end

endmodule