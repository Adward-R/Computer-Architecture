`include "macro.vh"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:26 03/20/2012 
// Design Name: 
// Module Name:    id_stage 
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
module id_stage(clk, rst, if_inst, if_pc4, wb_destR, wb_dest, wb_wreg, 
	cu_wreg, cu_m2reg, cu_wmem, cu_aluc, cu_shift, cu_aluimm, cu_branch, id_pc4, id_inA, id_inB, id_imm, id_destR, 
	cu_wpcir, IF_ins_type, IF_ins_number, ID_ins_type, ID_ins_number, which_reg, reg_content, mem_aluR, mem_mdata, ex_aluR);
	
	input clk;
	input rst;
	input [31:0] if_inst;
	input [31:0] if_pc4;
	
	input [4:0]  wb_destR;
	input [31:0] wb_dest;
	input wb_wreg;
	input [31:0] mem_aluR;
	input [31:0] mem_mdata;
	input [31:0] ex_aluR;
	
	input [3:0] IF_ins_type;
	input [3:0] IF_ins_number;
	
	input [4:0]   which_reg;
	output [31:0] reg_content;
	
	output cu_branch;
	output cu_wreg;
	output cu_m2reg;
	output cu_wmem;
	output [3:0] cu_aluc;
	output cu_shift;
	output cu_aluimm;
	output [31:0] id_pc4;
	output [31:0] id_inA;
	output [31:0] id_inB;
	output [31:0] id_imm;
	output [4:0]  id_destR;
	output cu_wpcir;
	
	output [3:0] ID_ins_type;
	output [3:0] ID_ins_number;
	
	wire cu_sext;
	wire cu_regrt;
	wire cu_branch;
	wire rsrtequ;
	wire cu_jump;
	wire cu_jr;
	wire cu_jal;
	wire [31:0]id_inB1;
	wire [31:0]id_inA1;
	
	reg [31:0] reg_inst;
	reg [31:0] pc4;
	
	wire [31:0] rdata_A;
	wire [31:0] rdata_B;
	wire [15:0] imm;
	wire [31:0] id_imm;
	wire [1:0] cu_FWA;
	wire [1:0] cu_FWB;
	
	wire [31:0] id_pc4;
	
	reg [3:0] ID_ins_type;
	reg [3:0] ID_ins_number;
	
	assign imm = reg_inst[15:0];
	assign id_destR = cu_jal ? 5'b11111:(cu_regrt? reg_inst[15:11] : reg_inst[20:16]);
	assign id_imm = cu_sext? (imm[15]? {16'hFFFF, imm} : {16'b0, imm}) : {16'b0, imm};
	assign id_pc4 = cu_jr?id_inA:((cu_jump||cu_jal)? {6'b0, reg_inst[25:0]} : (id_imm + if_pc4 - 1)); ///////modify’‚¿Ô
	assign id_inA1 = (cu_FWA == 2'b00)? rdata_A : ((cu_FWA == 2'b01)? ex_aluR : ((cu_FWA == 2'b10)? mem_aluR : mem_mdata));
	assign id_inB1 = (cu_FWB == 2'b00)? rdata_B : ((cu_FWB == 2'b01)? ex_aluR : ((cu_FWB == 2'b10)? mem_aluR : mem_mdata));
	assign id_inB = cu_jal?32'b0 :id_inB1;
	assign id_inA = cu_jal?(if_pc4-1):id_inA1;
	assign rsrtequ = (id_inA1 == id_inB1)? 1 : 0;
	
	always @ (posedge clk or posedge rst)
		if (rst==1)
		begin
		end
		else
		begin
			reg_inst <= (cu_jump || (cu_branch)||cu_wpcir)? 32'h0000_0000 : if_inst;
			pc4 <= if_pc4;
			ID_ins_type <= (cu_jump ||(cu_branch)|| cu_wpcir)? `INST_TYPE_NOP : IF_ins_type;
			ID_ins_number <= IF_ins_number;		
		end
	
	regfile x_regfile(clk, rst, reg_inst[25:21], reg_inst[20:16], wb_destR, wb_dest, wb_wreg, rdata_A, rdata_B,
			which_reg, reg_content);
	ctrl_unit x_ctrl_unit(clk, rst, if_inst[31:0], reg_inst[31:0],
			cu_branch, cu_wreg, cu_m2reg, cu_wmem, cu_aluc, cu_shift, cu_aluimm, cu_sext, cu_regrt, cu_wpcir, cu_FWA, cu_FWB, 
			cu_jump, rsrtequ,cu_jal,cu_jr);
endmodule
