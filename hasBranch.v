/**
    branchOp:
    beq:   0001  =
    bne:   0010  !=
    bgez:  0011  >0
    bgtz:  0100  >=0
    blez:  0101  <0
    bltz:  0110  <=0
    j:     0111  
**/
`include "defines.v"

module hasBranch (
    input  wire[31:0] rsData, rtData,
    input  wire       branch,
    input  wire[3:0]  branchOp,
    output reg branchEn
);
    reg isEqual, isLarger;

    always @(*) begin
        if (branch) begin
            isEqual = (rsData == rtData);
            isLarger = (rsData > 0);
            case (branchOp)
                `BRAN_BEQ:  branchEn = isEqual;
                `BRAN_BNE:  branchEn = !isEqual;
                `BRAN_BGTZ: branchEn = isLarger;
                `BRAN_BLTZ: branchEn = (!isLarger && !isEqual);
                default : branchEn = `TRUE;
            endcase
        end
        else
            branchEn = `FALSE;
    end
    
endmodule