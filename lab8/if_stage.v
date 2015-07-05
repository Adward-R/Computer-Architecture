`timescale 1ns / 1ps
`include "macro.vh"

module if_stage(CCLK,clk, rst, npc, nid_pcc, ctrl_branch, id_wpcir, 
	if_pc, if_pc4, if_inst, IF_ins_type,IF_ins_number,ID_ins_type,ID_ins_number,pc);
				
	input CCLK,clk;
	input rst;
	input [31:0] npc;
	input [31:0] nid_pcc;
	input ctrl_branch;
	input id_wpcir;
	
	output [31:0] if_pc;
	output [31:0] if_pc4;
	output [31:0] if_inst;
	output [3:0] IF_ins_number;
	output [3:0] IF_ins_type;
	output [3:0] ID_ins_type;
	output [3:0] ID_ins_number;
	
	wire clk;
	wire rst;
	wire ctrl_branch;
	wire id_wpcir;
	wire [31:0] nid_pcc;
	wire [31:0] if_pc;
	wire [31:0] if_inst;
	wire [31:0] inst_m;
	output reg [31:0] pc;
	reg run;
	reg [3:0] ID_ins_type;
	reg [3:0] ID_ins_number;
	
	initial begin
		pc[31:0]=32'hffffffff;
		run = 1'b0;
		ID_ins_type[3:0] = 4'b0000;
		ID_ins_number[3:0] = 4'b0000;
	end

	assign if_pc4 = (id_wpcir && (pc != 32'hffffffff))? pc : pc + 1;
	assign if_pc = ctrl_branch? nid_pcc : if_pc4;
	assign IF_ins_number[3:0] = npc[3:0];
	assign IF_ins_type[3:0] = `INST_TYPE_NONE;
	assign if_inst[31:0] = inst_m[31:0];
	
	always @ (posedge clk) begin
		if (id_wpcir != 1) begin
			pc[31:0] <= npc[31:0];
			run <= 1'b1;
		end
	end
  
	always @(if_inst) begin
		if (id_wpcir != 1) begin
			if (run == 1'b0) begin	//for initial 0
				ID_ins_type[3:0] <= 4'b0000;
				ID_ins_number[3:0] <= 4'b0000;
			end
			else
			begin
				ID_ins_number[3:0] <= pc[3:0];
				case (if_inst[31:26])
					`OP_ALUOp: begin		//R-type
						case(if_inst[5:0])
							`FUNC_ADD: begin
								ID_ins_type <= `INST_TYPE_ADD;
								end
							`FUNC_ADDU: begin
								ID_ins_type <= `INST_TYPE_ADD;
								end
							`FUNC_SUB: begin
								ID_ins_type <= `INST_TYPE_SUB;
								end
							`FUNC_SUBU: begin
								ID_ins_type <= `INST_TYPE_SUB;
								end
							`FUNC_AND: begin
								ID_ins_type <= `INST_TYPE_AND;
								end
							`FUNC_OR: begin
								ID_ins_type <= `INST_TYPE_OR;
								end
							`FUNC_XOR: begin
								ID_ins_type <= `INST_TYPE_XOR;
								end
							`FUNC_NOR: begin
								ID_ins_type <= `INST_TYPE_NOR;
								end
							`FUNC_SLT: begin
								ID_ins_type <= `INST_TYPE_SLT;
								end
							`FUNC_SLTU: begin
								ID_ins_type <= `INST_TYPE_SLT;
								end
							`FUNC_SLL: begin
								ID_ins_type <= `INST_TYPE_SLL;
								end
							`FUNC_SRL: begin
								ID_ins_type <= `INST_TYPE_SRL;
								end
							`FUNC_SRA: begin
								ID_ins_type <= `INST_TYPE_SRA;
								end
							`FUNC_SLLV: begin
								ID_ins_type <= `INST_TYPE_SLL;
								end
							`FUNC_SRLV: begin
								ID_ins_type <= `INST_TYPE_SRL;
								end
							`FUNC_SRAV: begin
								ID_ins_type <= `INST_TYPE_SRA;
								end
							`FUNC_JR: begin
								ID_ins_type <= `INST_TYPE_JR;
								end
							default: begin
								ID_ins_type <= `INST_TYPE_NONE;
							end
						endcase
					end
					`OP_ADDI: begin
						ID_ins_type <= `INST_TYPE_ADD;
					end
					`OP_ADDIU: begin
						ID_ins_type <= `INST_TYPE_ADD;
					end
					`OP_ANDI: begin
						ID_ins_type <= `INST_TYPE_AND;
					end
					`OP_ORI: begin
						ID_ins_type <= `INST_TYPE_OR;
					end
					`OP_XORI: begin
						ID_ins_type <= `INST_TYPE_XOR;
					end
					`OP_LUI: begin
						ID_ins_type <= `INST_TYPE_LUI;
					end
					`OP_LW: begin
						ID_ins_type <= `INST_TYPE_LW;
					end
					`OP_SW: begin
						ID_ins_type <= `INST_TYPE_SW;
					end
					`OP_BEQ: begin
						ID_ins_type <= `INST_TYPE_BEQ;
					end
					`OP_BNE: begin
						ID_ins_type <= `INST_TYPE_BNE;
					end
					`OP_SLTI: begin
						ID_ins_type <= `INST_TYPE_SLT;
					end
					`OP_SLTIU: begin
						ID_ins_type <= `INST_TYPE_SLT;
					end
					`OP_JAL: begin
						ID_ins_type <= `INST_TYPE_JAL;
					end
					`OP_JMP: begin
						ID_ins_type <= `INST_TYPE_JMP;
					end
					default: begin
						ID_ins_type <= `INST_TYPE_NOP;
					end
				endcase
			end
		end
	end
	
	imem x_inst_mem(.addra(pc[7:0]),.clka(~CCLK),.douta(inst_m));
endmodule
