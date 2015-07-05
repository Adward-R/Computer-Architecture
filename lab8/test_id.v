`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:54:51 05/25/2014
// Design Name:   id_stage
// Module Name:   E:/pipeLineCPU-forward_31weiyanzheng/test_id.v
// Project Name:  pipeLineCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id_stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_id;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] if_inst;
	reg [31:0] if_pc4;
	reg [4:0] wb_destR;
	reg [31:0] wb_dest;
	reg wb_wreg;
	reg [3:0] IF_ins_type;
	reg [3:0] IF_ins_number;
	reg [4:0] which_reg;
	reg [31:0] mem_aluR;
	reg [31:0] mem_mdata;
	reg [31:0] ex_aluR;

	// Outputs
	wire cu_wreg;
	wire cu_m2reg;
	wire cu_wmem;
	wire [3:0] cu_aluc;
	wire cu_shift;
	wire cu_aluimm;
	wire cu_branch;
	wire [31:0] id_pc4;
	wire [31:0] id_inA;
	wire [31:0] id_inB;
	wire [31:0] id_imm;
	wire [4:0] id_destR;
	wire cu_wpcir;
	wire [3:0] ID_ins_type;
	wire [3:0] ID_ins_number;
	wire [31:0] reg_content;

	// Instantiate the Unit Under Test (UUT)
	id_stage uut (
		.clk(clk), 
		.rst(rst), 
		.if_inst(if_inst), 
		.if_pc4(if_pc4), 
		.wb_destR(wb_destR), 
		.wb_dest(wb_dest), 
		.wb_wreg(wb_wreg), 
		.cu_wreg(cu_wreg), 
		.cu_m2reg(cu_m2reg), 
		.cu_wmem(cu_wmem), 
		.cu_aluc(cu_aluc), 
		.cu_shift(cu_shift), 
		.cu_aluimm(cu_aluimm), 
		.cu_branch(cu_branch), 
		.id_pc4(id_pc4), 
		.id_inA(id_inA), 
		.id_inB(id_inB), 
		.id_imm(id_imm), 
		.id_destR(id_destR), 
		.cu_wpcir(cu_wpcir), 
		.IF_ins_type(IF_ins_type), 
		.IF_ins_number(IF_ins_number), 
		.ID_ins_type(ID_ins_type), 
		.ID_ins_number(ID_ins_number), 
		.which_reg(which_reg), 
		.reg_content(reg_content), 
		.mem_aluR(mem_aluR), 
		.mem_mdata(mem_mdata), 
		.ex_aluR(ex_aluR)
	);
parameter FULL_CYC = 40, HALF_CYC = FULL_CYC/2;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		if_inst = 0;
		if_pc4 = 0;
		wb_destR = 0;
		wb_dest = 0;
		wb_wreg = 0;
		IF_ins_type = 0;
		IF_ins_number = 0;
		which_reg = 0;
		mem_aluR = 0;
		mem_mdata = 0;
		ex_aluR = 0;

	// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
			#15;if_inst[31:0]=32'h8c090014;
		
		#FULL_CYC;
		if_inst[31:0] = 32'h00a64004;
		
		#FULL_CYC;
		if_inst[31:0] = 32'h01074806;
		
		#FULL_CYC;
		if_inst[31:0] = 32'h01075007;
		
		#FULL_CYC;
		if_inst[31:0] = 32'h01075007;
		
		#FULL_CYC;
		if_inst[31:0] = 32'h0c000011;
		
		#FULL_CYC;
		if_inst[31:0] = 32'h016a6023;
		#FULL_CYC;
		if_inst[31:0] = 32'h27eb0008;
		
	end

	

	always #HALF_CYC clk = ~clk;

      
endmodule

