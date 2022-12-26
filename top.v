`include "defines.v"

module top (
	input  wire clk, rst,
	output wire[31:0] writeData, writeAdr,
	output wire memWrite
    );

	wire[31:0] pc,inst,readData, aluOut;
	mycpu cpu1(clk, rst,readData,inst,pc,memWrite,aluOut, writeAdr, writeData);
 	inst_rom imem(pc, inst);
	data_ram dmem(clk, memWrite, writeAdr, writeData, readData);
endmodule