module TotalPipeline( clk, rst );
  input clk, rst;
  
  // IF
  wire [31:0] nextPC, PCvalue, PCincrIF, instrIF;

  wire [31:0] PCSrcans;
  wire [5:0] opcode;
  wire PCSrc, IFflush;
  // IF
  
  // ID
  wire IDFlush, enPC, enIFID;
  
  wire [31:0] PCincrID, instrID;
  wire [5:0] opcodeID, funcID;
  wire [4:0] rsID, rtID, rdID, shamt;
  wire [31:0] extend_shamtID;
  wire [15:0] immed;
  wire [31:0] extend_immedID, extend_immedIDshift, branchTargetID;
  
  wire [31:0] regValue1ID, regValue2ID;
  
  wire isBranch, isj;
  wire isBranchID, isjID;
  wire MemtoRegtoMUX, RegWritetoMUX, MemReadtoMUX, MemWritetoMUX, RegDsttoMUX;
  wire ALUSrctoMUX, ALUSrcID;
  wire MemtoRegID, RegWriteID, MemReadID, MemWriteID, RegDstID;
  wire [5:0] opcodetoMUX, functoMUX;
  wire [5:0] opcodetoctrl, functoctrl;
  
  wire NotShtID, NotShttoMUX, isMulttoMUX;
  wire isMultID;
  
  wire PCWrite, IFIDWrite, blockinstr;
  
  wire [26:0] jumpoffset;
  wire [28:0] jumpoffsetshift;
  wire [3:0] PCincrup4;
  wire [31:0] jumpaddrID;
  // ID
  
  // EX
  wire [5:0] opcodeEX, funcEX;
  wire MemtoRegEX, RegWriteEX, MemReadEX, MemWriteEX, RegDstEX, isBranchEX, isjEX;
  wire ALUSrcEX;
  wire iseqEX;
  
  wire [31:0] jumpaddrEX, branchTargetEX;
  
  wire [31:0] extend_shamtEX;
  wire [31:0] regValue1EX, regValue2EX, extend_immedEX, ALUansEX;
  wire [31:0] ALUSrcans;
  wire [4:0] rsEX, rtEX, rdEX, RegDstans;
  
  wire isMultEX;
  wire Multend;
  wire enreg;
  
  wire NotShtEX;
  wire [31:0]ALUShtans;
  
  wire [1:0] fowarda, fowardb;
  wire [31:0] fowardaans, fowardbans;
  // EX
  
  // MEM
  wire MemtoRegMEM, RegWriteMEM, MemReadMEM, MemWriteMEM;
  wire [31:0] ALUansMEM, MEMansMEM, regValue2MEM;
  wire [4:0] rdMEM;
  // MEM
  
  // WB
  wire MemtoRegWB, RegWriteWB;
  wire [31:0] ALUansWB, MEMansWB, MemtoRegans;
  wire [4:0] rdWB;
  // WB
  
  // module instantiations
  // IF
  reg32 PC( .clk(clk), .rst(rst), .en_reg(enPC), .d_in(nextPC), .d_out(PCvalue) );
  add32 PCADD( .a(PCvalue), .b(32'b00000000000000000000000000000100), .result(PCincrIF) );
  memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(PCvalue), .rd(instrIF) );
  and BranchAND( PCSrc, isBranchEX, iseqEX );
  or FlushOR( IFflush, isjEX, PCSrc );
  assign IDflush = IFflush;
  assign opcode = instrIF[31:26];
  mux2 #(32) JMUX( .sel(isjEX), .a(PCSrcans), .b(jumpaddrEX), .y(nextPC) );
  mux2 #(32) BranchMUX( .sel(PCSrc), .a(PCincrIF), .b(branchTargetEX), .y(PCSrcans) );
  and PCand( enPC, PCWrite, enreg );
  // IF
  
  and  IFIDand( enIFID, IFIDWrite, enreg );
  RegIFID regIFID( .clk(clk), .rst(rst), .en_reg(enIFID), .flush(IFflush), .pcin(PCincrIF), .instrin(instrIF), .pcout(PCincrID), .instrout(instrID) );
  
  // ID
  assign opcodetoctrl = instrID[31:26];
  assign rsID = instrID[25:21];
  assign rtID = instrID[20:16];
  assign rdID = instrID[15:11];
  assign shamt = instrID[10:6];
  assign functoctrl = instrID[5:0];
  assign immed = instrID[15:0];
  assign jumpoffset = instrID[25:0];
  assign jumpoffsetshift = jumpoffset << 2;
  assign PCincrup4 = PCincrID[31:28];
  assign jumpaddrID = { PCincrup4, jumpoffsetshift };
  HazardDetectionUnit hazarddetectionunit( .rsIFID(rsID), .rtIFID(rtID), .rtIDEX(rtEX), .MemReadIDEX(MemReadEX), .PCWrite(PCWrite), .IFIDWrite(IFIDWrite), .blockinstr(blockinstr), .rst(rst) );
  ControlUnit controlunit( .opin(opcodetoctrl), .funcin(functoctrl), .isBranch(isBranch), .MemtoReg(MemtoRegtoMUX), .RegWrite(RegWritetoMUX), .MemRead(MemReadtoMUX)
                           , .MemWrite(MemWritetoMUX), .ALUSrc(ALUSrctoMUX), .RegDst(RegDsttoMUX), .opout(opcodetoMUX), .funcout(functoMUX), .rst(rst), .isj(isj), .NotSht(NotShttoMUX), .isMult(isMulttoMUX) );
  mux2 #(6) blockop( .sel(blockinstr), .a(opcodetoMUX), .b(6'b0), .y(opcodeID) );
  mux2 #(6) blockfunc( .sel(blockinstr), .a(functoMUX), .b(6'b0), .y(funcID) );
  mux2 #(1) blockMemtoReg( .sel(blockinstr), .a(MemtoRegtoMUX), .b(1'b0), .y(MemtoRegID) );
  mux2 #(1) blockRegWrite( .sel(blockinstr), .a(RegWritetoMUX), .b(1'b0), .y(RegWriteID) );
  mux2 #(1) blockMemRead( .sel(blockinstr), .a(MemReadtoMUX), .b(1'b0), .y(MemReadID) );
  mux2 #(1) blockMemWrite( .sel(blockinstr), .a(MemWritetoMUX), .b(1'b0), .y(MemWriteID) );
  mux2 #(1) blockALUSrc( .sel(blockinstr), .a(ALUSrctoMUX), .b(1'b0), .y(ALUSrcID) );
  mux2 #(1) blockRegDst( .sel(blockinstr), .a(RegDsttoMUX), .b(1'b0), .y(RegDstID) );
  mux2 #(1) blockisBranch( .sel(blockinstr), .a(isBranch), .b(1'b0), .y(isBranchID) );
  mux2 #(1) blockisj( .sel(blockinstr), .a(isj), .b(1'b0), .y(isjID) );
  mux2 #(1) blockNotSht( .sel(blockinstr), .a(NotShttoMUX), .b(1'b0), .y(NotShtID) );
  mux2 #(1) blockisMult( .sel(blockinstr), .a(isMulttoMUX), .b(1'b0), .y(isMultID) );
  sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immedID) );
  assign extend_shamtID = { 27'b0, shamt };
  assign extend_immedIDshift = extend_immedID << 2;
  add32 BRADD( .a(PCincrID), .b(extend_immedIDshift), .result(branchTargetID) );
  reg_file RegFile( .clk(clk), .RegWrite(RegWriteWB), .RN1(rsID), .RN2(rtID), .WN(rdWB), .WD(MemtoRegans), .RD1(regValue1ID), .RD2(regValue2ID) );
  // ID
  
  RegIDEX regIDEX( .clk(clk), .rst(rst), .en_reg(enreg), .MemtoRegin(MemtoRegID), .RegWritein(RegWriteID), .MemReadin(MemReadID), .MemWritein(MemWriteID), .ALUSrcin(ALUSrcID), .RegDstin(RegDstID), .opin(opcodeID), .funcin(funcID)
                                , .RD1in(regValue1ID), .RD2in(regValue2ID), .immin(extend_immedID), .rsin(rsID), .rtin(rtID), .rdin(rdID), .shamtin(extend_shamtID), .isBranchin(isBranchID), .isjin(isjID), .jumpaddrin(jumpaddrID), .branchtargin(branchTargetID), .NotShtin(NotShtID), .isMultin(isMultID)
                                , .MemtoRegout(MemtoRegEX), .RegWriteout(RegWriteEX), .MemReadout(MemReadEX), .MemWriteout(MemWriteEX), .ALUSrcout(ALUSrcEX), .RegDstout(RegDstEX), .opout(opcodeEX), .funcout(funcEX)
                                , .RD1out(regValue1EX), .RD2out(regValue2EX), .immout(extend_immedEX), .rsout(rsEX), .rtout(rtEX), .rdout(rdEX), .shamtout(extend_shamtEX), .isBranchout(isBranchEX), .isjout(isjEX), .jumpaddrout(jumpaddrEX), .branchtargout(branchTargetEX), .NotShtout(NotShtEX), .isMultout(isMultEX)
                                , .flush(IDflush) );
  
  // EX
  regLocker reglocker( .isMult(isMultEX), .Multend(Multend), .enReg(enreg), .rst(rst) );
  mux2 #(32) ALUShtMUX( .sel(NotShtEX), .a(extend_shamtEX), .b(regValue1EX), .y(ALUShtans) );
  mux2 #(32) ALUSrcMUX( .sel(ALUSrcEX), .a(extend_immedEX), .b(regValue2EX), .y(ALUSrcans) );
  MUX4to132 fowardMUXa( .zero(ALUShtans), .one(MemtoRegans), .two(ALUansMEM), .three(32'bx), .select(fowarda), .zout(fowardaans) );
  MUX4to132 fowardMUXb( .zero(ALUSrcans), .one(MemtoRegans), .two(ALUansMEM), .three(32'bx), .select(fowardb), .zout(fowardbans) );
  TotalALU totalALU( .clk(clk), .reset(rst), .dataA(fowardaans), .dataB(fowardbans), .Signal(funcEX), .Output(ALUansEX), .opcode(opcodeEX), .Multend(Multend) );
  zerochecker isZero( .target(ALUansEX), .iszero(iseqEX) );
  mux2 #(5) RegDstMUX( .sel(RegDstEX), .a(rdEX), .b(rtEX), .y(RegDstans) );
  FowardingUnit fowardingunit( .rsIDEX(rsEX), .rtIDEX(rtEX), .rdEXMEM(rdMEM), .RegWriteEXMEM(RegWriteMEM), .rdMEMWB(rdWB), .RegWriteMEMWB(RegWriteWB), .fowarda(fowarda), .fowardb(fowardb), .ALUSrcIDEX(ALUSrcEX), .NotShtIDEX(NotShtEX) );
  // EX
  
  RegEXMEM regEXMEM( .clk(clk), .rst(rst), .en_reg(enreg), .MemtoRegin(MemtoRegEX), .RegWritein(RegWriteEX), .MemReadin(MemReadEX), .MemWritein(MemWriteEX)
                                 , .ALUResultin(ALUansEX), .RD2in(regValue2EX), .rdin(RegDstans)
                                 , .MemtoRegout(MemtoRegMEM), .RegWriteout(RegWriteMEM), .MemReadout(MemReadMEM), .MemWriteout(MemWriteMEM)
                                 , .ALUResultout(ALUansMEM), .RD2out(regValue2MEM), .rdout(rdMEM) );
  
  // MEM
  memory DatMem( .clk(clk), .MemRead(MemReadMEM), .MemWrite(MemWriteMEM), .wd(regValue2MEM), .addr(ALUansMEM), .rd(MEMansMEM) );
  // MEM

  RegMEMWB regMEMWB( .clk(clk), .rst(rst), .en_reg(enreg), .MemtoRegin(MemtoRegMEM), .RegWritein(RegWriteMEM)
                                 , .MEMResultin(MEMansMEM), .ALUResultin(ALUansMEM), .rdin(rdMEM)
                                 , .MemtoRegout(MemtoRegWB), .RegWriteout(RegWriteWB)
                                 , .MEMResultout(MEMansWB), .ALUResultout(ALUansWB), .rdout(rdWB) );
  
  // WB
  mux2 #(32) WRMUX( .sel(MemtoRegWB), .a(ALUansWB), .b(MEMansWB), .y(MemtoRegans) );
  // WB

endmodule