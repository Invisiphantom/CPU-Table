module arch (
    input clk
);

    wire pCnd;
    wire [3:0] pIcode;
    wire [63:0] pValC;
    wire [63:0] pValP;
    wire [63:0] pValM;
    wire [63:0] PCaddress;
    PC u_PC (
        .clk      (clk),
        .pIcode   (pIcode),
        .pCnd     (pCnd),
        .pValC    (pValC),
        .pValP    (pValP),
        .pValM    (pValM),
        .PCaddress(PCaddress)
    );

    wire [ 3:0] icode;
    wire [ 3:0] ifun;
    wire [ 3:0] rA;
    wire [ 3:0] rB;
    wire [63:0] valC;
    assign pIcode = icode;
    assign pValC  = valC;
    InstMemory u_InstMemory (
        .PCaddress(PCaddress),
        .icode    (icode),
        .ifun     (ifun),
        .rA       (rA),
        .rB       (rB),
        .valC     (valC)
    );


    wire [63:0] valP;
    assign pValP = valP;
    PCIncre u_PCIncre (
        .icode    (icode),
        .PCaddress(PCaddress),
        .valP     (valP)
    );

    wire Cnd;
    wire [63:0] valE;
    wire [63:0] valM;
    wire [63:0] valA;
    wire [63:0] valB;
    assign pCnd = Cnd;
    Regs u_Regs (
        .clk  (clk),
        .Cnd  (Cnd),
        .icode(icode),
        .rA   (rA),
        .rB   (rB),
        .valE (valE),
        .valM (valM),
        .valA (valA),
        .valB (valB)
    );


    wire [1:0] aluFun;
    ALU_fun u_ALU_fun (
        .icode (icode),
        .ifun  (ifun),
        .aluFun(aluFun)
    );

    wire [63:0] aluA;
    ALU_A u_ALU_A (
        .icode(icode),
        .valC (valC),
        .valA (valA),
        .aluA (aluA)
    );

    wire [63:0] aluB;
    ALU_B u_ALU_B (
        .icode(icode),
        .valB (valB),
        .aluB (aluB)
    );

    wire ZF, SF, OF;
    ALU u_ALU (
        .aluFun(aluFun),
        .aluA  (aluA),
        .aluB  (aluB),
        .valE  (valE),
        .ZF    (ZF),
        .SF    (SF),
        .OF    (OF)
    );

    CC u_CC (
        .ifun(ifun),
        .ZF  (ZF),
        .SF  (SF),
        .OF  (OF),
        .Cnd (Cnd)
    );

    wire memWrite, memRead;
    MemControl u_MemControl (
        .icode   (icode),
        .memWrite(memWrite),
        .memRead (memRead)
    );

    wire [63:0] memAddr;
    MemAddr u_MemAddr (
        .icode  (icode),
        .valE   (valE),
        .valA   (valA),
        .memAddr(memAddr)
    );

    wire [63:0] memData;
    MemData u_MemData (
        .icode  (icode),
        .valP   (valP),
        .valA   (valA),
        .memData(memData)
    );

    Mem u_Mem (
        .memWrite(memWrite),
        .memRead (memRead),
        .memAddr (memAddr),
        .memData (memData),
        .valM    (valM)
    );
endmodule



module arch_tb;
    reg clk;

    arch arch_inst (.clk(clk));

    initial begin
        repeat (25) begin
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
