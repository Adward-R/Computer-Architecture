`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:35 03/16/2014 
// Design Name: 
// Module Name:    dff 
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
module dff(clk,rst,d,q);
		input clk,rst;
		input [8:0] d;
		output [8:0] q;
		reg [8:0] q;
		
		initial begin
			q<=0;
		end
		
		always @ (posedge clk or posedge rst) begin
			if(rst == 1'b1)
			begin
			q<= 1'b0;
			end
			else
			begin
			q<= d ;
			end
		end
endmodule
