module Regs (
    input clk,
    input Cnd,
    input [3:0] icode,
    input [3:0] rA,
    input [3:0] rB,
    input [63:0] valE,
    input [63:0] valM,
    output reg [63:0] valA,
    output reg [63:0] valB,
    output [63:0] rax,
    output [63:0] rcx,
    output [63:0] rdx,
    output [63:0] rbx,
    output [63:0] rsp,
    output [63:0] rbp,
    output [63:0] rsi,
    output [63:0] rdi,
    output [63:0] r8,
    output [63:0] r9,
    output [63:0] r10,
    output [63:0] r11,
    output [63:0] r12,
    output [63:0] r13,
    output [63:0] r14
);
    reg [63:0] Register[0:15];

    always @(*) begin
        case (icode)
            4'h2, 4'h5, 4'h4, 4'h6: begin
                valA <= Register[rA];
                valB <= Register[rB];
            end
            4'h8, 4'h9, 4'hA, 4'hB: valA <= Register[4];  // %rsp
            default: begin
                valA <= {64{1'bx}};
                valB <= {64{1'bx}};
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

    assign rax = Register[0];
    assign rcx = Register[1];
    assign rdx = Register[2];
    assign rbx = Register[3];
    assign rsp = Register[4];
    assign rbp = Register[5];
    assign rsi = Register[6];
    assign rdi = Register[7];
    assign r8  = Register[8];
    assign r9  = Register[9];
    assign r10 = Register[10];
    assign r11 = Register[11];
    assign r12 = Register[12];
    assign r13 = Register[13];
    assign r14 = Register[14];
endmodule
