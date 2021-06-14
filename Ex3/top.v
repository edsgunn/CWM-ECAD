//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name: Edward Gunn
// Date: 14/06/21
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If event=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (
    //Todo: add ports
    input clk, rst, change, on_off,
    output counter_out
    );
                    
    //Todo: add registers and wires, if needed
    reg counter_out[7:0];

    //Todo: add user logic
    always @(posedge clk or posedge rst)
     if(rst)
       counter_out <= 8'b0;
     else begin
	if (change)
          counter_out <= on_off ? counter_out+8'b1:counter_out-8'b1;  
     end     
endmodule
