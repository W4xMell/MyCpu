`include "defines.v"

module ex_mem (
    input  wire       clk, rst,

    input  wire[31:0] aluOutE, writeDataE,
    input  wire[4:0]  writeRegE,
    input  wire       regWriteE, memToRegE, memWriteE,

    output reg[31:0]  aluOutM, writeDataM,
    output reg[4:0]   writeRegM,
    output reg        regWriteM, memToRegM, memWriteM
);
    always @(posedge clk) begin
        if (rst) begin
            aluOutM <= `ZERO_WORD;
            writeDataM <= `ZERO_WORD;
            writeRegM <= 5'b00000;
            regWriteM <= 1'b0;
            memToRegM <= 1'b0;
            memWriteM <= 1'b0;
        end
        else begin
            aluOutM <= aluOutE;
            writeDataM <= writeDataE;
            writeRegM <= writeRegE;
            regWriteM <= regWriteE;
            memToRegM <= memToRegE;
            memWriteM <= memWriteE;
        end
            
    end
endmodule