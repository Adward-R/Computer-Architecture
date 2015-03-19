`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:01 02/27/2007 
// Design Name: 
// Module Name:    Regf 
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
module RegFile(clk, Rst, regA, regB, regW, Wdat, Adat, Bdat, RegWrite);
   input clk, Rst;
	input [4:0] regA, regB, regW;
   input [31:0] Wdat;
   input RegWrite;
	 
   output [31:0] Adat, Bdat;

   reg [31:0] regf[31:0];
    
	assign Adat = regf[regA];
	assign Bdat = regf[regB];

integer	i;
	always @(posedge clk or posedge Rst) begin
		if (Rst) begin
			for(i=0; i<32; i=i+1)regf[i] <= i;
		end
	end
	
	always @(negedge clk) begin
		if(RegWrite) begin
			regf[regW] <= (regW == 5'b00000) ? 32'h0 : Wdat;
		end
	end

endmodule
