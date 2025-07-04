module RegEXMEM( clk, rst, en_reg, MemtoRegin, RegWritein, MemReadin, MemWritein
                                 , ALUResultin, RD2in, rdin
                                 , MemtoRegout, RegWriteout, MemReadout, MemWriteout
                                 , ALUResultout, RD2out, rdout );
  // basic need
  input clk, rst, en_reg;
  
  // WB stage ctrl
  input MemtoRegin, RegWritein;
  output MemtoRegout, RegWriteout;
  reg MemtoRegout, RegWriteout;
  
  // MEM stage ctrl
  input MemReadin, MemWritein;
  output MemReadout, MemWriteout;
  reg MemReadout, MemWriteout;
  
  // data transfer
  input [31:0] ALUResultin, RD2in;
  input [4:0] rdin;
  output [31:0] ALUResultout, RD2out;
  output [4:0] rdout;
  reg [31:0] ALUResultout, RD2out;
  reg [4:0] rdout;
  
  always @( posedge clk ) 
    begin
    if ( rst )
      begin
			  MemtoRegout <= 1'b0;
			  RegWriteout <= 1'b0;
			  MemReadout <= 1'b0;
			  MemWriteout <= 1'b0;
			  ALUResultout <= 32'b0;
			  RD2out <= 32'b0;
			  rdout <= 5'b0;
			end
    else if ( en_reg )
      begin
			  MemtoRegout <= MemtoRegin;
			  RegWriteout <= RegWritein;
			  MemReadout <= MemReadin;
			  MemWriteout <= MemWritein;
			  ALUResultout <= ALUResultin;
			  RD2out <= RD2in;
			  rdout <= rdin;
			end
    end

  
endmodule