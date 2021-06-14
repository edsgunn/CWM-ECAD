//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
reg rst;
reg change;
reg on_off;
reg clk;
reg err;
reg counter_out;
//Todo: Clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
//Todo: User logic
initial begin
    rst=0;
    change=0;
    on_off=0;
    err=0;
    #(CLK_PERIOD)
    //forever
        //#(5*CLK_PERIOD)  on_off = ~on_off;
    forever
        #(20*CLK_PERIOD) change = ~change;
     end

initial begin
    #(90*CLK_PERIOD) rst = 1;
end
//Todo: Finish test, check for success
initial begin
        #(100*CLK_PERIOD)
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end
//Todo: Instantiate counter module
monitor top (
   .rst (rst),
   .change (change),
   .on_off (on_off),
   .clk (clk),
   .counter_out (counter_out)
);
endmodule 
