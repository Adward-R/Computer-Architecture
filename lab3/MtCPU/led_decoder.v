`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:40:27 06/09/2014 
// Design Name: 
// Module Name:    led_decoder 
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
module led_decoder(lclk,disp_code,led_code);
input lclk;
input [3:0] disp_code;
output reg [7:0] led_code;

always @ (posedge lclk) begin
case (disp_code)
	4'b0000: led_code <= 8'b00000001;
	4'b0001: led_code <= 8'b01001111;
	4'b0010: led_code <= 8'b00010010;
	4'b0011: led_code <= 8'b00000110;
	4'b0100: led_code <= 8'b01001100;
	4'b0101: led_code <= 8'b00100100;
	4'b0110: led_code <= 8'b00100000;
	4'b0111: led_code <= 8'b00001111;
	4'b1000: led_code <= 8'b00000000;
	4'b1001: led_code <= 8'b00000100;
	4'b1010: led_code <= 8'b00001000;
	4'b1011: led_code <= 8'b01100000;
	4'b1100: led_code <= 8'b00110001;
	4'b1101: led_code <= 8'b01000010;
	4'b1110: led_code <= 8'b00110000;
	4'b1111: led_code <= 8'b00111000;
endcase
end

endmodule
