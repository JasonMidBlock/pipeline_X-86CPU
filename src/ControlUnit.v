module ControlUnit( opin, funcin, isBranch, MemtoReg, RegWrite, MemRead, MemWrite, ALUSrc, RegDst, opout, funcout, rst, isj, NotSht, isMult );
  input rst;
  input [5:0] opin, funcin;
  output isBranch, MemtoReg, RegWrite, MemRead, MemWrite, RegDst, isj, NotSht, isMult;
  output ALUSrc;
  output [5:0] opout, funcout;
  reg isBranch, MemtoReg, RegWrite, MemRead, MemWrite, RegDst, isj, NotSht, isMult;
  reg ALUSrc;
  reg [5:0] opout, funcout;

  parameter zero = 6'd0;
  parameter j = 6'd2;
  parameter beq = 6'd4;
  parameter addiu = 6'd9;
  parameter lw = 6'd35;
  parameter sw = 6'd43;
  parameter maddu = 6'd28;
  
  always@( rst )
  begin
    if( rst )
      isBranch = 1'b0;
  end
  
  always@( opin or funcin )
  begin
    
    opout = opin;
    funcout = funcin;
    
    case ( opin )
      zero :
      begin
        if ( funcin == 6'd0 ) // nop
				begin
				  ALUSrc = 1'b0; RegDst = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; 
				  MemtoReg = 1'b0; RegWrite = 1'b0; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 0;
				end
        else if ( funcin == 6'd2 ) // srl
        begin
          ALUSrc = 1'b1; RegDst = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; 
				  MemtoReg = 1'b0; RegWrite = 1'b1; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b0; isMult = 0;
				end
				else if ( funcin == 6'd25 ) // multu
				begin
				  ALUSrc = 1'b1; RegDst = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; 
				  MemtoReg = 1'b0; RegWrite = 1'b0; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 1;
				end
				else // R type
				begin
				  ALUSrc = 1'b1; RegDst = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; 
				  MemtoReg = 1'b0; RegWrite = 1'b1; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 0;
				end
      end
      
      j :
      begin
        ALUSrc = 1'b0; RegDst = 1'bx; MemRead = 1'b0; MemWrite = 1'b0; 
				MemtoReg = 1'bx; RegWrite = 1'b0; isBranch = 1'b0; isj = 1'b1; NotSht = 1'b1; isMult = 0;
      end
      
      beq :
      begin
        ALUSrc = 1'b1; RegDst = 1'bx; MemRead = 1'b0; MemWrite = 1'b0; 
				MemtoReg = 1'bx; RegWrite = 1'b0; isBranch = 1'b1; isj = 1'b0; NotSht = 1'b1; isMult = 0;
      end
      
      addiu :
      begin
        ALUSrc = 1'b0; RegDst = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; 
				MemtoReg = 1'b0; RegWrite = 1'b1; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 0;
      end
      
      lw :
      begin
        ALUSrc = 1'b0; RegDst = 1'b1; MemRead = 1'b1; MemWrite = 1'b0; 
				MemtoReg = 1'b1; RegWrite = 1'b1; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 0;
      end
      
      sw : 
      begin
        ALUSrc = 1'b0; RegDst = 1'bx; MemRead = 1'b0; MemWrite = 1'b1; 
				MemtoReg = 1'bx; RegWrite = 1'b0; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 0;
      end
      
      maddu :
      begin
        ALUSrc = 1'b1; RegDst = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; 
				MemtoReg = 1'b0; RegWrite = 1'b0; isBranch = 1'b0; isj = 1'b0; NotSht = 1'b1; isMult = 1;
      end
      
      default
      begin
				$display("control_single unimplemented opcode %d", opin);
				ALUSrc = 1'bx; RegDst = 1'bx; MemRead = 1'bx; MemWrite = 1'bx; 
				MemtoReg = 1'bx; RegWrite = 1'bx; isBranch = 1'bx; isj = 1'bx; NotSht = 1'b1; isMult = 0;
      end
      
    endcase
  end

endmodule