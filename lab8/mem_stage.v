`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:40 03/20/2012 
// Design Name: 
// Module Name:    mem_stage 
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
module mem_stage(clk, ex_destR, ex_inB, ex_aluR, ex_wreg, ex_m2reg, ex_wmem, mem_wreg, mem_m2reg, mem_mdata, mem_aluR, mem_destR, EXE_ins_type, EXE_ins_number, MEM_ins_type, MEM_ins_number);
  
	input clk;
	input[4:0] ex_destR;
	input[31:0] ex_inB;
	input[31:0] ex_aluR;
	input ex_wreg;
	input ex_m2reg;
	input ex_wmem;
	
	input [3:0] EXE_ins_type;
	input [3:0]	EXE_ins_number;
	output[3:0] MEM_ins_type;
	output[3:0] MEM_ins_number;
	
	output mem_wreg;
	output mem_m2reg;
	output [31:0] mem_mdata;
	output [31:0] mem_aluR;
	output [4:0]  mem_destR;

	wire mwmem;
	wire [31:0] data_in;
	wire [31:0] tomem;
	reg wb_wreg,wb_m2reg;
	always@(posedge clk)
	begin
		wb_wreg <= mem_wreg;
		wb_m2reg <=mem_m2reg;
	end
	assign tomem = (wb_wreg&&wb_m2reg&&mwmem)?mem_mdata:data_in;
	Reg_EXE_MEM x_Reg_EXE_MEM(clk, ex_wreg, ex_m2reg, ex_wmem, ex_aluR, ex_inB, ex_destR, //inputs
							mem_wreg, mem_m2reg, mwmem, mem_aluR, data_in, mem_destR, 
							EXE_ins_type, EXE_ins_number, MEM_ins_type, MEM_ins_number);
	dmem x_data_mem(.addra(mem_aluR[7:0]), .clka(~clk), .dina(tomem), .douta(mem_mdata), .wea(mwmem));
endmodule
