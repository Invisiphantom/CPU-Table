module Mem (
    input memWrite,
    input memRead,
    input [63:0] memAddr,
    input [63:0] memData,
    output reg [63:0] valM
);
    // 小端法读写数据
    reg [7:0] mem[0:1023];
    initial $readmemh("/home/ethan/CPU-Table/Y86-64-Single-Cycle/ROM.txt", mem);

    always @(*) begin
        if (memRead == 1'b1)
            valM <= {
                mem[memAddr+7],
                mem[memAddr+6],
                mem[memAddr+5],
                mem[memAddr+4],
                mem[memAddr+3],
                mem[memAddr+2],
                mem[memAddr+1],
                mem[memAddr]
            };
        else if (memWrite == 1'b1)
            {mem[memAddr + 7], mem[memAddr + 6], mem[memAddr + 5], mem[memAddr + 4], mem[memAddr + 3], mem[memAddr + 2], mem[memAddr + 1], mem[memAddr]} <= memData;
    end
endmodule
