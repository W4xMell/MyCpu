`include "defines.v"

module inst_rom(
    //input  wire         en,
    input  wire[31:0]   addr,
    output reg[31:0]    inst
);

    reg [31:0] inst_mem[0:131070];

    initial $readmemh ("C:/Users/Lyc03/Desktop/cpu/inst_rom.data",inst_mem);

    //assign inst = inst_mem[addr[`INST_WIDTH+1:2]];
    always @(*) begin
        // if(en) begin
        //     inst <= 32'b0;
        // end
        // else begin
        //     //鎸囦护瀵勫瓨鍣ㄧ殑姣忎釜鍦板潃锟�?32bit鐨勫瓧锛屾墍浠ヨ灏哋penMips缁欏嚭鐨勬寚浠ゅ湴锟�?闄や互4鍐嶄娇锟�?
        //     inst <= inst_mem[addr[`INST_WIDTH+1:2]];
        // end
        inst <= inst_mem[addr[`INST_WIDTH+1:2]];
    end

endmodule