//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
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
reg sel;
wire [23:0] light;
reg [23:0] prev_light;
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
    sel = 0;
    #(CLK_PERIOD)
    if (light != 24'hffffff) begin
        $display("***TEST 1 FAILED! sel==%d rst==%d, light==%d ***",sel,rst,light);
        err=1;
    end
    sel = 1;
    #(3*CLK_PERIOD)
    if (light != 24'hff) begin
        $display("***TEST 2 FAILED! sel==%d rst==%d, light==%d ***",sel,rst,light);
        err=1;
    end
    prev_light = light;
    rst = 0;
    #(CLK_PERIOD)
    if (light != prev_light) begin
        $display("***TEST 3 FAILED! button==%d, light==%d prev_light==%d ***",button,light,prev_light);
        err=1; 
    end
    #(CLK_PERIOD)
    forever begin
        prev_light = light;
        button = 1;
        #(CLK_PERIOD)
        button = 0;
        #(CLK_PERIOD)
        if (light == prev_light) begin
            $display("***TEST 4 FAILED! Button has been pressed light=%d prev_light=%d ***",light,prev_light);
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
lights_selector top (
   .rst (rst),
   .button (button),
   .clk (clk),
   .sel(sel),
   .light (light)
);
endmodule 
