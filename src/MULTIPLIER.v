`timescale 1ns/1ns
module MULTIPLIER( clk, start, reset, dataA, dataB, Signal, dataOut );
input clk ;
input reset ;
input start;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output [63:0] dataOut ;

reg [63:0] product ;
reg [63:0] multiplicand;
reg [31:0] multiplier;

always@( posedge clk or reset )
begin
  if( reset )
  begin
    product = 0;
    multiplicand = 0;
    multiplier = 0;
  end
  
  if( (start == 1 && Signal == 6'b011001) || (start == 1 && Signal == 6'b000001) ) // put input into MCND and MPY in round 0 and reset product
  begin
    product = 0;
    multiplicand = { 32'h00000000, dataA[31:0] };
    multiplier = dataB;
    
  end
  
  if( Signal == 6'b011001 || Signal == 6'b000001 )
    begin
      
      if( multiplier[0] == 1 ) // test MPY0 = 1
      begin
        product = product + multiplicand;
      end
      
      multiplicand = multiplicand << 1; // shift MCND 1 bit
      multiplier = multiplier >> 1; // shift MPY 1 bit
      
    end
    
  
end

assign dataOut = product; // answer is the product after 32 rounds(but the HILO would open only after 32 round happened)

endmodule