`include "defines.v"

module id_ex (
    input  wire        clk, rst, clr, 
    input  wire        regWriteD, memToRegD, memWriteD, aluSrcD, regDstD, 
    input  wire[3:0]   aluCtrlD,
    input  wire[4:0]   rsD, rtD, rdD,
    input  wire[31:0]  regData1D, regData2D, signExtImmD,

    output reg         regWriteE, memToRegE, memWriteE, aluSrcE, regDstE, 
    output reg[3:0]    aluCtrlE,
    output reg[4:0]    rsE, rtE, rdE,
    output reg[31:0]   regData1E, regData2E, signExtImmE
);

    
    always @(posedge clk) begin
        if (rst) begin
            regWriteE <= 1'b0;
            memToRegE <= 1'b0;
            memWriteE <= 1'b0;
            aluSrcE <= 1'b0;
            regDstE <= 1'b0;
            aluCtrlE <= 4'b0000;
            rsE <= 5'b00000;
            rtE <= 5'b00000;
            rdE <= 5'b00000;
            regData1E <= `ZERO_WORD;
            regData2E <= `ZERO_WORD;
            signExtImmE <= `ZERO_WORD;
        end
        else if(clr) begin
            regWriteE <= 1'b0;
            memToRegE <= 1'b0;
            memWriteE <= 1'b0;
            aluSrcE <= 1'b0;
            regDstE <= 1'b0;
            aluCtrlE <= 4'b0000;
            rsE <= 5'b00000;
            rtE <= 5'b00000;
            rdE <= 5'b00000;
            regData1E <= `ZERO_WORD;
            regData2E <= `ZERO_WORD;
            signExtImmE <= `ZERO_WORD;
        end
        else
            regWriteE <= regWriteD;
            memToRegE <= memToRegD;
            memWriteE <= memWriteD; 
            aluSrcE <= aluSrcD;
            regDstE <= regDstD;
            aluCtrlE <= aluCtrlD;
            rsE <= rsD;
            rtE <= rtD;
            rdE <= rdD;
            regData1E <= regData1D;
            regData2E <= regData2D;
            signExtImmE <= signExtImmD;
    end

endmodule