module HazardDetectionUnit( rsIFID, rtIFID, rtIDEX, MemReadIDEX, PCWrite, IFIDWrite, blockinstr, rst );
  input rst;
  input MemReadIDEX;
  input [4:0] rsIFID, rtIFID, rtIDEX;
  output PCWrite, IFIDWrite, blockinstr;
  reg PCWrite, IFIDWrite, blockinstr;
  
  always@( rst )
  begin
    if(rst)
    begin
      blockinstr = 0;
      PCWrite = 1;
      IFIDWrite = 1;
    end
  end

  always@( MemReadIDEX or rsIFID or rtIFID or rtIDEX )
  begin
    blockinstr = (MemReadIDEX && ( (rsIFID == rtIDEX) || (rtIFID == rtIDEX) )) ? 1 : 0;
    PCWrite = !blockinstr;
    IFIDWrite = PCWrite;
  end

endmodule
