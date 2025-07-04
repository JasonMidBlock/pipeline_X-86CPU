`timescale 1ns/1ns
module ALUControl( clk, Signal, reset, SelectALU, BinALU, SignaltoMULT, SelectMUX, startMULT, opcode, Multend, openHILO );
input clk ;
input reset;
input [5:0] Signal, opcode ;
output Multend;
reg Multend;
output [1:0] openHILO;
output [1:0] SelectALU ;
output BinALU; // Bit Invert
output [5:0] SignaltoMULT ;
output [1:0] SelectMUX ;
output startMULT;

//   Signal (6-bits) (opcode == 0)
//   AND  :  36  100100
//   OR   :  37  100101
//   ADD  :  32  100000
//   SUB  :  34  100010
//   SRL  :  2   000010
//   SLT  :  42  101010
//   MULTU : 25  011001

//   MFHI :  16  010000;
//   MFLO :  18  010010;
//   NOP  :  0   000000;

//   opcode (6-bits)
//   addiu : 9   001001;
//   beq  :  4   000100;
//   lw   :  35  100011;
//   sw   :  43  101011;

//   maddu : 28  011100; (func = 1)

//   j    :  2   000010;

reg BinALU;
reg [1:0] SelectALU;
reg [1:0] SelectMUX;
reg [5:0] temp ; // use to transfer the signal
reg [6:0] counter;
reg start ; // start set the MULT 

reg [1:0] HILOOP;

always@( posedge clk or reset ) // when the clock rise assign the signal to every submodels( if signal is mult, start counting till 32 round )
begin
  temp = Signal ;
  if ( reset )
  begin
    HILOOP = 2'b00;
    counter = 0;
    Multend = 1'b0;
  end
  
  HILOOP = 2'b00;
  if ( opcode == 6'd0 )
  begin    
    if ( Signal == 6'b011001 ) // count for Mutiplier
    begin
      if ( counter == 0 ) // when counter = 0 restart the mutiplier
        start = 1'b1;
      else
        start = 1'b0;
      
      counter = counter + 1 ;
      Multend = 1'b0;
      if ( counter == 32 )
      begin
        HILOOP = 2'b01;
        temp = 6'b111111 ; // Open HiLo reg for MULT
        Multend = 1'b1;
        counter = 0 ;
      end
    end
  end // opcode = 0
  else if( opcode == 6'd28 ) // maddu
  begin
    if ( Signal == 6'b000001 )
    begin
      if ( counter == 0 ) // when counter = 0 restart the mutiplier
        start = 1'b1;
      else
        start = 1'b0;
      
      counter = counter + 1 ;
      Multend = 1'b0;
      if ( counter == 32 )
      begin
        HILOOP = 2'b10;
        Multend = 1'b1;
        temp = 6'b111111 ; // Open HiLo reg for MULTADD
        counter = 0 ;
      end  
    end
  end
end


always@( opcode or Signal )
begin
  if ( opcode == 6'd0 )
  begin
    // decode for MUX
    if ( Signal == 6'b100100 || Signal == 6'b100101 || Signal == 6'b100000 || Signal == 6'b100010 || Signal == 6'b101010 )
      SelectMUX = 2'b00;
    else if ( Signal == 6'b000010 ) // shift
      SelectMUX = 2'b11;
    else if ( Signal == 6'b010000 ) // mfhi
      SelectMUX = 2'b01;
    else if ( Signal == 6'b010010 ) // mflo
      SelectMUX = 2'b10;
    else if ( Signal == 6'b000000 ) // nop
      SelectMUX = 2'b00;
    
    //  //  //  //  //  //  //  //  //  //  //  //
  
    if ( Signal == 6'b100100 ) // decode for ALU
      SelectALU = 2'b00;
    else if ( Signal == 6'b100101 )
      SelectALU = 2'b01;
    else if ( Signal == 6'b100000 || Signal == 6'b100010 ) // add, sub choose FAS
    begin
      SelectALU = 2'b10;
      if ( Signal == 6'b100010 )
        BinALU = 1'b1;
      else
        BinALU = 1'b0;
    end
    else if( Signal == 6'b101010 ) // slt
    begin
      SelectALU = 2'b11;
      BinALU = 1'b1; // use FAS 
    end
    else if( Signal == 6'b000000 ) // nop
    begin
      SelectALU = 2'b00;
      BinALU = 1'b0;
    end
  end
  else if( opcode == 6'd9 || opcode == 6'd35 || opcode == 6'd43 ) // addiu, lw ,sw TotalALU do "add"
  begin
    SelectALU = 2'b10;
    BinALU = 1'b0;
    SelectMUX = 2'b00;
  end
  else if( opcode == 6'd2 ) // j TotalALU is don't care( done by other hardware )
  begin
    SelectALU = 2'b00;
    BinALU = 1'b0;
    SelectMUX = 2'b00;  
  end
  else if( opcode == 6'd4 ) // beq TotalALU is sub
  begin
    SelectALU = 2'b10;
    BinALU = 1'b1;
    SelectMUX = 2'b00;
  end
    
end

assign openHILO = HILOOP;
assign SignaltoMULT = temp ;
assign startMULT = start;

endmodule