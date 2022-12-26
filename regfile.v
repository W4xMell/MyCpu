`include "defines.v"

module regfile(
	input  wire clk,
	input  wire we3,
	input  wire[4:0] ra1,ra2,wa3,
	input  wire[31:0] wd3,
	output wire[31:0] rd1,rd2
    );

	reg [31:0] rf[31:0];
	
	//下降沿写入
	always @(negedge clk) begin
		if(we3) begin
			rf[wa3] <= wd3;
		end
	end

	assign rd1 = (ra1 != 5'b00000) ? rf[ra1] : `ZERO_WORD;
	assign rd2 = (ra2 != 5'b00000) ? rf[ra2] : `ZERO_WORD;

endmodule