`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:42 05/18/2014 
// Design Name: 
// Module Name:    Top 
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
module Top(disp_clk,BTN,LED,SEGMENT,AN_SEL);
	parameter COUNTER=26;
	input disp_clk;
	input [3:0] BTN;
	output [7:0] LED; 
	output [7:0] SEGMENT;
	output [3:0] AN_SEL;
	wire rst,clk;
	wire [COUNTER-1:0] count_out;
	wire [5:0] OP;
	wire [17:0] out;
	wire [19:0] disp_code;
	wire [3:0] push_out;
	
	counter_26bit x_counter_26bit(disp_clk, rst, count_out);
	anti_jitter x_anti_jitter(disp_clk,count_out,BTN,push_out);
	Display x_Display(disp_clk, count_out, disp_code, 4'b0000, AN_SEL, SEGMENT);
	MicroCtrl x_MicroCtrl(clk,rst,OP,out);
	
	assign LED[7:6]=out[1:0];//indicates micro-instruction-selection signal
	assign LED[5:0]=OP[5:0];
	
	assign disp_code[19:0]={1'b0,out[17:14],1'b0,out[13:10],1'b0,out[9:6],1'b0,out[5:2]};
	assign rst=push_out[3];
	assign clk=push_out[0];
endmodule
