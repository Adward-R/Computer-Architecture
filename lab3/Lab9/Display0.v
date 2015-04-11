`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:58 03/12/2014 
// Design Name: 
// Module Name:    Display0 
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
module Display0(clk_50mhz, count_out, disp_code0, blinking0, AN_SEL0, SEGMENT0);
	parameter COUNTER=26;
	input wire clk_50mhz;
	input wire [31:0] disp_code0;
	input wire [7:0] blinking0;
	input wire [COUNTER-1:0] count_out;
	output wire [7:0] AN_SEL0;
	output reg [7:0] SEGMENT0;
	reg [7:0] digit_anode;
	reg [3:0] code;
	
	always @(posedge clk_50mhz) begin
	case (count_out[18:16])
	3'b000 : begin
		digit_anode <= 4'b11111110;
		code <= disp_code0[3:0];
	end
	3'b001 : begin
		digit_anode <= 4'b11111101;
		code <= disp_code0[7:4];
	end
	3'b010 : begin
		digit_anode <= 4'b11111011;
		code <= disp_code0[11:8];
	end
	3'b011 : begin
		digit_anode <= 4'b11110111;
		code <= disp_code0[15:12];
	end
	3'b100 : begin
		digit_anode <= 4'b11101111;
		code <= disp_code0[19:16];
	end
	3'b101 : begin
		digit_anode <= 4'b11011111;
		code <= disp_code0[23:20];
	end
	3'b110 : begin
		digit_anode <= 4'b10111111;
		code <= disp_code0[27:24];
	end
	default: begin
		digit_anode <= 4'b01111111;
		code <= disp_code0[31:28];
	end
	endcase
	case (code)
		4'b0000 : SEGMENT0 <= 8'b11000000; // 0
		4'b0001 : SEGMENT0 <= 8'b11111001; // 1
		4'b0010 : SEGMENT0 <= 8'b10100100; // 2
		4'b0011 : SEGMENT0 <= 8'b10110000; // 3
		4'b0100 : SEGMENT0 <= 8'b10011001; // 4
		4'b0101 : SEGMENT0 <= 8'b10010010; // 5
		4'b0110 : SEGMENT0 <= 8'b10000010; // 6
		4'b0111 : SEGMENT0 <= 8'b11111000; // 7
		4'b1000 : SEGMENT0 <= 8'b10000000; // 8
		4'b1001 : SEGMENT0 <= 8'b10010000; // 9
		4'b1010 : SEGMENT0 <= 8'b10001000; // A
		4'b1011 : SEGMENT0 <= 8'b10000011; // b
		4'b1100 : SEGMENT0 <= 8'b11000110; // C
		4'b1101 : SEGMENT0 <= 8'b10100001; // d
		4'b1110 : SEGMENT0 <= 8'b10000110; // E
		4'b1111 : SEGMENT0 <= 8'b10001110; // F
		default : SEGMENT0 <= 8'b11111111;
	endcase
	end
	assign AN_SEL0 = digit_anode|(blinking0&{8{count_out[24]}});
endmodule
