module MemControl (
    input [3:0] icode,
    output memWrite,
    output memRead
);
    assign memWrite = (icode == 4'h4) ? 1'b1 : 1'b0;
    assign memRead  = (icode == 4'h5) ? 1'b1 : 1'b0;
endmodule
