`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:51 03/18/2014 
// Design Name: 
// Module Name:    reg_id_exe 
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
module Reg_ID_EXE(clk,rst,wreg,	m2reg, wmem, aluc, shift, aluimm,  data_a, data_b, data_imm, id_branch,id_pc4, id_regrt,id_rt,id_rd,//inputs
	ewreg,em2reg,	ewmem,ealuc, eshift, ealuimm, odata_a,odata_b, odata_imm, e_branch, e_pc4,e_regrt,e_rt,e_rd,
	ID_ins_type, ID_ins_number, EXE_ins_type, EXE_ins_number,id_FWA,id_FWB,mem_aluR,wb_dest,ex_fwa,ex_fwb,id_destR,ex_destR);	//outputs
	input		clk;
	input		rst;
	input 	wreg,	m2reg,	wmem,	shift,	aluimm;
	input [3:0] 	aluc;
	input [31:0] data_a,	data_b,	data_imm;
	input id_branch;
	input [31:0]id_pc4;
	input [4:0]id_regrt;
	input [4:0]id_rt;
	input [4:0]id_rd;
	input[3:0] 	ID_ins_type;
	input[3:0] ID_ins_number;
   input [4:0] id_destR;
   input [1:0] id_FWA,id_FWB;
	input [31:0] mem_aluR,wb_dest;
	
	output reg [1:0] ex_fwa,ex_fwb;
   output reg [4:0] ex_destR;
	output 	ewreg,	em2reg,	ewmem,	eshift,	ealuimm;
	output [3:0] 	ealuc;
	output [31:0] odata_a,odata_b,odata_imm;
	output e_branch;
	output[31:0] e_pc4;
	output e_regrt;
	output [4:0] e_rt;
	output [4:0] e_rd;
	output[3:0] EXE_ins_type;
	output[3:0] EXE_ins_number;
	
	reg[3:0] EXE_ins_type;
	reg[3:0] EXE_ins_number;
	reg 	ewreg,	em2reg,	ewmem,	eshift,	ealuimm;
	reg [3:0] 	ealuc;
	reg [31:0] odata_a,odata_b,odata_imm;
	reg [31:0] 	e_pc4;
	reg e_branch;
	reg e_regrt;
	reg [4:0]e_rt;
	reg [4:0]e_rd;
	
	//output reg [1:0] fa,fb;
	
	
	always@(posedge clk) begin
	if(ID_ins_type!=0)begin
		ewreg <= wreg;
		em2reg <= m2reg;
		ewmem <= wmem;
		eshift <= shift;
		ealuimm <= aluimm;
		ealuc <= aluc;
	   odata_a <= data_a;
		odata_b <=data_b;
		odata_imm <= data_imm;
		EXE_ins_type <= (id_branch==1)?0:ID_ins_type;
		EXE_ins_number <= ID_ins_number;
		e_branch <= id_branch;
		e_pc4 <= id_pc4;
		e_regrt <= id_regrt;
		e_rt <= id_rt;
		e_rd <= id_rd;
	   ex_fwa<=id_FWA;
		ex_fwb<=id_FWB;
		ex_destR<=id_destR;
	end
	end
endmodule

module imm2sa(odata_imm,sa);
	input[31:0] odata_imm;
	output[31:0] sa;
	
	assign sa = {27'b0,odata_imm[10:6]};
endmodule

