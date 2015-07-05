`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:47:53 05/13/2014
// Design Name:   ctrl_unit
// Module Name:   D:/pipeLineCPU-forward_bne512/testc.v
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

module testc;

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

		#15;if_instr[31:0]=32'h8c010014;
		
		#FULL_CYC;
		instr[31:0]=32'h8c010015;
		if_instr[31:0] = 32'h8c010015;
		
		#FULL_CYC;
		instr[31:0] = 32'h8c010015;
		if_instr[31:0] = 32'h0021_1020;
		
		#FULL_CYC;
		instr[31:0] = 32'h0021_1020;
		if_instr[31:0] = 32'h0022_1822;
		
		#FULL_CYC;
		instr[31:0] = 32'h0022_1822;
		if_instr[31:0] = 32'h1021_0002;
		
		#FULL_CYC;
		instr[31:0] = 32'h1021_0002;
		if_instr[31:0] = 32'h0064_2824;
		
		#FULL_CYC;
		instr[31:0] = 32'h0064_2824;
		if_instr[31:0] = 32'h0085_3027;
		
		#FULL_CYC;
		instr[31:0] = 32'h0085_3027;
		if_instr[31:0] = 32'hac06_0016;
		
		#FULL_CYC;
		instr[31:0] = 32'hac06_0016;
		if_instr[31:0] = 32'h10c7_fff8;		
	end

	

	always #HALF_CYC clk = ~clk;



      
endmodule

