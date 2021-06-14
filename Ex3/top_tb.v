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
wire [7:0] counter_out;
reg [7:0] counter_out_prev;
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
    change=0;
    on_off=0;
    err=0;
    #(CLK_PERIOD)
    if (counter_out != 0) begin
        $display("***TEST FAILED! rst==%d, counter_out=%d ***",rst,counter_out);
        err=1;
    end
    counter_out_prev = counter_out;
    rst = 0;
    #(3*CLK_PERIOD)
    if (counter_out != counter_out_prev) begin
        $display("***TEST FAILED! change==%d, counter_out=%d counter_out_prev=%d ***",change,counter_out,counter_out_prev);
        err=1; 
    end
    change = 1;
    forever begin
        on_off = ~on_off;
        counter_out_prev = counter_out;
        #(3*CLK_PERIOD)
	if (on_off) begin
            if (counter_out != (counter_out_prev + 3)) begin
                $display("***TEST FAILED! on_off==%d, counter_out=%d counter_out_prev=%d ***",change,counter_out,counter_out_prev);
                err = 1;
            end
        end else begin
            if (counter_out != (counter_out_prev - 3)) begin
                $display("***TEST FAILED! on_off==%d, counter_out=%d counter_out_prev=%d ***",change,counter_out,counter_out_prev);
                err = 1;
            end
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
monitor top (
   .rst (rst),
   .change (change),
   .on_off (on_off),
   .clk (clk),
   .counter_out (counter_out)
);
endmodule 
