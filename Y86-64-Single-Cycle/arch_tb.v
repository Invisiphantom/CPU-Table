module arch_tb;
    reg  clk;

    arch arch_inst (
        .clk(clk)
    );

    initial begin
        $monitor("%d", arch_tb.arch_inst.PCaddress);
        $monitor("%d", arch_tb.arch_inst.u_Regs.rax);
        repeat (100) begin
            clk = 0;
            #5;
            clk = 1;
            #5;
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule