`timescale 1ns / 1ps
`include "macro.vh"

module ctrl_unit(clk, rst, if_instr, instr, cu_branch, cu_wreg, cu_m2reg, cu_wmem, cu_aluc, cu_shift, cu_aluimm, 
						cu_sext, cu_regrt, cu_wpcir, cu_FWA, cu_FWB, cu_jump, rsrtequ,cu_jal,cu_jr);
	
	input clk;
	input rst;
	input [31:0] instr;
	input [31:0] if_instr;
	input rsrtequ;
	output wire cu_jal;
	output wire cu_jr;
	
	output cu_branch;
	output cu_wreg;
	output cu_m2reg;
	output cu_wmem;
	output [3:0] cu_aluc;
	output cu_shift;
	output cu_aluimm;
	output cu_sext;
	output cu_regrt;
	output cu_wpcir;
	output [1:0] cu_FWA;
	output [1:0] cu_FWB;
	output cu_jump;
	
	wire [5:0] func;
	wire [5:0] opcode;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	
	wire [5:0] if_func;
	wire [5:0] if_opcode;
	wire [4:0] if_rs;
	wire [4:0] if_rt;
	wire [4:0] if_rd; 
	
	wire [4:0] ex_rs;
	wire [4:0] ex_rt;
	wire [4:0] ex_rd;
	wire [4:0] mem_rt;
	wire [4:0] mem_rd;
	wire [4:0] wb_rd;
	wire [4:0] wb_rt;
	wire [5:0] ex_op;
	wire [5:0] ex_func;
	wire [5:0] mem_op;
	wire [5:0] wb_op;
	
	wire AfromEx;
	wire BfromEx;
	wire AfromMem;
	wire BfromMem;
	wire AfromExLW;
	wire BfromExLW;
	wire AfromMemLW;
	wire BfromMemLW;
	wire stall;
	wire cu_wpcir;
	wire [1:0] cu_FWA;
	wire [1:0] cu_FWB;

	reg [31:0] ex_instr;
	reg [31:0] mem_instr;
	reg [31:0] wb_instr;
	reg [3:0]  cu_aluc;
	
	assign opcode[5:0] =instr[31:26];
	assign rs[4:0] = instr[25:21];
	assign rt[4:0] = instr[20:16];
	assign rd[4:0] = instr[15:11];
	assign func[5:0] = instr[5:0];
	
	assign if_opcode[5:0] =if_instr[31:26];
	assign if_rs[4:0] = if_instr[25:21];
	assign if_rt[4:0] = if_instr[20:16];
	assign if_rd[4:0] = if_instr[15:11];
	assign if_func[5:0] = if_instr[5:0];
	
	assign ex_rs[4:0] = ex_instr[25:21];
	assign ex_rt[4:0] = ex_instr[20:16];
	assign ex_rd[4:0] = ex_instr[15:11];
	assign mem_rt[4:0] = mem_instr[20:16];
	assign mem_rd[4:0] = mem_instr[15:11];
	assign wb_rd[4:0] = wb_instr[15:11];
	assign wb_rt[4:0] = wb_instr[20:16];
	assign ex_op[5:0] = ex_instr[31:26];
	assign ex_func[5:0]=ex_instr[5:0];
	assign mem_op[5:0] = mem_instr[31:26];
	assign wb_op[5:0] = wb_instr[31:26];
		////////////////////////////////////////////////////////////////////////////////
	assign cu_jr  =(opcode == `OP_ALUOp)&&(func==`FUNC_JR);
	assign cu_jal =(opcode ==`OP_JAL);
	assign cu_branch = (((opcode == `OP_BEQ) && (rsrtequ == 1'b1)) || ((opcode == `OP_BNE) && (rsrtequ == 1'b0))||(opcode == `OP_JMP)||(opcode == `OP_JAL)||cu_jr==1)? 1 : 0;
	assign cu_regrt  =(opcode == `OP_ALUOp); //if instr type = R type then 0 else 1;
	assign cu_sext   =(opcode[5:1] == 5'b00100||opcode == `OP_LW || opcode ==`OP_SW ||
							 opcode == `OP_BEQ || opcode == `OP_BNE||opcode == `OP_SLTI);//when need to sign extend?
	assign cu_wreg   =(opcode!= `OP_JMP && opcode != `OP_SW && opcode != `OP_BEQ 
	                   && opcode != `OP_BNE&&(~((opcode == `OP_ALUOp)&&(func==`FUNC_JR))));//when need to write reg?
	assign cu_m2reg  =(opcode == `OP_LW);//when need to write mem to reg ?
	assign cu_wmem   =(opcode == `OP_SW);//when need to enable write mem?
	assign cu_shift  =(opcode == `OP_ALUOp && func[5:2] == 4'b0);
	assign cu_aluimm =(opcode != `OP_ALUOp && opcode !=`OP_BNE&&opcode !=`OP_BEQ &&opcode !=`OP_JAL);//when need to use imm?
	
	assign AfromEx = (rs == ex_rd) & (rs != 0) & (ex_op == `OP_ALUOp);    //当前需要的寄存器正在ex解读计算�forwarding path是第一�	assign BfromEx = (rt == ex_rd) & (rt != 0) & (ex_op == `OP_ALUOp);
	assign BfromEx = (rt == ex_rd) & (rt != 0) & (ex_op == `OP_ALUOp);
	assign AfromExI =(rs == ex_rt) & (rs != 0) & (ex_op == `OP_ADDI||
	       ex_op == `OP_ADDIU||ex_op == `OP_ANDI||ex_op == `OP_ORI||ex_op == `OP_XORI||ex_op == `OP_LUI);
	assign BfromExI =(rt == ex_rt) & (rt != 0) & (ex_op == `OP_ADDI||
	       ex_op == `OP_ADDIU||ex_op == `OP_ANDI||ex_op == `OP_ORI||ex_op == `OP_XORI||ex_op == `OP_LUI);
	
	
	assign AfromMem = (rs == mem_rd) & (rs != 0) & (mem_op == `OP_ALUOp); //当前需要的寄存器传到了mem阶段但是还没有wb �forwarding path是第二条
	assign BfromMem = (rt == mem_rd) & (rt != 0) & (mem_op == `OP_ALUOp);
	assign AfromMemI =(rs == mem_rt) & (rs != 0) & (mem_op == `OP_ADDI||
	       mem_op == `OP_ADDIU||mem_op == `OP_ANDI||mem_op == `OP_ORI||mem_op == `OP_XORI||mem_op == `OP_LUI);
	assign BfromMemI =(rt == ex_rt) & (rt != 0) & (ex_op == `OP_ADDI||
	       mem_op == `OP_ADDIU||mem_op == `OP_ANDI||mem_op == `OP_ORI||mem_op == `OP_XORI||mem_op == `OP_LUI);
	
	assign AfromExLW = (if_rs == rt) & (rs != 0) & (opcode == `OP_LW);    //提前检�当if_ins变为id_ins,它需要的寄存器处于ex阶段，但是是lw指令，所以还需要stall
	assign BfromExLW = (if_rt == rt) & (rt != 0) & (opcode == `OP_LW);
	
	assign AfromMemLW = (rs == mem_rt) & (rs != 0) & (mem_op == `OP_LW);  //当前需要的指令在mem阶段（是取出来的），所以forwarding path是第三条
	assign BfromMemLW = (rt == mem_rt) & (rt != 0) & (mem_op == `OP_LW);
	
	assign AfromJAL = (rs == 31'b11111) &(mem_op == `OP_JAL);  //当前需要的指令在mem阶段（是取出来的），所以forwarding path是第三条
	assign BfromJAL = (rt == 31'b11111) &(mem_op == `OP_JAL);
	
	
	assign cu_FWA[1:0] = (AfromEx == 1||AfromExI==1)? 2'b01 :((AfromMem == 1||AfromMemI == 1||AfromJAL==1)? 2'b10 : ((AfromMemLW == 1)? 2'b11 : 2'b00)); 
	assign cu_FWB[1:0] = (BfromEx == 1||BfromExI==1)? 2'b01 :((BfromMem == 1||BfromMemI == 1||BfromJAL==1)? 2'b10 : ((BfromMemLW == 1)? 2'b11 : 2'b00)); 

	assign stall = AfromExLW || BfromExLW;
	assign cu_wpcir = stall;
	assign cu_jump = (opcode == `OP_JMP)? 1 : 0;
	
	always @ (posedge clk or posedge rst)
		if(rst == 1)
		begin
		end
		else
		begin
			wb_instr[31:0] <= mem_instr[31:0];
			mem_instr[31:0] <= ex_instr[31:0];
			ex_instr[31:0] <= instr[31:0];
		end
	
	always @(clk) begin
			case(opcode)
				`OP_ADDI:  cu_aluc <=`ALU_ADD;//!
				`OP_ADDIU: cu_aluc <=`ALU_ADD;//!
				`OP_ANDI:  cu_aluc <=`ALU_AND;//!
				`OP_ORI:   cu_aluc <=`ALU_OR;//!
				`OP_XORI:  cu_aluc <=`ALU_XOR;//!
				`OP_LUI:   cu_aluc <=`ALU_LUI;//!
				`OP_LW:	   cu_aluc <=`ALU_ADD;
				`OP_SW:    cu_aluc <=`ALU_ADD;
				`OP_BNE:   cu_aluc <=`ALU_SUB;//!
				`OP_BEQ:   cu_aluc <=`ALU_SUB;//!
				`OP_SLTI:  cu_aluc <=`ALU_SLT;		
				`OP_SLTIU:  cu_aluc <=`ALU_SLTU;
				`OP_JAL:   cu_aluc <=`ALU_ADD;
				`OP_ALUOp: begin
					case(func)
						`FUNC_ADD: cu_aluc <= `ALU_ADD;
						`FUNC_ADDU: cu_aluc <= `ALU_ADD;
						`FUNC_SUB: cu_aluc <= `ALU_SUB;
						`FUNC_SUBU: cu_aluc <= `ALU_SUB;
						`FUNC_AND: cu_aluc <= `ALU_AND;
						`FUNC_OR: cu_aluc  <= `ALU_OR;
						`FUNC_XOR: cu_aluc  <= `ALU_XOR;
						`FUNC_NOR: cu_aluc <= `ALU_NOR;
						`FUNC_SLT: cu_aluc <= `ALU_SLT;
						`FUNC_SLTU: cu_aluc <= `ALU_SLTU;
						`FUNC_SLL: cu_aluc <= `ALU_SLL;
						`FUNC_SRL: cu_aluc <= `ALU_SRL;
						`FUNC_SRA: cu_aluc <= `ALU_SRA;
						`FUNC_SLLV: cu_aluc <= `ALU_SLL;
						`FUNC_SRLV: cu_aluc <= `ALU_SRL;
						`FUNC_SRAV: cu_aluc <= `ALU_SRA;
						default: cu_aluc <= `ALU_NONE;
					endcase
				end
				default: cu_aluc <= `ALU_NONE;
			endcase
		end
endmodule
