`timescale 1ns/1ns
module TotalALU( clk, reset, dataA, dataB, Signal, Output, opcode, Multend );
input clk, reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal, opcode ;
output [31:0] Output ;
output Multend;

//   Signal (6-bits)
//   AND  :  36  100100
//   OR   :  37  100101
//   ADD  :  32  100000
//   SUB  :  34  100010
//   SRL  :  2   000010
//   SLT  :  42  101010
//   MULTU : 25  011001

wire [31:0] temp ;

wire [1:0]  SelectALU ;
wire BinALU; // binvert
wire startMULT;
wire [5:0]  SignaltoMULT ;
wire [1:0]  SelectMUX ;
wire [31:0] ALUOut, HiOut, LoOut, ShifterOut ;
wire [31:0] dataOut ;
wire [63:0] MultAns ;
wire grd; // ground for carry out of ALU
wire [1:0] openHILO;

ALUControl alucontrol( .clk(clk), .Signal(Signal), .reset(reset), .SelectALU(SelectALU), .BinALU(BinALU), .SignaltoMULT(SignaltoMULT)
                       , .SelectMUX(SelectMUX), .startMULT(startMULT), .opcode(opcode), .Multend(Multend), .openHILO(openHILO) );
ALU32 alu32( .ina(dataA), .inb(dataB), .ctrl(SelectALU), .bin(BinALU), .cout(grd), .result(ALUOut) );
MULTIPLIER multiplier( .clk(clk), .reset(reset), .start(startMULT), .dataA(dataA), .dataB(dataB), .Signal(Signal), .dataOut(MultAns) );
BSHIFTERR32 shifter( .in(dataB), .amount(dataA), .ans(ShifterOut) );
HILO hilo( .clk(clk), .Signal(openHILO), .MUTAns(MultAns), .HiOut(HiOut), .LoOut(LoOut), .rst(reset) );
MUX4to132 mux4to1( .zero(ALUOut), .one(HiOut), .two(LoOut), .three(ShifterOut), .select(SelectMUX), .zout(dataOut));

assign Output = dataOut ;


endmodule