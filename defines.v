`define INST_WIDTH 15
`define DATA_NUM 131071
`define ZERO_WORD  32'h00000000

`define EXE_ADD 6'b100000
`define EXE_ADDI 6'b001000
`define EXE_SUB 6'b100010
`define EXE_OR  6'b100101
`define EXE_AND 6'b100100
`define EXE_SLT 6'b101010
`define EXE_SLTI 6'b001010
`define EXE_XOR  6'b100110

`define EXE_BEQ 6'b000100
`define EXE_BNE 6'b000101
`define EXE_BGL 6'b000001
`define EXE_BGTZ 6'b000111
`define BLTZ    5'b00000
`define EXE_J   6'b000010 

`define EXE_LW  6'b100011
`define EXE_SW  6'b101011


`define  FALSE       1'b0
`define  TRUE        1'b1
`define  BRAN_BEQ    4'b0001 
`define  BRAN_BNE    4'b0010
`define  BRAN_BGEZ   4'b0011
`define  BRAN_BGTZ   4'b0100
`define  BRAN_BLEZ   4'b0101
`define  BRAN_BLTZ   4'b0110
`define  BRAN_J      4'b0111
 
`define  ALU_AND    4'b0000
`define  ALU_OR     4'b0001
`define  ALU_XOR    4'b0010
`define  ALU_ADD    4'b0011
`define  ALU_SUB    4'b1011
`define  ALU_SLT    4'b1111


`define  REG_WRITE_T     1'b1
`define  MEM_TO_REG_T     1'b1
`define  MEM_WRITE_T     1'b1
`define  ALU_SRC_T     1'b1
`define  REG_DST_T     1'b1 
`define  BRANCH_T      1'b1
`define  JUMP_T        1'b1

`define  REG_WRITE_F     1'b0
`define  MEM_TO_REG_F     1'b0
`define  MEM_WRITE_F     1'b0
`define  ALU_SRC_F     1'b0
`define  REG_DST_F     1'b0 
`define  BRANCH_F      1'b0
`define  JUMP_F        1'b0