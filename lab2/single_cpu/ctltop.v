`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:11 03/16/2014 
// Design Name: 
// Module Name:    ctltop 
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
module ctltop(clk, OP, RegDst, ALUsrc, ALUop, MemtoReg,
RegWrite, MemRead, MemWrite, Branch, Jump);
   input clk;
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
	
	assign R  = ~OP[0]&~OP[1]&~OP[2]&~OP[3]&~OP[4]&~OP[5];
	assign LW =  OP[0]& OP[1]&~OP[2]&~OP[3]&~OP[4]& OP[5];
	assign SW =  OP[0]& OP[1]&~OP[2]& OP[3]&~OP[4]& OP[5];
	assign BEQ= ~OP[0]&~OP[1]& OP[2]&~OP[3]&~OP[4]&~OP[5];
	assign J  = ~OP[0]& OP[1]&~OP[2]&~OP[3]&~OP[4]&~OP[5];
   assign ALUop[0]   = BEQ;
	assign ALUop[1]   = R;
	assign RegDst		= R;
	assign RegWrite	= R | LW;
	assign Branch		= BEQ;
	assign MemtoReg	= LW;
	assign MemRead		= LW;
	assign MemWrite	= SW;
	assign ALUsrc		= LW | SW;
	assign Jump       = J;
endmodule
