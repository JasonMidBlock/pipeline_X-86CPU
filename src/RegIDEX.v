module RegIDEX( clk, rst, en_reg, MemtoRegin, RegWritein, MemReadin, MemWritein, ALUSrcin, RegDstin, opin, funcin
                                , RD1in, RD2in, immin, rsin, rtin, rdin, shamtin, isBranchin, isjin, jumpaddrin, branchtargin, NotShtin, isMultin
                                , MemtoRegout, RegWriteout, MemReadout, MemWriteout, ALUSrcout, RegDstout, opout, funcout
                                , RD1out, RD2out, immout, rsout, rtout, rdout, shamtout, isBranchout, isjout, jumpaddrout, branchtargout, NotShtout, isMultout
                                , flush );
  // basic need
  input clk, rst, en_reg;
  
  input flush;
  
  // WB stage ctrl
  input MemtoRegin, RegWritein;
  output MemtoRegout, RegWriteout;
  reg MemtoRegout, RegWriteout;
  
  // MEM stage ctrl
  input MemReadin, MemWritein;
  output MemReadout, MemWriteout;
  reg MemReadout, MemWriteout;
  
  // EX stage ctrl
  input isBranchin, isjin, isMultin;
  input RegDstin;
  input ALUSrcin;
  input [5:0] opin, funcin;
  input NotShtin;
  output isBranchout, isjout, isMultout;
  output RegDstout;
  output ALUSrcout;
  output [5:0] opout, funcout;
  output NotShtout;
  reg isBranchout, isjout, isMultout;
  reg RegDstout;
  reg ALUSrcout;
  reg [5:0] opout, funcout;
  reg NotShtout;
  
  // data transfer
  input [31:0] RD1in, RD2in, immin, shamtin;
  input [31:0] jumpaddrin, branchtargin;
  input [4:0] rsin, rtin, rdin;
  output [31:0] RD1out, RD2out, immout, shamtout;
  output [31:0] jumpaddrout, branchtargout;
  output [4:0] rsout, rtout, rdout;
  reg [31:0] RD1out, RD2out, immout, shamtout;
  reg [31:0] jumpaddrout, branchtargout;
  reg [4:0] rsout, rtout, rdout;
  
  always @( posedge clk ) 
    begin
    if ( rst || flush )
      begin
			  MemtoRegout <= 1'b0;
			  RegWriteout <= 1'b0;
			  MemReadout <= 1'b0;
			  MemWriteout <= 1'b0;
			  ALUSrcout <= 1'b0;
			  RegDstout <= 1'b0;
			  opout <= 6'b0;
			  funcout <= 6'b0;
			  RD1out <= 32'b0;
			  RD2out <= 32'b0;
			  immout <= 32'b0;
			  shamtout <= 32'b0;
			  rsout <= 5'b0;
			  rtout <= 5'b0;
			  rdout <= 5'b0;
			  isBranchout <= 1'b0;
			  isjout <= 1'b0;
			  jumpaddrout <= 32'b0;
			  branchtargout <= 32'b0;
			  NotShtout <= 1'b0;
			  isMultout <= 1'b0;
			end
    else if ( en_reg )
      begin
			  MemtoRegout <= MemtoRegin;
			  RegWriteout <= RegWritein;
			  MemReadout <= MemReadin;
			  MemWriteout <= MemWritein;
			  ALUSrcout <= ALUSrcin;
			  RegDstout <= RegDstin;
			  opout <= opin;
			  funcout <= funcin;
			  RD1out <= RD1in;
			  RD2out <= RD2in;
			  immout <= immin;
			  shamtout <= shamtin;
			  rsout <= rsin;
			  rtout <= rtin;
			  rdout <= rdin;
			  isBranchout <= isBranchin;
			  isjout <= isjin;
			  jumpaddrout <= jumpaddrin;
			  branchtargout <= branchtargin;
			  NotShtout <= NotShtin;
			  isMultout <= isMultin;
			end
    end

  
endmodule