module Regs (
    input clk,
    input Cnd,
    input [3:0] icode,
    input [3:0] rA,
    input [3:0] rB,
    input [63:0] valE,
    input [63:0] valM,
    output reg [63:0] valA,
    output reg [63:0] valB
);
    reg [63:0] Register[0:15];

    always @(icode or valA or valB) begin
        case (icode)
            4'h2: valA = Register[rA];
            4'h5: valB = Register[rB];
            4'h4, 4'h6: begin
                valA = Register[rA];
                valB = Register[rB];
            end
            4'h8, 4'h9, 4'hA, 4'hB: valA = Register[4];  // %rsp
            default: begin
                valA = {64{1'bx}};
                valB = {64{1'bx}};
            end
        endcase
    end

    always @(posedge clk) begin
        case (icode)
            4'h2: Register[rB] <= valE;  // rrmovq, cmovXX
            4'h3: Register[rB] <= valE;  // irmovq
            4'h5: Register[rA] <= valM;  // mrmovq
            4'h6: Register[rB] <= valE;  // addq, subq, andq, xorq
            4'hB: Register[rA] <= valM;  // popq
        endcase
    end
endmodule
