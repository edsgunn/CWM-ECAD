//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
reg clk;
reg [4:0] temp;
reg err;
wire heating;
wire cooling;
//Todo: Clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
//Todo: User logic
initial begin
    err = 0;
    temp = 5'd15;
    
    forever begin
    	#(3*CLK_PERIOD)
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
acsystem top (
   .temp (temp),
   .clk (clk),
   .heating (heating),
   .cooling (cooling)
);
endmodule 
