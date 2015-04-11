`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:27:39 05/18/2014
// Design Name:   MicroCtrl
// Module Name:   E:/TASKS/CO/Labs/Lab9/test.v
// Project Name:  Lab9
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MicroCtrl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [5:0] OP;
	wire [17:0] out;

	// Instantiate the Unit Under Test (UUT)
	MicroCtrl uut (
		.clk(clk), 
		.rst(rst), 
		.OP(OP), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
	end
	
	always begin
		clk=1;
		#25;
		clk=0;
		#25;
	end
	
      
endmodule

