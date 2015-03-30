`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:19 03/16/2014 
// Design Name: 
// Module Name:    single_ctl 
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
module single_ctl(rst, OP, RegDst, ALUsrc, ALUop, MemtoReg,
RegWrite, MemRead, MemWrite, Branch, Jump);
   input rst;
   input [5:0] OP;
   output RegDst;
   output ALUsrc;
   output [1:0] ALUop;
   output MemtoReg;
   output RegWrite;
   output MemRead;
   output MemWrite;
   output Branch;
   output Jump;
	wire 	 R, LW, SW, BEQ;
	
	assign R  = ~OP[0]&~OP[1]&~OP[2]&~OP[3]&~OP[4]&~OP[5] & ~rst;
	assign LW =  OP[0]& OP[1]&~OP[2]&~OP[3]&~OP[4]& OP[5] & ~rst;
	assign SW =  OP[0]& OP[1]&~OP[2]& OP[3]&~OP[4]& OP[5] & ~rst;
	assign BEQ= ~OP[0]&~OP[1]& OP[2]&~OP[3]&~OP[4]&~OP[5] & ~rst;
	assign J  = ~OP[0]& OP[1]&~OP[2]&~OP[3]&~OP[4]&~OP[5] & ~rst;
   assign ALUop[0]   = BEQ & ~rst;
	assign ALUop[1]   = R & ~rst;
	assign RegDst		= R & ~rst;
	assign RegWrite	= R | LW & ~rst;
	assign Branch		= BEQ & ~rst;
	assign MemtoReg	= LW & ~rst;
	assign MemRead		= LW & ~rst;
	assign MemWrite	= SW & ~rst;
	assign ALUsrc		= LW | SW & ~rst;
	assign Jump       = J & ~rst;
endmodule