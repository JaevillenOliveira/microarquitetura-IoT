module init_lcd (dataA, dataB, result,clk, clk_en, reset, start, done, data_out);

	input clk, clk_en, reset, start;
	input [31:0] dataA, dataB;
 
	output reg [7:0] data_out;
	
	output reg [31:0] result;

	output reg done;

	reg operation_select; 

	parameter A = 8'b00000000, 
			  T = 8'b00000000, 
			  C = 8'b00000000,
			  W = 8'b00000000,
			  J = 8'b00000000,
			  P = 8'b00000000,
			  U = 8'b00000000,
			  R = 8'b00000000,
			  I = 8'b00000000,
			  S = 8'b00000000,
			  E = 8'b00000000,
			  N = 8'b00000000,
			  D = 8'b00000000,
			  plus  = 8'b00000000,
			  minus = 8'b00000000,
			  equal = 8'b00000000,
			  bar   = 8'b00000000;
			  
	always @ (posedge clk) begin

		if (reset) begin
			result <= 32'd0;
			data_out <= 8'b0;
			done <= 1'b0;
		end
		
		else begin

			if(clk_en) begin
				operation_select <= dataA[0];

				if (operation_select) begin
					

				end

				else begin


				end
			end

		end

	end

endmodule