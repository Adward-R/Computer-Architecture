`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:15 03/16/2014 
// Design Name: 
// Module Name:    single_add 
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
module single_add(op1,op2,out);
 		 	input [31:0] op1;
  		 	input [31:0] op2;
  		 	output [31:0] out;

			assign out = op1 + op2;
endmodule

