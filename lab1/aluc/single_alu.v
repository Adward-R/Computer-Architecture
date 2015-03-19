`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:11:56 02/12/2013 
// Design Name: 
// Module Name:    single_alu 
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
`include "macro.vh"

module single_alu(i_r,i_s,i_aluc,o_zf,o_alu);
	input [31:0] i_r;		//i_r: r input
	input [31:0] i_s;		//i_s: s input
	input [2:0] i_aluc;		//i_aluc: ctrl input
	output o_zf;			//o_zf: zero flag output
	output [31:0] o_alu;		//o_alu: alu result output
	reg o_zf;
	reg [31:0] o_alu;
	
	always @(i_aluc or i_r or i_s) begin
		case (i_aluc)
			//在此添加根据i_aluc的值对o_alu和o_zf进行赋值
			`ALU_CTL_AND: o_alu <= i_r & i_s;
			`ALU_CTL_OR: o_alu <= i_r | i_s;
			`ALU_CTL_ADD: o_alu <= i_r + i_s;
			`ALU_CTL_SUB: o_alu <= i_r - i_s;
			`ALU_CTL_SLT: o_alu <= (i_r < i_s) ? 1 : 0;
		endcase
		o_zf = (i_aluc == `ALU_CTL_SUB)&&(i_r==i_s);
	end
endmodule

