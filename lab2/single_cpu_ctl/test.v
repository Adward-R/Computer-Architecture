`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:43:05 03/16/2014
// Design Name:   ctltop
// Module Name:   D:/lab2/test1.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ctltop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test1;

	// Inputs
	reg clk;
	reg [5:0] OP;

	// Outputs
	wire RegDst;
	wire ALUsrc;
	wire [1:0] ALUop;
	wire MemtoReg;
	wire RegWrite;
	wire MemRead;
	wire MemWrite;
	wire Branch;
	wire Jump;

	// Instantiate the Unit Under Test (UUT)
	ctltop uut (
		.clk(clk), 
		.OP(OP), 
		.RegDst(RegDst), 
		.ALUsrc(ALUsrc), 
		.ALUop(ALUop), 
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.Branch(Branch), 
		.Jump(Jump)
	);

	initial begin
		OP=6'b000000;
		#160	OP=6'b100011;
		#160	OP=6'b101011;
		#160	OP=6'b000100;
		#160	OP=6'b000010;
		#1000	$dumpflush;
		$stop;


	end
      
endmodule

