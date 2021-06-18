
`timescale 1ns / 100ps

module top_tb(
    );
    

parameter CLK_PERIOD = 10;

reg [31:0] in = 32'b1111_1111_0000_0101; //0.5 floating point
reg [31:0] out;
reg err;
reg aclk;

initial
    begin
       aclk = 1'b1;
       forever begin
         #(CLK_PERIOD/2) 
         aclk=~aclk;
       end
    end

    top top(
        .in(in)
        .out(out)
        .aclk(aclk)
    );
endmodule
