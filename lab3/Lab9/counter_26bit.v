`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
//
// Company:
// Engineer:
//
// Create Date: 22:54:49 08/06/2006
// Design Name:
// Module Name: counter_20bit
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
module counter_26bit(clk_50mhz, reset, count_out);
	parameter COUNTER=26;
	input wire clk_50mhz;
	input reset;
	//output clk_1ms;
	output [COUNTER-1:0] count_out;
	reg [COUNTER-1:0] count;
	//reg second_m;
	wire [COUNTER-1:0] count_out;
	initial
	count<=0;
	always@(posedge clk_50mhz)begin
	if(!reset || (count[15:0]==49999))begin
		count[15:0]<=0;
		count[25:16]<=count[25:16]+1;
		//second_m<=1;
	end
	else begin
		count[15:0] <= count+1;
		//second_m<=0;
	end
	end
	//assign clk_1ms=second_m;
	assign count_out=count;
endmodule