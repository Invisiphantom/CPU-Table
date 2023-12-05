module ALU_fun (
    input [3:0] icode,
    input [3:0] ifun,
    output reg [1:0] aluFun
);
    always @(*) begin
        case (icode)
            4'h2, 4'h3, 4'h4, 4'h5: aluFun = 2'b00;
            4'h6: aluFun = ifun;
        endcase
    end
endmodule
