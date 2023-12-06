module Stat (
    input [3:0] icode,  // HLT
    input instr_valid,
    input imem_error,
    input dmem_error,
    output [1:0] stat
);
    assign stat = (icode == 4'h0) ? 2'h2 : 2'h1;
endmodule
