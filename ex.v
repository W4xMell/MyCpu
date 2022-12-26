`include "defines.v"

module ex (
    input  wire       clk, rst, 
    input  wire[31:0] regData1D, regData2D, resultW, aluOutM,
                      signExtImmE,
    input  wire[4:0]  rsE, rtE, rdE,
    //ctrl sign
    input  wire[1:0]  forward1E, forward2E,
    input  wire[3:0]  aluCtrlE,
    input  wire       aluSrcE, regDstE, 

    output reg[31:0]  aluOutE, writeDataE,
    output wire[4:0]  writeRegE
);

    wire[31:0] a, b, t, s, bout;
    wire[4:0] regt;
    wire[3:0] aluCtrl;
    mux3 #(32) forward1Mux(regData1D,resultW,aluOutM,forward1E,a);
	mux3 #(32) forward2Mux(regData2D,resultW,aluOutM,forward2E,t);
	mux2 #(32) srcbmux(t,signExtImmE,aluSrcE,b);
	assign bout = aluCtrlE[3] ? ~b : b;
	assign s = a + bout + aluCtrlE[3];
    assign aluCtrl = aluCtrlE;

	always @(*) begin
        writeDataE = t;
		case (aluCtrl)
			`ALU_AND: aluOutE = a & bout;
			`ALU_OR: aluOutE = a | bout;
			`ALU_ADD: aluOutE = s;
            `ALU_SUB: aluOutE = s;
			`ALU_SLT: aluOutE = s[31];
            `ALU_XOR: aluOutE = a ^ bout;
			default : aluOutE = 32'b0;
		endcase	
	end
    mux2 #(5) wrmux(rtE,rdE,regDstE,regt);
    assign writeRegE = regt;
endmodule