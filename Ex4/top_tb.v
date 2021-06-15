//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
reg rst;
reg button;
reg clk;
reg err;
wire [3:0] colour;
reg [3:0] prev_colour;
//Todo: Clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
//Todo: User logic
initial begin
    rst=1;
    button=0;
    err=0;
    #(CLK_PERIOD)
    if (colour != 3'b001) begin
        $display("***TEST FAILED! rst==%d, colour=%d ***",rst,colour);
        err=1;
    end
    prev_colour = colour;
    rst = 0;
    #(3*CLK_PERIOD)
    if (colour != prev_colour) begin
        $display("***TEST FAILED! button==%d, colour=%d prev_colour=%d ***",button,colour,prev_colour);
        err=1; 
    end
    forever begin
        prev_colour = colour;
        button = 1;
        #(CLK_PERIOD)
        button = 0;
        #(CLK_PERIOD)
        if (colour != (prev_colour + 1) && prev_colour < 3'b110) begin
            $display("***TEST FAILED! colour=%d prev_colour=%d ***",colour,prev_colour);
            err = 1;
        end
        if (prev_colour == 3'b110 && colour != 3'b001) begin
            $display("***TEST FAILED! colour=%d prev_colour=%d ***",colour,prev_colour);
            err = 1;
        end
    end
end
//Todo: Finish test, check for success
initial begin
        #(60*CLK_PERIOD)
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end
//Todo: Instantiate counter module
controller top (
   .rst (rst),
   .button (button),
   .clk (clk),
   .colour (colour)
);
endmodule 
