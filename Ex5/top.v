//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Edward Gunn
// Date: 15/06/21
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module acsystem (
    //Todo: add ports
    input clk,
    input [4:0] temp,
    output heating,cooling
    );
                    
    //Todo: add registers and wires, if needed
    reg heating;
    reg cooling;

    //Todo: add user logic
    always @(posedge clk) begin
        case({heating,cooling})
            2'b10: begin 
                if (temp >= 20) 
                    heating = 0;
            end
            2'b00: begin
                if (temp >= 22) 
                    cooling = 1;
                if (temp <= 18) 
                    heating = 1;
            end
            2'b01: begin 
                if (temp <= 20) 
                    cooling = 0;
            end
            default: begin
                heating = 0;
                cooling = 0;
            end
        endcase
    end    
endmodule
