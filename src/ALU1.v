`timescale 1ns/1ns
module ALU1(ina, inb, cin, lessi, ctrl, bin, cout, result);

    input ina, inb, cin, lessi;
    input [1:0] ctrl;
    input bin; // bit invert( add -> 0, sub -> 1 )
    output cout, result;
    
    wire zero, one, two;
    
    assign zero = ina && inb; // assign and solution to zero in MUX
    assign one = ina || inb;  // assign or solution to one in MUX

    FAS fa( .a( ina ), .b( inb ), .cin( cin ), .bin( bin ), .cout( cout ), .sum( two ) ); // assign add or sub solution to two in MUX
                                                                                          // also set cout of this ALU slice 
    MUX4to1 mux( .zero( zero ), .one( one ), .two( two ), .three( lessi ), .select( ctrl ), .zout( result )  ); // select the result

endmodule