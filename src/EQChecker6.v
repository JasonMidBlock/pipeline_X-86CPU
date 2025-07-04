module EQChecker6( ina, inb, iseq );
  input[5:0] ina, inb;
  output iseq;
  
  assign iseq = (ina == inb) ? 1 : 0;
  
endmodule