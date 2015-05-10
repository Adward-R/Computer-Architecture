`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:51 05/11/2014 
// Design Name: 
// Module Name:    alu 
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
module alu(i_r,i_s,i_aluc,o_alu);
	input [31:0] i_r;		//i_r: r input
	input [31:0] i_s;		//i_s: s input
	input [3:0] i_aluc;		//i_aluc: ctrl input
	output [31:0] o_alu;		//o_alu: alu result output
	reg [31:0] o_alu;
	reg [63:0] tem;
	
	always @(i_aluc or i_r or i_s) begin
		case (i_aluc)
			4'b0000:begin
				o_alu=i_r+i_s;
				end
			4'b0010:begin
				o_alu=i_r-i_s;
				end
			4'b0100:begin
				o_alu=i_r&i_s;
				end
			4'b0101:begin
				o_alu=i_r|i_s;
				end
			4'b0111:begin
				o_alu=~(i_r|i_s);
				end
			4'b1000:begin
				if (i_r < i_s)
					o_alu=1;
				else 
					o_alu=0;
				end
			4'b1100:begin
				o_alu=i_r<<i_s;
				end
			4'b1101:begin
				o_alu=i_r>>i_s;
				end
			4'b1111:begin
				tem=i_r[31]?{{32'hFFFFFFFF},i_r}:{32'h0,i_r};
				tem=(tem<<i_s);
				o_alu=tem[31:0];
				end
			4'b1110:begin
				end
			default:begin
				o_alu=i_r+i_s;
				end
		endcase
	end
endmodule
