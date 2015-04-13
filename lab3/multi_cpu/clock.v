`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:08 04/13/2015 
// Design Name: 
// Module Name:    clock 
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
module clock(
	input wire clk,
	input wire max,
	output reg oclk
	);
	
	reg [31:0] cnt;
	
	initial begin
		cnt [31:0] <=0;
		oclk<= 0;
	end
	
	always@(posedge clk)
		if(cnt>=max) begin
			cnt<=0;
			oclk <= ~oclk;
		end
		else begin
			cnt<=cnt+1;
		end
		
endmodule
