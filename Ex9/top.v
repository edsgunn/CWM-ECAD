
module top(
    input [31:0] in,
    input aclk,
    output [31:0] out
    );
    
    wire out;
    
    sigmoid sig(
        .in(in),
        .out(out),
        .aclk(aclk)
    );
endmodule
