module regLocker( isMult, Multend, enReg, rst );
  input isMult, Multend, rst;
  output enReg;
  reg enReg;
  
  always@( rst )
  begin
    enReg = 1;
  end
  
  always@( isMult or Multend )
  begin
    if ( rst )
      enReg = 1;
    else
    begin
      if( isMult && !Multend )
        enReg = 0;
      else
        enReg = 1;
    end
  end
  

endmodule