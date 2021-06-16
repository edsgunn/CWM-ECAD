//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Edward Gunn
// Date: 16/06/21
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

parameter CLK_PERIOD = 10;

reg clk;
reg enable;
reg [2:0] colour;
reg err;
wire [23:0] rgb;
reg [23:0] rgb_prev;
  
initial begin
  clk = 1'b0;
  forever
      #(CLK_PERIOD/2) clk=~clk;
end

initial begin
    err = 0;
    enable = 0;
    colour = 3'b001;
    #(CLK_PERIOD)

    if (rgb != 24'b0) begin
	$display("***TEST FAILED :(***");
	err = 1;
    end

    forever begin
        enable = 1;
        rgb_prev = rgb;
        colour <= (colour + 3'd1);
        #(3*CLK_PERIOD)
        if (rgb_prev == rgb) begin
            $display("***TEST FAILED :( colour=%d rgb=%d rgb_prev=%d ***",colour,rgb,rgb_prev);
	    err = 1;
        end
    end
end
  
 initial begin
    #(60*CLK_PERIOD)
    if (err==0)
      $display("***TEST PASSED! :) ***");
      $finish;
 end
     
rgb_converter top (
         .enable (enable),
	 .colour (colour),
	 .rgb (rgb),
	 .clk (clk)
	 );

endmodule 
