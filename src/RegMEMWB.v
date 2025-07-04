module RegMEMWB( clk, rst, en_reg, MemtoRegin, RegWritein
                                 , MEMResultin, ALUResultin, rdin
                                 , MemtoRegout, RegWriteout
                                 , MEMResultout, ALUResultout, rdout );
  // basic need
  input clk, rst, en_reg;
  
  // WB stage ctrl
  input MemtoRegin, RegWritein;
  output MemtoRegout, RegWriteout;
  reg MemtoRegout, RegWriteout;
  
  // data transfer
  input [31:0] MEMResultin, ALUResultin;
  input [4:0] rdin;
  output [31:0] MEMResultout, ALUResultout;
  output [4:0] rdout;
  reg [31:0] MEMResultout, ALUResultout;
  reg [4:0] rdout;
  
  always @( posedge clk ) 
    begin
    if ( rst )
      begin
			  MemtoRegout <= 1'b0;
			  RegWriteout <= 1'b0;
			  MEMResultout <= 32'b0;
			  ALUResultout <= 32'b0;
			  rdout <= 5'b0;
			end
    else if ( en_reg )
      begin
			  MemtoRegout <= MemtoRegin;
			  RegWriteout <= RegWritein;
			  MEMResultout <= MEMResultin;
			  ALUResultout <= ALUResultin;
			  rdout <= rdin;
			end
    end

  
endmodule