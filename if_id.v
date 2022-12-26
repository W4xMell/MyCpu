`include "defines.v"

module if_id (
    input  wire clk, rst, en, clr, 
    input  wire[31:0] pcPlus4F, instF,
    output reg[31:0]  pcPlus4D, instD

);
    always @(posedge clk) begin
        if (rst) begin
            pcPlus4D <= `ZERO_WORD;
            instD <= `ZERO_WORD;
        end 
        else if(clr) begin
            pcPlus4D <= pcPlus4F;
            instD <= `ZERO_WORD;
        end 
        else if(en) begin
            pcPlus4D <= pcPlus4F;
            instD <= instF;
        end
    end
endmodule  
