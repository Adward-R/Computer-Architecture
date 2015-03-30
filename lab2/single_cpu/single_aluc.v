`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:39 03/16/2014 
// Design Name: 
// Module Name:    single_aluc 
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
module single_aluc(aluop, func, aluc);
    input [1:0] aluop;
    input [5:0] func;
    output [2:0] aluc;
	 reg [2:0] aluc;
	
	 always @(aluop or func) begin
		case (aluop)
			2'b00: begin
				aluc = 3'b010;        //lw | sw
			end
			2'b01: begin
				aluc = 3'b110;			 //beq
			end
			2'b10: begin
				case (func)
				  6'b100000: aluc=3'b010;
					6'b100010: aluc=3'b110;
					6'b100100: aluc=3'b000;
					6'b100101: aluc=3'b001;
					6'b101010: aluc=3'b111;

					default: aluc = 3'b000;
				endcase
			end
			default: begin
			    aluc=3'b000;
			end
		endcase
	end
endmodule

