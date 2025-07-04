module tb_Pipeline();
	reg clk, rst;
	
	// 產生時脈，週期：10ns
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		/*
			指令資料記憶體，檔名"instr_mem.txt, data_mem.txt"可自行修改
			每一行為1 Byte資料，以兩個十六進位數字表示
			且為Little Endian編碼
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// 設定暫存器初始值，每一行為一筆暫存器資料
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
	end
	
	always @( posedge clk ) 
	begin
		$display( "%d, PC:", $time/10-1, CPU.PCvalue );
		
		$display( "                 ID decode :");
		if ( CPU.opcodetoMUX == 6'b000000 ) 
		begin
			if ( CPU.functoMUX == 6'b000000 ) $display( "%d, NOP\n", $time/10-1 );
			else if( CPU.functoMUX == 6'b000010 ) $display( "%d, SRL\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b010000 ) $display( "%d, MOVE HI\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b010010 ) $display( "%d, MOVE LO\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b011001 ) $display( "%d, MULT\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b100000 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b100010 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b100100 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b100101 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.functoMUX == 6'b101010 ) $display( "%d, SLT\n", $time/10-1 );
		end
		else if ( CPU.opcodetoMUX == 6'b100011 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.opcodetoMUX == 6'b101011 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.opcodetoMUX == 6'b011100 ) $display( "%d, MADDU\n", $time/10-1 ); 
		else if ( CPU.opcodetoMUX == 6'b001001 ) $display( "%d, ADDIU\n", $time/10-1 ); 
		else if ( CPU.opcodetoMUX == 6'b000100 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.opcodetoMUX == 6'b000010 ) $display( "%d, J\n", $time/10-1 );
		  
		if( CPU.PCSrc == 1'b1 ) $display( "%d, branch taken, squash two instructions\n", $time/10-1 );
		if( CPU.isjEX == 1'b1 ) $display( "%d, jump, squash two instructions\n", $time/10-1 );
		if( CPU.blockinstr == 1'b1 ) $display( "%d, hazard happened, stall once\n", $time/10-1 );
		if( CPU.ALUansEX != 32'b0 ) $display( "%d, ALU answer : %d\n", $time/10-1, CPU.ALUansEX );
		if( CPU.fowarda == 2'b01 ) $display( "%d, foward a from WB stage\n", $time/10-1 );
		if( CPU.fowarda == 2'b10 ) $display( "%d, foward a from MEM stage\n", $time/10-1 );
   		if( CPU.fowardb == 2'b01 ) $display( "%d, foward b from WB stage\n", $time/10-1 );
		if( CPU.fowardb == 2'b10 ) $display( "%d, foward b from MEM stage\n", $time/10-1 );  
		  
		if ( $time > 1000 )
		  $stop();
	end
	
	TotalPipeline CPU( clk, rst );
	
endmodule