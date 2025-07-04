`timescale 1ns/1ns
module BSHIFTERR32( in, amount , ans);

    input[31:0] in;
    input[31:0] amount; // the shift amount(register b) the shifter will ignore the bits over bit 4
    output[31:0] ans;  
    
    wire[31:0] L0,L1,L2,L3;
    // L for level
    wire zero = 1'b0;
     
    assign L0[0] = amount[0] ? in[1] : in[0];
    assign L0[1] = amount[0] ? in[2] : in[1];
    assign L0[2] = amount[0] ? in[3] : in[2];
    assign L0[3] = amount[0] ? in[4] : in[3];
    assign L0[4] = amount[0] ? in[5] : in[4];
    assign L0[5] = amount[0] ? in[6] : in[5];
    assign L0[6] = amount[0] ? in[7] : in[6];
    assign L0[7] = amount[0] ? in[8] : in[7];
    assign L0[8] = amount[0] ? in[9] : in[8];
    assign L0[9] = amount[0] ? in[10] : in[9];
    assign L0[10] = amount[0] ? in[11] : in[10];
    assign L0[11] = amount[0] ? in[12] : in[11];
    assign L0[12] = amount[0] ? in[13] : in[12];
    assign L0[13] = amount[0] ? in[14] : in[13];
    assign L0[14] = amount[0] ? in[15] : in[14];
    assign L0[15] = amount[0] ? in[16] : in[15];
    assign L0[16] = amount[0] ? in[17] : in[16];
    assign L0[17] = amount[0] ? in[18] : in[17];
    assign L0[18] = amount[0] ? in[19] : in[18];
    assign L0[19] = amount[0] ? in[20] : in[19];
    assign L0[20] = amount[0] ? in[21] : in[20];
    assign L0[21] = amount[0] ? in[22] : in[21];
    assign L0[22] = amount[0] ? in[23] : in[22];
    assign L0[23] = amount[0] ? in[24] : in[23];
    assign L0[24] = amount[0] ? in[25] : in[24];
    assign L0[25] = amount[0] ? in[26] : in[25];
    assign L0[26] = amount[0] ? in[27] : in[26];
    assign L0[27] = amount[0] ? in[28] : in[27];
    assign L0[28] = amount[0] ? in[29] : in[28];
    assign L0[29] = amount[0] ? in[30] : in[29];
    assign L0[30] = amount[0] ? in[31] : in[30];
    assign L0[31] = amount[0] ? zero : in[31];
    
    //  //  //  //  // end L0 end //  //  //  // //
    
    assign L1[0] = amount[1] ? L0[2] : L0[0];
    assign L1[1] = amount[1] ? L0[3] : L0[1];
    assign L1[2] = amount[1] ? L0[4] : L0[2];
    assign L1[3] = amount[1] ? L0[5] : L0[3];
    assign L1[4] = amount[1] ? L0[6] : L0[4];
    assign L1[5] = amount[1] ? L0[7] : L0[5];
    assign L1[6] = amount[1] ? L0[8] : L0[6];
    assign L1[7] = amount[1] ? L0[9] : L0[7];
    assign L1[8] = amount[1] ? L0[10] : L0[8];
    assign L1[9] = amount[1] ? L0[11] : L0[9];
    assign L1[10] = amount[1] ? L0[12] : L0[10];
    assign L1[11] = amount[1] ? L0[13] : L0[11];
    assign L1[12] = amount[1] ? L0[14] : L0[12];
    assign L1[13] = amount[1] ? L0[15] : L0[13];
    assign L1[14] = amount[1] ? L0[16] : L0[14];
    assign L1[15] = amount[1] ? L0[17] : L0[15];
    assign L1[16] = amount[1] ? L0[18] : L0[16];
    assign L1[17] = amount[1] ? L0[19] : L0[17];
    assign L1[18] = amount[1] ? L0[20] : L0[18];
    assign L1[19] = amount[1] ? L0[21] : L0[19];
    assign L1[20] = amount[1] ? L0[22] : L0[20];
    assign L1[21] = amount[1] ? L0[23] : L0[21];
    assign L1[22] = amount[1] ? L0[24] : L0[22];
    assign L1[23] = amount[1] ? L0[25] : L0[23];
    assign L1[24] = amount[1] ? L0[26] : L0[24];
    assign L1[25] = amount[1] ? L0[27] : L0[25];
    assign L1[26] = amount[1] ? L0[28] : L0[26];
    assign L1[27] = amount[1] ? L0[29] : L0[27];
    assign L1[28] = amount[1] ? L0[30] : L0[28];
    assign L1[29] = amount[1] ? L0[31] : L0[29];
    assign L1[30] = amount[1] ? zero : L0[30];
    assign L1[31] = amount[1] ? zero : L0[31];
    
    //  //  //  //  // end L1 end //  //  //  // //
    
    assign L2[0] = amount[2] ? L1[4] : L1[0];
    assign L2[1] = amount[2] ? L1[5] : L1[1];
    assign L2[2] = amount[2] ? L1[6] : L1[2];
    assign L2[3] = amount[2] ? L1[7] : L1[3];
    assign L2[4] = amount[2] ? L1[8] : L1[4];
    assign L2[5] = amount[2] ? L1[9] : L1[5];
    assign L2[6] = amount[2] ? L1[10] : L1[6];
    assign L2[7] = amount[2] ? L1[11] : L1[7];
    assign L2[8] = amount[2] ? L1[12] : L1[8];
    assign L2[9] = amount[2] ? L1[13] : L1[9];
    assign L2[10] = amount[2] ? L1[14] : L1[10];
    assign L2[11] = amount[2] ? L1[15] : L1[11];
    assign L2[12] = amount[2] ? L1[16] : L1[12];
    assign L2[13] = amount[2] ? L1[17] : L1[13];
    assign L2[14] = amount[2] ? L1[18] : L1[14];
    assign L2[15] = amount[2] ? L1[19] : L1[15];
    assign L2[16] = amount[2] ? L1[20] : L1[16];
    assign L2[17] = amount[2] ? L1[21] : L1[17];
    assign L2[18] = amount[2] ? L1[22] : L1[18];
    assign L2[19] = amount[2] ? L1[23] : L1[19];
    assign L2[20] = amount[2] ? L1[24] : L1[20];
    assign L2[21] = amount[2] ? L1[25] : L1[21];
    assign L2[22] = amount[2] ? L1[26] : L1[22];
    assign L2[23] = amount[2] ? L1[27] : L1[23];
    assign L2[24] = amount[2] ? L1[28] : L1[24];
    assign L2[25] = amount[2] ? L1[29] : L1[25];
    assign L2[26] = amount[2] ? L1[30] : L1[26];
    assign L2[27] = amount[2] ? L1[31] : L1[27];
    assign L2[28] = amount[2] ? zero : L1[28];
    assign L2[29] = amount[2] ? zero : L1[29];
    assign L2[30] = amount[2] ? zero : L1[30];
    assign L2[31] = amount[2] ? zero : L1[31];
    
    //  //  //  //  // end L2 end //  //  //  // //
    
    assign L3[0] = amount[3] ? L2[8] : L2[0];
    assign L3[1] = amount[3] ? L2[9] : L2[1];
    assign L3[2] = amount[3] ? L2[10] : L2[2];
    assign L3[3] = amount[3] ? L2[11] : L2[3];
    assign L3[4] = amount[3] ? L2[12] : L2[4];
    assign L3[5] = amount[3] ? L2[13] : L2[5];
    assign L3[6] = amount[3] ? L2[14] : L2[6];
    assign L3[7] = amount[3] ? L2[15] : L2[7];
    assign L3[8] = amount[3] ? L2[16] : L2[8];
    assign L3[9] = amount[3] ? L2[17] : L2[9];
    assign L3[10] = amount[3] ? L2[18] : L2[10];
    assign L3[11] = amount[3] ? L2[19] : L2[11];
    assign L3[12] = amount[3] ? L2[20] : L2[12];
    assign L3[13] = amount[3] ? L2[21] : L2[13];
    assign L3[14] = amount[3] ? L2[22] : L2[14];
    assign L3[15] = amount[3] ? L2[23] : L2[15];
    assign L3[16] = amount[3] ? L2[24] : L2[16];
    assign L3[17] = amount[3] ? L2[25] : L2[17];
    assign L3[18] = amount[3] ? L2[26] : L2[18];
    assign L3[19] = amount[3] ? L2[27] : L2[19];
    assign L3[20] = amount[3] ? L2[28] : L2[20];
    assign L3[21] = amount[3] ? L2[29] : L2[21];
    assign L3[22] = amount[3] ? L2[30] : L2[22];
    assign L3[23] = amount[3] ? L2[31] : L2[23];
    assign L3[24] = amount[3] ? zero : L2[24];
    assign L3[25] = amount[3] ? zero : L2[25];
    assign L3[26] = amount[3] ? zero : L2[26];
    assign L3[27] = amount[3] ? zero : L2[27];
    assign L3[28] = amount[3] ? zero : L2[28];
    assign L3[29] = amount[3] ? zero : L2[29];
    assign L3[30] = amount[3] ? zero : L2[30];
    assign L3[31] = amount[3] ? zero : L2[31];
    
    //  //  //  //  // end L3 end //  //  //  // //
    
    assign ans[0] = amount[4] ? L3[16] : L3[0];
    assign ans[1] = amount[4] ? L3[17] : L3[1];
    assign ans[2] = amount[4] ? L3[18] : L3[2];
    assign ans[3] = amount[4] ? L3[19] : L3[3];
    assign ans[4] = amount[4] ? L3[20] : L3[4];
    assign ans[5] = amount[4] ? L3[21] : L3[5];
    assign ans[6] = amount[4] ? L3[22] : L3[6];
    assign ans[7] = amount[4] ? L3[23] : L3[7];
    assign ans[8] = amount[4] ? L3[24] : L3[8];
    assign ans[9] = amount[4] ? L3[25] : L3[9];
    assign ans[10] = amount[4] ? L3[26] : L3[10];
    assign ans[11] = amount[4] ? L3[27] : L3[11];
    assign ans[12] = amount[4] ? L3[28] : L3[12];
    assign ans[13] = amount[4] ? L3[29] : L3[13];
    assign ans[14] = amount[4] ? L3[30] : L3[14];
    assign ans[15] = amount[4] ? L3[31] : L3[15];
    assign ans[16] = amount[4] ? zero : L3[16];
    assign ans[17] = amount[4] ? zero : L3[17];
    assign ans[18] = amount[4] ? zero : L3[18];
    assign ans[19] = amount[4] ? zero : L3[19];
    assign ans[20] = amount[4] ? zero : L3[20];
    assign ans[21] = amount[4] ? zero : L3[21];
    assign ans[22] = amount[4] ? zero : L3[22];
    assign ans[23] = amount[4] ? zero : L3[23];
    assign ans[24] = amount[4] ? zero : L3[24];
    assign ans[25] = amount[4] ? zero : L3[25];
    assign ans[26] = amount[4] ? zero : L3[26];
    assign ans[27] = amount[4] ? zero : L3[27];
    assign ans[28] = amount[4] ? zero : L3[28];
    assign ans[29] = amount[4] ? zero : L3[29];
    assign ans[30] = amount[4] ? zero : L3[30];
    assign ans[31] = amount[4] ? zero : L3[31];
    
    //  //  //  //  // end ans end //  //  //  // //
    
  
endmodule