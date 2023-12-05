module ALU_A (
    input [3:0] icode,
    input [63:0] valC,  // irmovq, rmmovq, mrmovq
    input [63:0] valA,  // rrmovq, cmovXX, ops
    output reg [63:0] aluA
);
    always @(*) begin
        case (icode)
            4'h3, 4'h4, 4'h5: aluA = valC;
            4'h2, 4'h6: aluA = valA;
            default: aluA = {64{1'b0}};
        endcase
    end
endmodule
