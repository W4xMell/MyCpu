`include "defines.v"

module id (
    input  wire clk, rst,
    
    input  wire [5:0] opD, functD,

    output wire regWriteD, memToRegD, memWriteD, aluSrcD, regDstD, branchD, jumpD,
    output reg [3:0]  aluCtrlD,
    output reg  [3:0]  branchOp
);
    
    reg[9:0] controls;
    wire[2:0] aluOp;
    reg[2:0] t;
    always @(*) begin
        case(opD) 
            6'b000000: begin
                controls <= 10'b1000100111;//R-TYRE
                branchOp <= 4'b0000;
            end 
            `EXE_LW: begin
                controls <= 10'b1101000000;//LW 110100000
                branchOp <= 4'b0000;
            end 
            `EXE_SW: begin
                controls <= 10'b0011000000;//SW 001100000
                branchOp <= 4'b0000;
            end 
            `EXE_BEQ: begin
                controls <= 10'b0000010001;//BEQ 000001001
                branchOp <= 4'b0001;
            end
            `EXE_BNE: begin
                controls <= 10'b0000010001;
                branchOp <= 4'b0010;
            end
            `EXE_BGTZ: begin
                controls <= 10'b0000010001;
                branchOp <= 4'b0100;
            end
            `EXE_ADDI: begin
                controls <= 10'b1001000000;//ADDI 100100000
                branchOp <= 4'b0000;
            end 
            `EXE_SLTI: begin
                controls <= 10'b1001000011;//SLTI 100100000
                branchOp <= 4'b0000;
            end 
            `EXE_J:begin
                controls <= 10'b0000011000;//J
                branchOp <= 4'b0111;
            end 
            default: begin
                controls <= 10'b0000000000;//illegal op
                branchOp <= 4'b0000;
            end
        endcase
    end
    //aluSrc is i-type 
    //regDst 1-rd 0-rt
    assign {regWriteD, memToRegD, memWriteD, aluSrcD, regDstD, branchD, jumpD, aluOp} = controls;

    always @(*) begin
        t = aluOp;
        case(t)
            3'b000: aluCtrlD = `ALU_ADD;//add (for lw/sw/addi)
            3'b001: aluCtrlD = `ALU_SUB;//sub (for beq)
            3'b010: aluCtrlD = `ALU_OR; // for ori
            3'b011: aluCtrlD = `ALU_SLT; // for slti
            default: begin
                case (functD)
                    `EXE_AND: aluCtrlD = `ALU_AND; //and
                    `EXE_OR:  aluCtrlD = `ALU_OR; //or
                    `EXE_ADD: aluCtrlD = `ALU_ADD; //add
                    `EXE_SUB: aluCtrlD = `ALU_SUB; //sub
                    `EXE_SLT: aluCtrlD = `ALU_SLT; //slt
                    `EXE_XOR: aluCtrlD = `ALU_XOR;
                    default:  aluCtrlD = 4'b0000;
                endcase
            end
        endcase
    end

    
endmodule 
		
