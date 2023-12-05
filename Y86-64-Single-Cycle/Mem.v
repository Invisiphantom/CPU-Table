module Mem (
    input memWrite,
    input memRead,
    input [63:0] memAddr,
    input [63:0] memData,
    output reg [63:0] valM
);
    reg [63:0] mem[0:511];
    always @(*) begin
        if (memRead == 1'b1) valM = mem[memAddr];
        else if (memWrite == 1'b1) mem[memAddr] = memData;
    end
endmodule
