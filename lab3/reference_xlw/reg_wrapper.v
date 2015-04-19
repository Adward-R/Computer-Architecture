`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:53 04/12/2015 
// Design Name: 
// Module Name:    reg_wrapper 
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
module reg_wrapper(clk, rst, ir_data, dr_data, SW, c_data, memtoreg, regdst, write_reg,
						rdata_A, rdata_B, r6out, sout);
	input         	clk;
	input				rst;
	input	[31:0]  	ir_data;
	input	[31:0]  	dr_data;
	input [3:0]    SW;
	input [31:0]	c_data;
	input				memtoreg;
	input				regdst;
	input				write_reg;
	output [31:0]	rdata_A;
	output [31:0]	rdata_B;
	output [6:0]	r6out;
	output [31:0]	sout;
	
	wire [4:0]		rs;
	wire [4:0]		rt;
	wire [4:0]		rd;
	wire [4:0]		nd;
	wire [31:0]	ni;
	
	assign rs = ir_data[25:21];
	assign rt = ir_data[20:16];
	assign rd = ir_data[15:11];
	assign nd = regdst? rd : rt;
	assign ni = memtoreg? dr_data : c_data;
	
	regs  x_regs( .clk(clk),
					  .rst(rst),
					  .rnum_A(rs),
					  .rnum_B(rt),
					  .SW(SW),
					  .wnum(nd),
					  .wdata(ni),
					  .we(write_reg),
					  .rdata_A(rdata_A),
					  .rdata_B(rdata_B),
					  .r6out(r6out),
					  .sout(sout));

endmodule

