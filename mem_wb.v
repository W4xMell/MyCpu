`include "defines.v"

module mem_wb (
    input   wire        clk, rst,
    input   wire[31:0]  readDataM, aluOutM,
    input   wire        regWriteM, memToRegM, 
    input   wire[4:0]   writeRegM,

    output  reg[31:0]   readDataW, aluOutW,
    output  reg         regWriteW, memToRegW, 
    output  reg[4:0]    writeRegW
);
    always @(posedge clk) begin
        if (rst) begin
            readDataW <= `ZERO_WORD;
            aluOutW <= `ZERO_WORD;
            regWriteW <= 1'b0;
            memToRegW <= 1'b0;
            writeRegW <= 5'b0;
        end
        else begin
            readDataW <= readDataM;
            aluOutW <= aluOutM;
            regWriteW <= regWriteM;
            memToRegW <= memToRegM;
            writeRegW <= writeRegM;
        end
    end
endmodule