module PCUpdate(
    input [63:0] PCaddress,
    input [3:0] icode,
    output reg [63:0] PCnext
);
    always @(*) begin
        case (icode)
            4'd0: PCnext = PCaddress; // halt
            4'd1: PCnext = PCaddress + 1; // nop
            4'd2: PCnext = PCaddress + 2; // rrmovq, cmovXX
            4'd3: PCnext = PCaddress + 10; // irmovq
            4'd4: PCnext = PCaddress + 10; // rmmovq
            4'd5: PCnext = PCaddress + 10; // mrmovq
            4'd6: PCnext = PCaddress + 2; // addq, subq, andq, xorq
            4'd7: PCnext = PCaddress + 9; // jmp, jXX
            4'd8: PCnext = PCaddress + 9; // call
            4'd9: PCnext = PCaddress + 1; // ret
            4'd10: PCnext = PCaddress + 2; // pushq
            4'd11: PCnext = PCaddress + 2; // popq
        endcase
    end
endmodule