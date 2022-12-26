`timescale 1ns / 1ps

module test ();
	reg clk;
	reg rst;

	wire[31:0] writeData,dataAdr;
	wire memWrite;

	initial begin 
		rst <= 1'b1;
		#200 rst <= 1'b0;
	end

	initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    top t(clk,rst,writeData,dataAdr,memWrite);
	// always @(negedge clk) begin
	// 	if(memWrite) begin
	// 		/* code */
	// 		if(dataAdr === 84 && writeData === 7) begin
	// 			/* code */
	// 			$display("Simulation succeeded");
	// 			#5;
	// 			$stop;
	// 		end else if(dataAdr !== 80) begin
	// 			/* code */
	// 			$display("Simulation Failed");
	// 			#5;
	// 			$stop;
	// 		end
	// 	end
	// end

endmodule