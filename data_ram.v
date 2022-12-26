//designer:david
//date:2021.8.1
`include "defines.v"

module data_ram(
    input  wire        clk,
    input  wire        we,
    input  wire[31:0]  addr,
    input  wire[31:0]  dataI,
    output reg[31:0]   dataO
);

    reg[31:0] dataMem[0:`DATA_NUM-1];

    always @(posedge clk) begin
        if(we) begin
            dataMem[addr[18:2]] = dataI;
        end
    end

    always @(*) begin
        if(we == 1'b0) begin
            dataO = dataMem[addr[18:2]];
        end
        else begin
            dataO = 32'b0;
        end
    end

endmodule