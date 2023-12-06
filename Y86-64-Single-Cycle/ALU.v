module ALU (
    input [3:0] icode,
    input [1:0] aluFun,
    input [63:0] aluA,
    input [63:0] aluB,
    output reg [63:0] valE,
    output reg ZF,
    output reg SF,
    output reg OF
);
    initial begin
        valE = 64'b0;
        ZF   = 1'b1;
        SF   = 1'b0;
        OF   = 1'b0;
    end

    always @(*) begin
        case (aluFun)
            2'b00: valE = aluB + aluA;
            2'b01: valE = aluB - aluA;
            2'b10: valE = aluB & aluA;
            2'b11: valE = aluB ^ aluA;
        endcase
    end

    always @(*) begin
        case (icode)
            4'h6: begin
                ZF <= (valE == 64'b0) ? 1'b1 : 1'b0;
                SF <= (valE[63] == 1) ? 1'b1 : 1'b0;
                OF <= (aluA[63] == aluB[63] && aluA[63] != valE[63]) ? 1'b1 : 1'b0;
            end
            default: begin
                ZF <= ZF;
                SF <= SF;
                OF <= OF;
            end
        endcase
    end
endmodule
