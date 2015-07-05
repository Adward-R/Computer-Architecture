//control_unit
`include "macro.vh"	

module ctrl_unit(clk, rst, if_instr, instr, 
	cu_branch, cu_wreg, cu_m2reg, cu_wmem, cu_aluc, cu_shift, cu_aluimm, cu_sext,cu_regrt,cu_wpcir,fwA,fwB,if_rs,cu_jump,cu_equ);
	
	input clk;
	input rst;
	input [31:0] instr;
	input [31:0] if_instr;
	
	output cu_branch;
	output cu_wreg;
	output cu_m2reg;
	output cu_wmem;
	output [3:0] cu_aluc;
	output cu_shift;
	output cu_aluimm;
	output cu_sext;
	output [4:0]cu_regrt;
	output wire cu_wpcir;
	output wire[1:0] fwA,fwB;
	
	
	input wire cu_equ;
	output wire cu_jump;
	
	wire [5:0] func;
	wire [5:0] opcode;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	
	wire [5:0] if_func;
	wire [5:0] if_opcode;
	output wire [4:0] if_rs;
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
	wire [5:0] mem_op;
	wire [5:0] wb_op;
	wire stall;
	wire AfromEx;
	wire BfromEx;
	wire AfromMem;
	wire BfromMem;
	wire AfromExLW;
	wire BfromExLW;
	wire AfromMemLW;
	wire BfromMemLW;

	reg [31:0] ex_instr;
	reg [31:0] mem_instr;
	reg [31:0] wb_instr;
	reg [3:0] cu_aluc;

	
	assign opcode[5:0] =instr[31:26];
	assign rs[4:0] = instr[25:21];
	assign rt[4:0] =((instr[31:26]==`OP_ALUOp)||(instr[31:26]==`OP_BEQ))?instr[20:16]:instr[25:21];
	assign rd[4:0] = (instr[31:26]==`OP_ALUOp)?instr[15:11]:instr[20:16];
	assign func[5:0] = instr[5:0];
	
	assign if_opcode[5:0] = if_instr[31:26];
	assign if_rs[4:0] = if_instr[25:21];
	assign if_rt[4:0] = if_instr[31:26]==`OP_ALUOp?if_instr[20:16]:if_instr[25:21];
	assign if_rd[4:0] = if_instr[31:26]==`OP_ALUOp?if_instr[15:11]:if_instr[20:16];
	assign if_func[5:0] = if_instr[5:0];
	
	assign ex_rs[4:0] = ex_instr[25:21];
	assign ex_rt[4:0] = ex_instr[31:26]==`OP_ALUOp?ex_instr[20:16]:ex_instr[25:21];
	assign ex_rd[4:0] = ex_instr[31:26]==`OP_ALUOp?ex_instr[15:11]:ex_instr[20:16];
	assign mem_rt[4:0] = mem_instr[31:26]==`OP_ALUOp?mem_instr[20:16]:mem_instr[25:21];
	assign mem_rd[4:0] = mem_instr[31:26]==`OP_ALUOp?mem_instr[15:11]:mem_instr[20:16];
	
	assign wb_rd[4:0] = wb_instr[20:16];
	assign wb_rt[4:0] = wb_instr[25:21];
	assign ex_op[5:0] = ex_instr[31:26];
	assign mem_op[5:0] = mem_instr[31:26];
	assign wb_op[5:0] = wb_instr[31:26];
	
	assign cu_branch =(opcode==`OP_BEQ||opcode==`OP_BNE)?1:0; //if instr type is branch type then 1 else 0
	assign cu_regrt =opcode==`OP_ALUOp?0:1; //if instr type = R type then 0 else 1;
	assign cu_sext =((opcode==`OP_ANDI)||(opcode==`OP_ADDI)||(opcode==`OP_ORI)||opcode==`OP_SW||opcode==`OP_LW||opcode==`OP_BEQ)?1:0;//when need to sign extend?
	assign cu_wreg =((opcode==`OP_ALUOp)||(opcode==`OP_ANDI)||(opcode==`OP_ADDI)||(opcode==`OP_ORI)||opcode==`OP_LW)?1:0;//when need to write reg?
	assign cu_m2reg =opcode==`OP_LW?1:0;//when need to write mem to reg ?
	assign cu_wmem =opcode==`OP_SW?1:0;//when need to enable write mem?
	assign cu_shift = ((opcode == `OP_ALUOp) && (func[5:2] == 4'b0))? 1 : 0;
	assign cu_aluimm =((opcode==`OP_ANDI)||(opcode==`OP_ADDI)||(opcode==`OP_ORI)||opcode==`OP_SW||opcode==`OP_LW)?1:0;//when need to use imm?
	
	assign AfromEx = (rs==ex_rd) & (rs!= 0) & ((opcode ==`OP_ALUOp)||(opcode==`OP_BEQ)); //exam 3's work
	assign BfromEx = (rt==ex_rd) & (rt!= 0) & ((opcode ==`OP_ALUOp)||(opcode==`OP_BEQ));
	assign AfromMem = (rs==mem_rd) && (rs!= 0) && ((ex_op ==`OP_ALUOp)||(ex_op ==`OP_LW));
	assign BfromMem = (rt==mem_rd) & (rt!= 0) & ((ex_op ==`OP_ALUOp)|(ex_op ==`OP_LW));
	assign AfromExLW = (if_rs==rd) & (if_rs!= 0) & (opcode ==`OP_LW);
	assign BfromExLW = (if_rt==rd) & (if_rt!= 0) & (opcode ==`OP_LW);
	
	assign fwA[1:0]=(AfromEx==1)?2'b01:((AfromMem==1)?2'b10:2'b00);
	assign fwB[1:0]=(BfromEx==1)?2'b01:((BfromMem==1)?2'b10:2'b00);
	assign stall = AfromExLW||BfromExLW;
	assign cu_wpcir = stall;//exam 3's work

	assign cu_jump=(opcode==`OP_JMP)?1:0;
	
	always @ (posedge clk or posedge rst)
		if(rst == 1)begin
		end
		else begin
			wb_instr[31:0] <= mem_instr[31:0];
			mem_instr[31:0] <= ex_instr[31:0];
			ex_instr[31:0] <= instr[31:0];
		end
	
	always @(opcode) begin
			case(opcode)
				`OP_BNE: cu_aluc <=`ALU_SUB;//!
				`OP_BEQ: cu_aluc <=`ALU_SUB;//!
				`OP_ADDI: cu_aluc <=`ALU_ADD;//!
				`OP_ANDI: cu_aluc <=`ALU_AND;//!
				`OP_ORI: cu_aluc <=`ALU_OR;//!
				`OP_LW: cu_aluc <= `ALU_ADD;
				`OP_SW: cu_aluc <= `ALU_ADD;
				`OP_ALUOp: begin
					case(func)
						`FUNC_ADD: cu_aluc <= `ALU_ADD;
						`FUNC_SUB: cu_aluc <= `ALU_SUB;
						`FUNC_AND: cu_aluc <= `ALU_AND;
						`FUNC_OR: cu_aluc <= `ALU_OR;
						`FUNC_NOR: cu_aluc <= `ALU_NOR;
						`FUNC_SLT: cu_aluc <= `ALU_SLT;
						`FUNC_SLL: cu_aluc <= `ALU_SLL;
						`FUNC_SRL: cu_aluc <= `ALU_SRL;
						`FUNC_SRA: cu_aluc <= `ALU_SRA;
						default: cu_aluc <= `ALU_NONE;
					endcase
				end
				default: cu_aluc <= `ALU_NONE;
			endcase
		end
endmodule

