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
module RegFile(clk, Rst, regA, regB, regW, Wdat, Adat, Bdat, RegWrite);//, regC, Cdat);
   input clk, Rst, RegWrite;
	input [4:0] regA, regB, regW;//, regC;
   input [31:0] Wdat;
   output [31:0] Adat, Bdat;//, Cdat;

   reg [31:0] iRegf[31:0];
 
	assign Adat = iRegf[regA];
	assign Bdat = iRegf[regB];
	//assign Cdat = iRegf[regC];
	
	always @(posedge clk or posedge Rst) begin
		if(Rst)begin
			iRegf[ 0] <= 0;
			iRegf[ 1] <= 1;
			iRegf[ 2] <= 2;
			iRegf[ 3] <= 3;
			iRegf[ 4] <= 4;
			iRegf[ 5] <= 5;
			iRegf[ 6] <= 6;
			iRegf[ 7] <= 7;
			iRegf[ 8] <= 8;
			iRegf[ 9] <= 9;
			iRegf[10] <= 10;
			iRegf[11] <= 11;
			iRegf[12] <= 12;
			iRegf[13] <= 13;
			iRegf[14] <= 14;
			iRegf[15] <= 15;
			iRegf[16] <= 16;
			iRegf[17] <= 17;
			iRegf[18] <= 18;
			iRegf[19] <= 19;
			iRegf[20] <= 20;
			iRegf[21] <= 21;
			iRegf[22] <= 22;
			iRegf[23] <= 23;
			iRegf[24] <= 24;
			iRegf[25] <= 25;
			iRegf[26] <= 26;
			iRegf[27] <= 27;
			iRegf[28] <= 28;
			iRegf[29] <= 29;
			iRegf[30] <= 30;
			iRegf[31] <= 31;
		end else
			if(RegWrite) begin
				iRegf[regW] <= (regW == 5'b00000) ? 32'h0 : Wdat;
			end
	end

endmodule

/*
module Register(clk, Rst, RegWrite, idat, odat);
	input	clk, Rst, RegWrite;
	input[31:0]		idat;
	output[31:0]	odat;
	reg[31:0]		odat;

	always @(posedge clk) begin
		if(Rst)odat<=0;
		else if(RegWrite)odat <= idat;
	end
endmodule*/
