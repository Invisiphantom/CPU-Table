module ALU (
    input [1:0] aluFun,
    input [63:0] aluA,
    input [63:0] aluB,
    output reg [63:0] valE,
    output ZF,
    output SF,
    output OF
);
    always @(*) begin
        case (aluFun)
            2'b00: valE = aluB + aluA;
            2'b01: valE = aluB - aluA;
            2'b10: valE = aluB & aluA;
            2'b11: valE = aluB ^ aluA;
        endcase
    end

    assign ZF = (valE == 64'b0) ? 1'b1 : 1'b0;
    assign SF = (valE[63] == 1) ? 1'b1 : 1'b0;
    assign OF = (aluA[63] == aluB[63] && aluA[63] != valE[63]) ? 1'b1 : 1'b0;
endmodule
