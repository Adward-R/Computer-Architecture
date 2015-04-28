`timescale 1ns / 1ps
`include "macro.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:27:31 03/30/2014 
// Design Name: 
// Module Name:    alu 
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
	input [3:0] i_aluc;		//i_aluc: ctrl input
	output [31:0] o_alu;		//o_alu: alu result output
	reg [31:0] o_alu;
	
	always @(i_aluc or i_r or i_s) begin
		case (i_aluc)
			`ALU_ADD:begin
				o_alu=i_r+i_s;
			end
			`ALU_SUB:begin
				o_alu=i_r-i_s;
			end
			`ALU_AND:begin
				o_alu=i_r&i_s;
			end
			`ALU_OR:begin
				o_alu=i_r|i_s;
			end
			`ALU_NOR:begin
				o_alu=~(i_r|i_s);
			end
			/*
			`ALU_SLT:begin
				o_alu=i_r+i_s;
			end
			
			`ALU_SLL:begin
				o_alu=i_r+i_s;
			end
			`ALU_SRL:begin
				o_alu=i_r+i_s;
			end
			`ALU_SRA:begin
				o_alu=i_r+i_s;
			end
			`ALU_NONE:begin
				o_alu=i_r+i_s;
			end*/
			default:begin
				o_alu=i_r+i_s;
			end
		endcase
	end
endmodule