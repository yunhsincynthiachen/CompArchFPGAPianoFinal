`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:02:30 12/10/2014 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(output [3:0]gpioBank1, output [3:0]gpioBank2, input clk, input [7:0]sw);

	lut_to_notes final(clk, sw[7:0], gpioBank1[0], gpioBank1[1], gpioBank1[2], gpioBank1[3], gpioBank2[0], gpioBank2[1], gpioBank2[2], gpioBank2[3]);

endmodule
