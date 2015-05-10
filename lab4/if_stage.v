`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:58 05/11/2014 
// Design Name: 
// Module Name:    if_stage 
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
`define OP_LW		6'b100011
`define OP_SW		6'b101011
`define OP_BEQ		6'b000100
`define OP_BNE 	6'b000101
`define OP_JMP		6'b000010
`define OP_NOP		32'b00000_100000
`define OP_ALUOp	6'b000000
`define OP_ADDI	6'b001000
`define OP_ANDI	6'b001100
`define OP_ORI		6'b001101

//ALU FUNCTION CODE
`define FUNC_ADD		6'b100000
`define FUNC_SUB		6'b100010
`define FUNC_AND		6'b100100
`define FUNC_OR		6'b100101
`define FUNC_NOR		6'b100111
`define FUNC_SLT		6'b101010
`define FUNC_SLL		6'b000000
`define FUNC_SRL		6'b000010
`define FUNC_SRA		6'b000011

//ALU CODE
`define ALU_ADD		4'b0000
`define ALU_SUB		4'b0010
`define ALU_AND		4'b0100
`define ALU_OR			4'b0101
`define ALU_NOR		4'b0111 
`define ALU_SLT		4'b1000
`define ALU_SLL		4'b1100
`define ALU_SRL		4'b1101
`define ALU_SRA		4'b1111
`define ALU_NONE		4'b1110

//INST TYPE CODE
`define	INST_TYPE_NOP	4'b0000
`define	INST_TYPE_ADD	4'b0001
`define	INST_TYPE_SUB	4'b0010
`define	INST_TYPE_AND	4'b0011
`define	INST_TYPE_OR	4'b0100
`define	INST_TYPE_NOR	4'b0101
`define	INST_TYPE_LW	4'b0110
`define	INST_TYPE_SW	4'b0111
`define	INST_TYPE_BEQ	4'b1000
`define	INST_TYPE_JMP	4'b1001
`define	INST_TYPE_BNE	4'b1010
`define	INST_TYPE_SLT	4'b1011
`define	INST_TYPE_SLL	4'b1100
`define	INST_TYPE_SRL	4'b1101
`define	INST_TYPE_SRA	4'b1110
`define	INST_TYPE_NONE	4'b1111
module if_stage (clk, rst, npc, nid_pc, ctrl_branch, 
	if_pc, if_pc4, if_inst, IF_ins_type,IF_ins_number,ID_ins_type,ID_ins_number);
				
	input clk;
	input rst;
	input [31:0] npc;
	input [31:0] nid_pc;
	input ctrl_branch;
	
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
	wire [31:0] nid_pc;
	wire [31:0] if_pc;
	wire [31:0] if_inst;
	wire [31:0] inst_m;
	reg [31:0] pc;
	reg run;
	reg [3:0] ID_ins_type;
	reg [3:0] ID_ins_number;
	
	initial begin
		pc[31:0]=32'hffffffff;
		run = 1'b0;
		ID_ins_type[3:0] = 4'b0000;
		ID_ins_number[3:0] = 4'b0000;
	end

	assign if_pc4 =pc+1;
	assign if_pc = ctrl_branch ? nid_pc:if_pc4 ;
	assign IF_ins_number[3:0] = npc[3:0] ;
	assign IF_ins_type[3:0] = `INST_TYPE_NONE;
	assign if_inst[31:0] = inst_m[31:0];
	
	always @ (posedge clk) begin
		pc[31:0] <= npc[31:0];
		run <= 1'b1;
	end

	always @(if_inst) begin
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
						`FUNC_SUB: begin
							ID_ins_type <= `INST_TYPE_SUB;
							end
						`FUNC_AND: begin
							ID_ins_type <= `INST_TYPE_AND;
							end
						`FUNC_OR: begin
							ID_ins_type <= `INST_TYPE_OR;
							end
						`FUNC_NOR: begin
							ID_ins_type <= `INST_TYPE_NOR;
							end
						`FUNC_SLT: begin
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
						default: begin
							ID_ins_type <= `INST_TYPE_NONE;
						end
					endcase
				end
				`OP_ADDI: begin
					ID_ins_type <= `INST_TYPE_ADD;
				end
				`OP_ANDI: begin
					ID_ins_type <= `INST_TYPE_AND;
				end
				`OP_ORI: begin
					ID_ins_type <= `INST_TYPE_OR;
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
				`OP_JMP: begin
					ID_ins_type <= `INST_TYPE_JMP;
				end
				`OP_BNE: begin
					ID_ins_type <= `INST_TYPE_BNE;
				end
				default: begin
					ID_ins_type <= `INST_TYPE_NONE;
				end
			endcase
		end
	end

	instr_mem x_inst_mem(.addra(pc[7:0]),.wea(0),.dina(0),.clka(~clk),.douta(inst_m));
endmodule
