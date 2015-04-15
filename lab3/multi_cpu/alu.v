`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:27:31 03/30/2014 
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
	input [1:0] i_aluc;		//i_aluc: ctrl input
	output [31:0] o_alu;		//o_alu: alu result output
	reg [31:0] o_alu;
	
	always @(i_aluc or i_r or i_s) begin
		case (i_aluc)
			2'b00:begin
				o_alu=i_r+i_s;
				end
			2'b01:begin
				o_alu=i_r-i_s;
				end
			2'b11:begin
				o_alu=i_r&i_s;
				end
			2'b10:begin
				o_alu=~(i_r|i_s);
				end
			default:begin
				o_alu=i_r+i_s;
				end

		endcase
	end
endmodule