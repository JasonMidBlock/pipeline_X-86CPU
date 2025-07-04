`timescale 1ns/1ns
module HILO( clk, rst, Signal, MUTAns, HiOut, LoOut );
input clk ;
input rst ;
input [1:0] Signal;
input [63:0] MUTAns ;
output [31:0] HiOut ;
output [31:0] LoOut ;

reg [63:0] HiLo ;

always@( negedge clk or rst )
begin
  if( rst )
    HiLo = 64'b0;
  else
  begin
    if( Signal == 2'b01 )
      HiLo = MUTAns ;
    else if( Signal == 2'b10 )
      HiLo = HiLo + MUTAns;
  end
end

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;

endmodule