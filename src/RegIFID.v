module RegIFID( clk, rst, en_reg, flush, pcin, instrin, pcout, instrout );
  input clk, rst, en_reg, flush;
  input [31:0] pcin, instrin;
  output [31:0] pcout, instrout;
  reg [31:0] pcout, instrout;

  always @( posedge clk ) 
    begin
      if ( rst || flush ) 
      begin
			  pcout <= 32'b0;
			  instrout <= 32'b0;
		  end
      else if ( en_reg )
      begin
			  pcout <= pcin;
			  instrout <= instrin;
			end 
  end

  // when (IFID)flush enable means branch(PC+4 don't care), squash instruction

  
endmodule