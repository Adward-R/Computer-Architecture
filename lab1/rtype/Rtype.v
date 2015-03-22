`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:27 03/19/2015 
// Design Name: 
// Module Name:    Rtype 
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
module Rtype(clk, rst, instru, Adat, Bdat, result);
	input clk,rst;
	input [31:0] instru;
	output [31:0] result, Adat, Bdat;
	wire [31:0]	result; 
	wire [31:0]	Wdat, Adat, Bdat, ALUout;
	wire [2:0]	ALUoper;
	RegFile x_regfile(clk, rst, instru[25:21], instru[20:16], instru[15:11], result, Adat, Bdat, 1);
	ALUctr x_aluctr(2'b10, instru[5:0], ALUoper);	
	ALUnit x_alunit(Adat, Bdat, ALUoper, zero, result);
endmodule
