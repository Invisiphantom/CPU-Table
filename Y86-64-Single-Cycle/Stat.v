module Stat (
    input [3:0] icode,  // HLT
    input instr_valid,
    input imem_error,
    input dmem_error,
    output reg [1:0] stat
);
    initial stat = 2'h1;
    always @(icode) begin
        #1;
        case (icode)
            4'h0: stat <= 2'h2;
            default: stat <= 2'h1;
        endcase
    end
endmodule
