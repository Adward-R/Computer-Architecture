`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:13 11/04/2013 
// Design Name: 
// Module Name:    key_switch 
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
module anti_jitter(clk_50mhz,count_out,BTN,push_out);
  parameter COUNTER = 26;
  parameter num = 21;
  input wire clk_50mhz;
  input wire [COUNTER-1:0] count_out;
  input [3:0] BTN;
  output [3:0] push_out;

  reg [7:0] direct;
  reg [3:0] push_out;
  reg key_dir;
  
  assign key_push =| BTN;
  
	always@(posedge clk_50mhz) begin
		if(!key_push)begin
			key_dir <= 0;
			direct[7:4] <= BTN;
		end
		else if(key_push && count_out[num] && count_out[num-1] == 0 && count_out[num-2] == 0)
			key_dir <= 1;
	end
	 
	always@(negedge clk_50mhz) begin
		if(BTN!=4'b0000&&count_out[num]==0&&count_out[num-1]&&count_out[num-2]&&key_dir==1)begin
			push_out<=BTN;
			direct[3:0]<=BTN;
		end
      else if(!key_dir)
         push_out<=0;   
	end

endmodule

/*
module anti_jitter(count_out,BTN,push_out);
	parameter COUNTER=26;
	input wire [COUNTER-1:0] count_out;
	input wire [7:0] BTN;
	output wire [7:0] push_out;
	reg [7:0] pbshift;
	reg pbreg;

	always @(posedge count_out[15])begin
		pbshift=pbshift<<1;
		pbshift[0]=BTN[0];
		if(pbshift==0)
			pbreg=0;
		if(pbshift==8'hFF)
			pbreg=1;
	end
	
	assign push_out=pbreg;
	
endmodule*/