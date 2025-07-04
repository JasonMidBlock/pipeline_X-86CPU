`timescale 1ns/1ns
module FAS(a, b, cin, bin, cout, sum);

    input a, b, cin, bin;
    output cout, sum;
    
    wire   e1, e2, e3;
    wire   bt;
    // bit invert 
    xor (bt,b,bin);

    xor (e1, a, bt);
    and (e2, a, bt);
    and (e3, e1, cin);
    or (cout, e2, e3);
    xor  (sum, e1, cin);

endmodule
