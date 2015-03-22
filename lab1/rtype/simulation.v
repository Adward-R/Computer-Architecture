`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:30:21 03/22/2015
// Design Name:   Rtype
// Module Name:   Z:/Users/Adward/GitHub/Computer-Architecture/lab1/rtype/simulation.v
// Project Name:  rtype
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Rtype
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module simulation;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] instru;

	// Outputs
	wire [31:0] Adat;
	wire [31:0] Bdat;
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	Rtype uut (
		.clk(clk), 
		.rst(rst), 
		.instru(instru), 
		.Adat(Adat), 
		.Bdat(Bdat), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		instru = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
		#100;
		rst = 0;
		#100;
		instru = 32'h01A88020;
		#110;
		instru = 32'h01C98822;
		#110;
		instru = 32'h01EA9024;
		#110;
		instru = 32'h030B9825;
		#110;
		instru = 32'h032CA02A;
		#100;
	end
	
	always
		#20 clk = !clk;
		
endmodule

