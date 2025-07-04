`timescale 1ns/1ns
module MUX4to1(zero, one, two, three, select, zout);

    input  zero, one, two, three;
    input  [1:0] select;
    output zout;   
    
    assign zout = select[1] ? ( select[0] ? three : two ) : ( select[0] ? one : zero );
    //       high = 1  low = 1 -> three, low = 0 -> two  // high = 0 low = 1 -> one, low = 0 -> zero
                           // -> means select here
endmodule