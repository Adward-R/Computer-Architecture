`timescale 1ns / 1ps
`include "macro.vh"

module Alu(a_in, b_in, aluc, res);
	input  [31:0]	a_in;
	input  [31:0]	b_in;
	input  [3:0]	aluc;
	output [31:0]	res;
	wire   [31:0]	a_in;
	wire   [31:0]	b_in;
	wire   [3:0]	aluc;
	reg    [31:0]	res;

	always @ (aluc or a_in or b_in)
		case (aluc)
			`ALU_ADD: res = a_in + b_in;
			`ALU_SUB: res = a_in - b_in;
			`ALU_LUI: res = b_in <<16; 
			`ALU_AND: res = a_in & b_in;
			`ALU_OR:  res = a_in  | b_in;
			`ALU_XOR: res = a_in ^ b_in;
			`ALU_NOR: res = ~(a_in | b_in);
			`ALU_SLT: res = $signed(a_in) < $signed(b_in);
			`ALU_SLTU:res = a_in < b_in;
			`ALU_SLL: res = b_in << a_in;
			`ALU_SRL: res = b_in >> a_in;
			`ALU_SRA: res = $signed(b_in) >>> a_in;
			`ALU_NONE:res = 0;
		endcase
endmodule
