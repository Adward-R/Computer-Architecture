`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:37 03/03/2014 
// Design Name: 
// Module Name:    hex2ascii 
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:30:18 12/03/2013 
// Design Name: 
// Module Name:    hex2ascii 
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
////////////////////////////////////////////////////////////////////////////////////
module hex2ascii( hex, tofont);
input wire [3:0] hex;
output reg [6:0] tofont;

always @*
	case (hex)
		4'b0000: tofont = 7'h30;//0
		4'b0001: tofont = 7'h31;
		4'b0010: tofont = 7'h32;
		4'b0011: tofont = 7'h33;
		4'b0100: tofont = 7'h34;
		4'b0101: tofont = 7'h35;
		4'b0110: tofont = 7'h36;
		4'b0111: tofont = 7'h37;
		4'b1000: tofont = 7'h38;
		4'b1001: tofont = 7'h39;
		4'b1010: tofont = 7'h41;//a
		4'b1011: tofont = 7'h42;
		4'b1100: tofont = 7'h43;
		4'b1101: tofont = 7'h44;
		4'b1110: tofont = 7'h45;
		4'b1111: tofont = 7'h46;
	   default: tofont = 7'h20;//space
	endcase

endmodule
		


