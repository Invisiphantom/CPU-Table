module PC (
    input        clk,
    input [ 3:0] pIcode,
    input [ 3:0] pIfun,
    input [ 1:0] pCnd,
    input [63:0] pValM,
    input [63:0] pValC,
    input [63:0] pValP
);

    reg [63:0] PCaddress;
    initial PCaddress = {64{1'b0}};

    always @(posedge clk) begin
        case (pIcode)
            4'd0: PCaddress = PCaddress; // halt
            4'd1: PCaddress = PCaddress + 1; // nop
            4'd2: PCaddress = PCaddress + 2; // rrmovq, cmovXX
            4'd3: PCaddress = PCaddress + 10; // irmovq
            4'd4: PCaddress = PCaddress + 10; // rmmovq
            4'd5: PCaddress = PCaddress + 10; // mrmovq
            4'd6: PCaddress = PCaddress + 2; // addq, subq, andq, xorq
            4'd7: PCaddress = pCnd ? pValC : PCaddress + 9; // jmp, jXX
            4'd8: PCaddress = PCaddress + 9; // call
            4'd9: PCaddress = PCaddress + 1; // ret
            4'd10: PCaddress = PCaddress + 2; // pushq
            4'd11: PCaddress = PCaddress + 2; // popq
        endcase
    end
endmodule
