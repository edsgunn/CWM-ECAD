//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Edward Gunn
// Date: 17/06/21
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
reg [4:0] temp;
reg err;
reg clk_p;
reg clk_n;
wire heating;
wire cooling;
//Todo: Clock generation
initial
    begin
       clk_p = 1'b1;
       clk_n = 1'b0;
       forever begin
         #(CLK_PERIOD/2) 
         clk_p=~clk_p;
         clk_n=~clk_n;
       end
    end
//Todo: User logic
initial begin
    err = 0;
    temp = 5'd16;
    
    forever begin
    	#(CLK_PERIOD)
	if((temp<=5'd18)&(!heating)&(cooling)) begin 
            err = 1;
	    $display("*** Test Failed :( *** heating=%d cooling=%d temperature =%d", heating,cooling,temp);
    	end
	if ((temp>=5'd22)&(heating)&(!cooling)) begin
            err = 1;
	    $display("*** Test Failed :( *** heating=%d cooling=%d temperature =%d", heating,cooling,temp);
    	end 
	if ((heating)&(cooling)) begin
            err = 1;
	    $display("*** Test Failed :( *** heating=%d cooling=%d", heating,cooling);
    	end 
	    
    	temp <= temp + 5'd1;
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
top top (
   .temperature_0 (temp[4]),
   .temperature_1 (temp[3]),
   .temperature_2 (temp[2]),
   .temperature_3 (temp[1]),
   .temperature_4 (temp[0]),
   .clk_p (clk_p),
   .clk_n (clk_n),
   .heating (heating),
   .cooling (cooling)
);
endmodule 
