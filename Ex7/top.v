//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module lights_selector (
    //Todo: add ports
    input clk, sel, rst, button,
    output light 
    );

wire [2:0] colour;
wire [23:0] rgb;
wire [23:0] light;
   
controller lights(
    .clk(clk),
    .rst(rst),
    .button(button),
    .colour(colour)
);
rgb_converter converter(
    .clk(clk),
    .colour(colour),
    .enable(1'b1),
    .rgb(rgb)
);
doorbell mul(
    .a(24'hffffff),
    .b(rgb),
    .sel(sel),
    .out(light)
);
endmodule
