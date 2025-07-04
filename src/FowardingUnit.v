module FowardingUnit( rsIDEX, rtIDEX, rdEXMEM, RegWriteEXMEM, rdMEMWB, RegWriteMEMWB, fowarda, fowardb, ALUSrcIDEX, NotShtIDEX );
  input RegWriteEXMEM, RegWriteMEMWB;
  input ALUSrcIDEX, NotShtIDEX;
  input[4:0] rsIDEX, rtIDEX, rdEXMEM, rdMEMWB;
  output [1:0] fowarda, fowardb;
  reg [1:0]fowarda, fowardb;

  always@( rsIDEX or rtIDEX or rdEXMEM or RegWriteEXMEM or rdMEMWB or RegWriteMEMWB )
  begin
    // A foward
    if( RegWriteEXMEM && ( rdEXMEM != 0 ) && ( rdEXMEM == rsIDEX ) && (NotShtIDEX == 1'b1) )
      fowarda = 2'b10;
    else if( RegWriteMEMWB && ( rdMEMWB != 0 ) && ( rdMEMWB == rsIDEX ) && (NotShtIDEX == 1'b1) )
      fowarda = 2'b01;
    else
      fowarda = 2'b00;
      
    // B foward  
    if( RegWriteEXMEM && ( rdEXMEM != 0 ) && ( rdEXMEM == rtIDEX ) && (ALUSrcIDEX == 1'b1) )
      fowardb = 2'b10;
    else if( RegWriteMEMWB && ( rdMEMWB != 0 ) && ( rdMEMWB == rtIDEX ) && (ALUSrcIDEX == 1'b1) )
      fowardb = 2'b01;
    else
      fowardb = 2'b00;  
      
  end
  

endmodule
