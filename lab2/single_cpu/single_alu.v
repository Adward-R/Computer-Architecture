`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:54 03/16/2014 
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
			3'b000:begin
				o_zf=0;
				o_alu=i_r&i_s;
				end
			3'b001:begin
				o_zf=0;
				o_alu=i_r|i_s;
				end
			3'b010:begin
				o_zf=0;
				o_alu=i_r+i_s;
				end
			3'b110:begin
				o_alu=i_r-i_s;
				o_zf=(o_alu==0);
				end
			3'b111:begin
				o_zf=0;
				if(i_r<i_s)
					o_alu=1;
				else
					o_alu=0;
				end
			default:begin
				o_zf=0;
				o_alu=0;
				end

		endcase
	end
endmodule
