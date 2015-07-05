`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:31:12 05/25/2014
// Design Name:   ctrl_unit
// Module Name:   D:/pipeLineCPU-forward_31weiyanzheng/test_cu.v
// Project Name:  pipeLineCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ctrl_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_cu;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] if_instr;
	reg [31:0] instr;
	reg rsrtequ;

	// Outputs
	wire cu_branch;
	wire cu_wreg;
	wire cu_m2reg;
	wire cu_wmem;
	wire [3:0] cu_aluc;
	wire cu_shift;
	wire cu_aluimm;
	wire cu_sext;
	wire cu_regrt;
	wire cu_wpcir;
	wire [1:0] cu_FWA;
	wire [1:0] cu_FWB;
	wire cu_jump;
	wire cu_jal;
	wire cu_jr;

	// Instantiate the Unit Under Test (UUT)
	ctrl_unit uut (
		.clk(clk), 
		.rst(rst), 
		.if_instr(if_instr), 
		.instr(instr), 
		.cu_branch(cu_branch), 
		.cu_wreg(cu_wreg), 
		.cu_m2reg(cu_m2reg), 
		.cu_wmem(cu_wmem), 
		.cu_aluc(cu_aluc), 
		.cu_shift(cu_shift), 
		.cu_aluimm(cu_aluimm), 
		.cu_sext(cu_sext), 
		.cu_regrt(cu_regrt), 
		.cu_wpcir(cu_wpcir), 
		.cu_FWA(cu_FWA), 
		.cu_FWB(cu_FWB), 
		.cu_jump(cu_jump), 
		.rsrtequ(rsrtequ), 
		.cu_jal(cu_jal), 
		.cu_jr(cu_jr)
	);
parameter FULL_CYC = 40, HALF_CYC = FULL_CYC/2;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		if_instr = 0;
		instr = 0;
		rsrtequ = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
			#15;if_instr[31:0]=32'h8c090014;
		
		#FULL_CYC;
		instr[31:0]=32'h8c090014;
		if_instr[31:0] = 32'h8c0a0015;
		
		#FULL_CYC;
		instr[31:0] = 32'h8c0a0015;
		if_instr[31:0] = 32'h012a5820;
		
		#FULL_CYC;
		instr[31:0] = 32'h012a5820;
		if_instr[31:0] = 32'h012b4022;
		
		#FULL_CYC;
		instr[31:0] = 32'h012b4022;
		if_instr[31:0] = 32'h0c000025;
		
		#FULL_CYC;
		instr[31:0] = 32'h0c000025;
		if_instr[31:0] = 32'h01896821;
		
		#FULL_CYC;
		instr[31:0] = 32'h01896821;
		if_instr[31:0] = 32'h016a6023;
		
	end

	

	always #HALF_CYC clk = ~clk;




      
endmodule

