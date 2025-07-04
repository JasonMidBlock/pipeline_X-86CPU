`timescale 1ns/1ns
module ALU32(ina, inb, ctrl, bin, cout, result);

    input[31:0] ina, inb;
    input [1:0] ctrl; // control of MUX
    input bin; // bit invert( add -> 0, sub -> 1 )
               // as the functionality of carry in 
    output cout;
    output[31:0] result;
    
    wire carry[30:0]; // 31 carry out to carry in wires
    wire zero = 1'b0;         
    wire set; // set on less lenth(look alu31's FA's result)                                       // a - b > 0    , a - b < 0
                                                      // set the first lessi with the last number( 0 -> lessi = 0, 1 -> lessi = 1)
    ALU1 alu0( .ina(ina[0]), .inb(inb[0]), .cin(bin), .lessi(set), .ctrl(ctrl), .bin(bin), .cout(carry[0]), .result(result[0]) );
            //          //            //              //   // lessi would be 0 in alu piece 1-31                           //                  //
    ALU1 alu1( .ina(ina[1]), .inb(inb[1]), .cin(carry[0]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[1]), .result(result[1]) );
    ALU1 alu2( .ina(ina[2]), .inb(inb[2]), .cin(carry[1]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[2]), .result(result[2]) );
    ALU1 alu3( .ina(ina[3]), .inb(inb[3]), .cin(carry[2]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[3]), .result(result[3]) );
    ALU1 alu4( .ina(ina[4]), .inb(inb[4]), .cin(carry[3]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[4]), .result(result[4]) );
    ALU1 alu5( .ina(ina[5]), .inb(inb[5]), .cin(carry[4]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[5]), .result(result[5]) );
    ALU1 alu6( .ina(ina[6]), .inb(inb[6]), .cin(carry[5]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[6]), .result(result[6]) );
    ALU1 alu7( .ina(ina[7]), .inb(inb[7]), .cin(carry[6]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[7]), .result(result[7]) );
    ALU1 alu8( .ina(ina[8]), .inb(inb[8]), .cin(carry[7]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[8]), .result(result[8]) );
    ALU1 alu9( .ina(ina[9]), .inb(inb[9]), .cin(carry[8]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[9]), .result(result[9]) );
    ALU1 alu10( .ina(ina[10]), .inb(inb[10]), .cin(carry[9]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[10]), .result(result[10]) );
    ALU1 alu11( .ina(ina[11]), .inb(inb[11]), .cin(carry[10]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[11]), .result(result[11]) );
    ALU1 alu12( .ina(ina[12]), .inb(inb[12]), .cin(carry[11]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[12]), .result(result[12]) );
    ALU1 alu13( .ina(ina[13]), .inb(inb[13]), .cin(carry[12]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[13]), .result(result[13]) );
    ALU1 alu14( .ina(ina[14]), .inb(inb[14]), .cin(carry[13]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[14]), .result(result[14]) );
    ALU1 alu15( .ina(ina[15]), .inb(inb[15]), .cin(carry[14]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[15]), .result(result[15]) );
    ALU1 alu16( .ina(ina[16]), .inb(inb[16]), .cin(carry[15]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[16]), .result(result[16]) );
    ALU1 alu17( .ina(ina[17]), .inb(inb[17]), .cin(carry[16]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[17]), .result(result[17]) );
    ALU1 alu18( .ina(ina[18]), .inb(inb[18]), .cin(carry[17]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[18]), .result(result[18]) );
    ALU1 alu19( .ina(ina[19]), .inb(inb[19]), .cin(carry[18]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[19]), .result(result[19]) );
    ALU1 alu20( .ina(ina[20]), .inb(inb[20]), .cin(carry[19]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[20]), .result(result[20]) );
    ALU1 alu21( .ina(ina[21]), .inb(inb[21]), .cin(carry[20]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[21]), .result(result[21]) );
    ALU1 alu22( .ina(ina[22]), .inb(inb[22]), .cin(carry[21]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[22]), .result(result[22]) );
    ALU1 alu23( .ina(ina[23]), .inb(inb[23]), .cin(carry[22]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[23]), .result(result[23]) );
    ALU1 alu24( .ina(ina[24]), .inb(inb[24]), .cin(carry[23]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[24]), .result(result[24]) );
    ALU1 alu25( .ina(ina[25]), .inb(inb[25]), .cin(carry[24]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[25]), .result(result[25]) );
    ALU1 alu26( .ina(ina[26]), .inb(inb[26]), .cin(carry[25]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[26]), .result(result[26]) );
    ALU1 alu27( .ina(ina[27]), .inb(inb[27]), .cin(carry[26]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[27]), .result(result[27]) );
    ALU1 alu28( .ina(ina[28]), .inb(inb[28]), .cin(carry[27]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[28]), .result(result[28]) );
    ALU1 alu29( .ina(ina[29]), .inb(inb[29]), .cin(carry[28]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[29]), .result(result[29]) );
    ALU1 alu30( .ina(ina[30]), .inb(inb[30]), .cin(carry[29]), .lessi(zero), .ctrl(ctrl), .bin(bin), .cout(carry[30]), .result(result[30]) );
    ALU1SP alu31( .ina(ina[31]), .inb(inb[31]), .cin(carry[30]), .lessi(zero), .ctrl(ctrl), .bin(bin), .set(set), .cout(cout), .result(result[31]) );
                                                                                                                  // the last carry out would be the carry out of alu
    
endmodule