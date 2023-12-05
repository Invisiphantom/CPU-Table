module InstMemory (
    input      [63:0] PCaddress,
    output reg [ 3:0] icode,
    output reg [ 3:0] ifun,
    output reg [ 3:0] rA,
    output reg [ 3:0] rB,
    output reg [63:0] valC
);

    reg [7:0] inst_mem[0:1023];  // 最多能存 1024 字节的指令
    // 只能用绝对路径
    initial $readmemh("/home/ethan/CPU-Table/Y86-64-Single-Cycle/ROM.txt", inst_mem);

    wire [79:0] instruction;
    assign instruction[79:0] = {inst_mem[PCaddress], 72'b0};

    always @(*) begin
        icode = instruction[79:76]; // 4 bits
        ifun  = instruction[75:72]; // 4 bits
        rA    = instruction[71:68]; // 4 bits
        rB    = instruction[67:64]; // 4 bits
        valC  = instruction[63:0]; // 64 bits
    end
endmodule
