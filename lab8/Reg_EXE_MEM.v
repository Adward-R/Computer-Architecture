`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:55:00 03/20/2012 
// Design Name: 
// Module Name:    Reg_EXE_MEM 
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
module Reg_EXE_MEM(clk,	ewreg, em2reg, ewmem, aluout, edata_b, erdrt, //inputs
							mwreg, mm2reg, mwmem, maluout, mdata_b, mrdrt, 
							EXE_ins_type, EXE_ins_number, MEM_ins_type, MEM_ins_number);
	input clk, ewreg, em2reg, ewmem;
	input [31:0] aluout, edata_b;
	input [4:0]	 erdrt;

	output mwreg, mm2reg, mwmem;
	output [31:0] maluout, mdata_b;
	output [4:0]  mrdrt;

		
	input [3:0]  EXE_ins_type;
	input [3:0]	 EXE_ins_number;
	output [3:0] MEM_ins_type;
	output [3:0] MEM_ins_number;

	reg [3:0] MEM_ins_type;
	reg [3:0] MEM_ins_number;	
	reg mwreg, mm2reg, mwmem;
	reg [31:0] maluout, mdata_b;
	reg [4:0]  mrdrt;
	
	always@(posedge clk) begin
		mwreg <= ewreg;
		mm2reg <= em2reg;
		mwmem <= ewmem;
		maluout <= aluout;
		mdata_b <= edata_b;
		mrdrt <= erdrt;
		MEM_ins_type <= EXE_ins_type;
		MEM_ins_number <= EXE_ins_number;
	end
endmodule
