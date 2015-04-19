`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:11 04/12/2015 
// Design Name: 
// Module Name:    pbdebounce 
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
module pbdebounce(
   input wire clk,
	input wire button,
	output reg [1:0] pbreg);
	
	reg [7:0] pbshift;
	always@(posedge clk) begin
		pbshift = pbshift << 1;//左移1位
		pbshift[0] = button;
		if (pbshift == 0)
			pbreg[0] = 0;
		if (pbshift == 8'hFF)// pbshift八位全为1
			pbreg[0] = 1;
	end
	
	
endmodule