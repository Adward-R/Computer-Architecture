`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:50 03/16/2014 
// Design Name: 
// Module Name:    single_pc_plus4 
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
module single_pc_plus4(ipc,opc);
 	 input [8:0] ipc;
 	 output [8:0] opc;
  
 	 assign opc[8:0] = ipc[8:0] + 1;
endmodule

