`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:48 04/12/2015 
// Design Name: 
// Module Name:    x_alu 
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
module alu(i_r,i_s,i_aluc,o_alu);
	input [31:0] i_r;		//i_r: r input
	input [31:0] i_s;		//i_s: s input
	input [1:0] i_aluc;		//i_aluc: ctrl input
	//output o_zf;			//o_zf: zero flag output
	output [31:0] o_alu;		//o_alu: alu result output
	reg o_zf;
	reg [31:0] o_alu;
	
	always @(i_aluc or i_r or i_s) begin
		case (i_aluc)
			//在此添加根据i_aluc的值对o_alu和o_zf进行赋值
			2'b11: o_alu = i_r & i_s;
			2'b10: o_alu = ~(i_r | i_s);
			2'b00: o_alu = i_r + i_s;
			2'b01: o_alu = i_r - i_s;
			default: o_alu = i_r + i_s;
		endcase
	end
endmodule
