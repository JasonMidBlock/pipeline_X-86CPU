module zerochecker( target, iszero );
  input [31:0] target;
  output iszero;
  reg iszero;
  
  always@( target )
  begin
    if( target == 32'b0 )
      iszero = 1'b1;
    else
      iszero = 1'b0;
  end
  
endmodule