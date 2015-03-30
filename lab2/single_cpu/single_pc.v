`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:15 03/16/2014 
// Design Name: 
// Module Name:    single_pc 
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
module single_pc(clk,rst,ipc,opc);
		input clk;
		input rst;
 		input [8:0] ipc;
  		output [8:0] opc;
		wire [8:0] tpc;
		
		dff x_dff(clk,rst,ipc,tpc);
		sel x_sel(rst,tpc,opc);
endmodule

