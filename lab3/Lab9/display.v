`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
//
// Company:
// Engineer:
//
// Create Date: 23:36:25 08/06/2006
// Design Name:
// Module Name: SEGMENT
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
////////////////////////////////////////////////////////////////////////////////
//
module Display(clk_50mhz, count_out, disp_code, blinking, AN_SEL, SEGMENT);
	parameter COUNTER=26;
	input clk_50mhz;
	input disp_code;
	input [3:0] blinking;
	input[COUNTER-1:0] count_out;
	output [3:0] AN_SEL;
	output [7:0] SEGMENT;
	reg [3:0] digit_anode;
	reg [7:0] SEGMENT;
	reg [4:0] code;
	reg [7:0] twinkle=0;
	wire clk_50mhz;
	wire [19:0] disp_code;
	wire [3:0] AN_SEL,blinking;
	always @(posedge clk_50mhz) begin
	case (count_out[18:17])
	2'b00 : begin
		digit_anode <= 4'b1110; //1st element
		code <= disp_code[4:0];
	end
	2'b01 : begin
		digit_anode <= 4'b1101; //2nd element
		code <= disp_code[9:5];
	end
	2'b10 : begin
		digit_anode <= 4'b1011; // 3rd element
		code <= disp_code[14:10];
	end
	default : begin
		digit_anode <= 4'b0111; // 4th element
		code <= disp_code[19:15];
	end
	endcase
	case (code)
		5'b00000 : SEGMENT <= 8'b11000000; // 0
		5'b00001 : SEGMENT <= 8'b11111001; // 1
		5'b00010 : SEGMENT <= 8'b10100100; // 2
		5'b00011 : SEGMENT <= 8'b10110000; // 3
		5'b00100 : SEGMENT <= 8'b10011001; // 4
		5'b00101 : SEGMENT <= 8'b10010010; // 5
		5'b00110 : SEGMENT <= 8'b10000010; // 6
		5'b00111 : SEGMENT <= 8'b11111000; // 7
		5'b01000 : SEGMENT <= 8'b10000000; // 8
		5'b01001 : SEGMENT <= 8'b10010000; // 9
		5'b01010 : SEGMENT <= 8'b10001000; // A
		5'b01011 : SEGMENT <= 8'b10000011; // b
		5'b01100 : SEGMENT <= 8'b11000110; // C
		5'b01101 : SEGMENT <= 8'b10100001; // d
		5'b01110 : SEGMENT <= 8'b10000110; // E
		5'b01111 : SEGMENT <= 8'b10001110; // F
		5'b10000 : SEGMENT <= 8'b01000000; // 0
		5'b10001 : SEGMENT <= 8'b01111001; // 1
		5'b10010 : SEGMENT <= 8'b00100100; // 2
		5'b10011 : SEGMENT <= 8'b00110000; // 3
		5'b10100 : SEGMENT <= 8'b00011001; // 4
		5'b10101 : SEGMENT <= 8'b00010010; // 5
		5'b10110 : SEGMENT <= 8'b00000010; // 6
		5'b10111 : SEGMENT <= 8'b01111000; // 7
		5'b11000 : SEGMENT <= 8'b00000000; // 8
		5'b11001 : SEGMENT <= 8'b00010000; // 9
		5'b11010 : SEGMENT <= 8'b00001000; // A
		5'b11011 : SEGMENT <= 8'b00000011; // b
		5'b11100 : SEGMENT <= 8'b01000110; // C
		5'b11101 : SEGMENT <= 8'b00100001; // d
		5'b11110 : SEGMENT <= 8'b00000110; // E
		5'b11111 : SEGMENT <= 8'b00001110; // F
		default : SEGMENT <= 8'b11111111;
	endcase
	end
	assign AN_SEL = digit_anode|(blinking&{count_out[24],count_out[24],count_out[24],count_out[24]}
); //ÉÁË¸ÏÔÊ¾
endmodule
