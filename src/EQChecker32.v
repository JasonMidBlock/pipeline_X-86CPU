module EQChecker32( ina, inb, iseq, rst );
  input[31:0] ina, inb;
  input rst;
  output iseq;
  reg iseq;
  
  always@( ina or inb or rst )
  begin
    if( rst )
      iseq = 1'b0;
    else
    begin  
      if( ina == inb )
        iseq = 1'b1;
      else
        iseq = 1'b0;
    end
  end

  
endmodule