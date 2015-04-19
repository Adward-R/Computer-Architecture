`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:10:20 04/16/2015
// Design Name:   top
// Module Name:   F:/Xilinx/LA/3120101964_ca/exp3/multi_cpu/test.v
// Project Name:  multi_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
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
	reg CCLK;
	reg BTN3_IN;
	reg BTN2_IN;

	// Outputs
	wire [7:0] LED;
	wire LCDE;
	wire LCDRS;
	wire LCDRW;
	wire [3:0] LCDDAT;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.CCLK(CCLK), 
		.BTN3_IN(BTN3_IN), 
		.BTN2_IN(BTN2_IN), 
		.LED(LED), 
		.LCDE(LCDE), 
		.LCDRS(LCDRS), 
		.LCDRW(LCDRW), 
		.LCDDAT(LCDDAT)
	);

	initial begin
		// Initialize Inputs
		CCLK = 0;
		BTN3_IN = 0;
		BTN2_IN = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		BTN2_IN = 1;
		#10;
		BTN2_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		BTN3_IN = 1;
		#10;
		BTN3_IN = 0;
		#10;
		forever #5 BTN3_IN = ~BTN3_IN;

	end
      
endmodule

