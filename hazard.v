`include "defines.v"

module hazard (
    input  wire       regWriteE ,regWriteM, regWriteW, memToRegE, memToRegM, branchD,
    input  wire[4:0]  rsD, rtD, rsE, rtE, writeRegE, writeRegM, writeRegW,

    output wire       forward1D, forward2D, flushE, stallF, stallD,
    output reg[1:0]   forward1E, forward2E
);
    wire lwStallD, branchStallD;

    assign forward1D = (rsD != 6'b0 & rsD == writeRegM & regWriteM);
	assign forward2D = (rtD != 6'b0 & rtD == writeRegM & regWriteM);

    always @(*) begin
        forward1E = 2'b00;
        forward2E = 2'b00;

        if (rsE != 0) begin
            if (rsE == writeRegM && regWriteM) begin
                forward1E = 2'b10;
            end
            else if (rsE == writeRegW && regWriteW) begin
                forward1E = 2'b01;
            end
        end

        if (rtE != 0) begin
            if (rtE == writeRegM && regWriteM) begin
                forward2E = 2'b10;
            end
            else if (rtE == writeRegW && regWriteW) begin
                forward2E = 2'b01;
            end
        end
    end
   
    assign  lwStallD = memToRegE & (rtE == rsD | rtE == rtD);
	assign  branchStallD = branchD &
				(regWriteE & 
				(writeRegE == rsD | writeRegE == rtD) |
				memToRegM &
				(writeRegM == rsD | writeRegM == rtD));
	assign  stallD = lwStallD | branchStallD;
	assign  stallF = stallD;
	//stalling D stalls all previous stages
	assign  flushE = stallD;

endmodule