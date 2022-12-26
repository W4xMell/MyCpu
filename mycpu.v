module mycpu ( 
	input  wire       clk, rst,
	input  wire[31:0] readDataM, 
	input  wire[31:0] instF,
    output wire[31:0] pcF,
	output wire 	  memWriteM,
	output wire[31:0] aluOutM, writeAdr,writeDataM
);
	
	wire [31:0] pc, pcNextF, pcBranchD, pcPlus4F, pcPlus4D; 
	wire [31:0] signExtImmD, signExtImmE, instD, aluOutE,aluOutW, readDataW; 
	wire pcSrcD, regWriteD, regWriteE, regWriteM, regWriteW, 
			memToRegD, memToRegE, memToRegM,memToRegW, memWriteD, 
			memWriteE, aluSrcD, aluSrcE, regDstD, regDstE;

	wire [31:0] rd1D, rd2D, rd1E, rd2E, writeDataE;
	wire [3:0] aluCtrlD, aluCtrlE;
	wire [5:0] opD,functD;
	wire [4:0] rsD, rdD, rtD, rsE, rtE, rdE, writeRegE, writeRegM, writeRegW; 
	wire [3:0] branchOp;
    wire [31:0] compRD1, compRD2, resultW;
	wire stallF, stallD, flushE, jumpD;
	wire forward1D, forward2D;
	wire[1:0] forward1E, forward2E;
	
	//harzard control
	hazard harzardCtrl(
		regWriteE, regWriteM, regWriteW, memToRegE, memToRegM, branchD,
    	rsD, rtD, rsE, rtE, writeRegE, writeRegM, writeRegW,
    	forward1D, forward2D, flushE, stallF, stallD,
    	forward1E, forward2E
	);

	// IF
	mux2 #(32) pcMux1(pcPlus4F, pcBranchD, pcSrcD, pcNextF);
	mux2 #(32) pcMux2(pcNextF, {pcPlus4D[31:28], instD[25:0], 2'b00},
						jumpD, pc);
    pc pcReg (
		.clk(clk),
		.rst(rst),
		.en(~stallF),
		.d(pc),
		.q(pcF)
	);

	assign pcPlus4F = pcF + 32'b100;


	if_id if_id (
		.clk(clk),
		.rst(rst),
		.en(~stallD),
		.clr(pcSrcD),
		.pcPlus4F(pcPlus4F),
		.instF(instF),
		.pcPlus4D(pcPlus4D),
		.instD(instD)      
	);

	
	// ID
	assign opD = instD[31:26];
	assign functD = instD[5:0];
	assign rsD = instD[25:21];
	assign rtD = instD[20:16];
	assign rdD = instD[15:11];
	assign signExtImmD = {{16{instD[15]}},instD[15:0]};
	

	id id1 (
		.clk(clk),
		.rst(rst),
   		.opD(opD), 
		.functD(functD),

		.regWriteD(regWriteD), 
		.memToRegD(memToRegD), 
		.memWriteD(memWriteD), 
		.aluSrcD(aluSrcD), 
		.regDstD(regDstD), 
		.branchD(branchD), 
		.jumpD(jumpD),
		.aluCtrlD(aluCtrlD),
		.branchOp(branchOp)
	);

	

	regfile regs (
		.clk(clk),
		.ra1(rsD),
		.ra2(rtD),
		.wa3(writeRegW),
		.wd3(resultW),
		.we3(regWriteW),
		.rd1(rd1D),
		.rd2(rd2D)
    );

	
	//data forwarding
	mux2 #32 muxID1(rd1D, aluOutM, forward1D, compRD1);
	mux2 #32 muxID2(rd2D, aluOutM, forward2D, compRD2);

	hasBranch hasBranch1(
		.rsData(compRD1), 
		.rtData(compRD2),
		.branch(branchD),
		.branchOp(branchOp),
		.branchEn(pcSrcD) 
	);
	

	assign pcBranchD = {signExtImmD[29:0], 2'b00} + pcPlus4D;


	id_ex id_ex1 (
		.clk(clk),
		.rst(rst),
		.clr(flushE),
		.regWriteD(regWriteD),
		.memToRegD(memToRegD),
		.memWriteD(memWriteD),
		.aluSrcD(aluSrcD),
		.regDstD(regDstD),
		.aluCtrlD(aluCtrlD), 
		.rsD(rsD),
		.rtD(rtD),
		.rdD(rdD),

		.regData1D(rd1D),
		.regData2D(rd2D),
		.signExtImmD(signExtImmD),

		//out
		.regWriteE(regWriteE),
		.memToRegE(memToRegE),
		.memWriteE(memWriteE),
		.aluSrcE(aluSrcE),
		.regDstE(regDstE),
		.aluCtrlE(aluCtrlE),
		.rsE(rsE),
		.rtE(rtE),
		.rdE(rdE),

		.regData1E(rd1E),
		.regData2E(rd2E),
		.signExtImmE(signExtImmE)
	); 

	//EXE
	ex ex(
		.clk(clk),
		.rst(rst),

		.regData1D(rd1E),
		.regData2D(rd2E),
		.resultW(resultW),
		.aluOutM(aluOutM),
		.signExtImmE(signExtImmE),
		.rsE(rsE),
		.rtE(rtE),
		.rdE(rdE),

		.forward1E(forward1E),
		.forward2E(forward2E),
		.aluCtrlE(aluCtrlE),
		.aluSrcE(aluSrcE),
		.regDstE(regDstE),

		//out
		.aluOutE(aluOutE),
		.writeDataE(writeDataE),
		.writeRegE(writeRegE)
	);
	

	ex_mem ex_mem1 (
		.clk(clk),
		.rst(rst),

		.aluOutE(aluOutE),
		.writeDataE(writeDataE),
		.writeRegE(writeRegE),

		//ctrl sign
		.regWriteE(regWriteE),
		.memToRegE(memToRegE),
		.memWriteE(memWriteE),

		.aluOutM(aluOutM),
		.writeDataM(writeDataM),
		.writeRegM(writeRegM),

		//ctrl sign
		.regWriteM(regWriteM),
		.memToRegM(memToRegM),
		.memWriteM(memWriteM)
	);
	assign writeAdr = aluOutM;
	mem_wb mem_wb1 (
		.rst(rst),
		.clk(clk),	
		
		.readDataM(readDataM),
		.aluOutM(aluOutM),
		.regWriteM(regWriteM),
		.memToRegM(memToRegM),

		.writeRegM(writeRegM),

		.readDataW(readDataW),
		.aluOutW(aluOutW),
		.regWriteW(regWriteW),
		.memToRegW(memToRegW),

		.writeRegW(writeRegW)
	);
	//WB 
	mux2 #(32) wbmux(aluOutW, readDataW, memToRegW, resultW);
endmodule