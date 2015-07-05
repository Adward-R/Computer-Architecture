`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:09:26 03/18/2014 
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
module top(input wire CCLK, BTN3_IN, BTN2_IN, input wire [3:0]SW,output wire LCDE, LCDRS, LCDRW, output wire [3:0]LCDDAT,output wire [7:0] LED
 );

	wire [31:0] if_npc;
	wire [31:0] if_pc4;
	wire [31:0] if_inst;
	wire clk0;
	
	wire [31:0] id_pc4;	
	wire [31:0] id_inA;
	wire [31:0] id_inB;
	wire [31:0] id_imm;
	wire [4:0] id_destR;
	wire [4:0] id_regrt;
	wire [4:0] id_rt;
	wire [4:0] id_rd;
	reg id_wpcir;//exam 3's work
	wire id_branch; 
	wire id_wreg;
	wire id_m2reg;
	wire id_wmem;
	wire [3:0] id_aluc;
	wire id_shift;
	wire id_aluimm;
	
	wire ex_wreg;
	wire ex_m2reg;
	wire ex_wmem;
	wire[31:0] ex_aluR;
	wire[31:0] ex_inB;
	wire[4:0] ex_destR;
	wire ex_branch,ex_zero;
	wire[31:0]ex_pc;
	
	wire mem_wreg;
	wire mem_m2reg;
	wire[31:0] mem_mdata;
	wire[31:0] mem_aluR;
	wire[4:0] mem_destR;
	wire mem_branch;
	wire[31:0] mem_pc;
	
	wire wb_wreg;
	wire[4:0] wb_destR;
	wire[31:0] wb_dest;
	
	wire [3:0] IF_ins_type; 
	wire [3:0] IF_ins_number;
	wire [3:0] ID_ins_type;
	wire [3:0] ID_ins_number;
	wire [3:0] EX_ins_type; 
	wire [3:0] EX_ins_number;
	wire [3:0] MEM_ins_type; 
	wire [3:0] MEM_ins_number;
	wire [3:0] WB_ins_type; 
	wire [3:0] WB_ins_number;
	wire [3:0] OUT_ins_type; 
	wire [3:0] OUT_ins_number;
	
	wire [31:0] pc;
	wire [31:0] reg_content;
	wire [3:0] which_reg;
	
	
	reg [255:0] strdata;
	reg [3:0] SW_old;
	reg [7:0] clk_cnt;
	reg cls;

	wire [3:0] lcdd;
	wire rslcd, rwlcd, elcd;
	wire clk_1ms; 
	wire [1:0]id_FWA,id_FWB;

   wire [4:0] if_rs;
   wire branch;
    wire stall;
	
	wire [31:0]mem_dest;
	always @* id_wpcir=stall;
	
	assign LCDDAT[3]=lcdd[3];
	assign LCDDAT[2]=lcdd[2];
	assign LCDDAT[1]=lcdd[1];
	assign LCDDAT[0]=lcdd[0];
	
	assign LCDRS=rslcd;
	assign LCDRW=rwlcd;
	assign LCDE=elcd;


  assign LED[1:0]=id_FWA;
   assign LED[3:2]=id_FWB;
   //assign LED[5]=id_wpcir;	
   assign LED[7:4]=ex_aluR[3:0];
	//assign LED[7:4]=0;
	//assign LED=BTN3;
	assign which_reg[3:0] = SW[3:0];
   clock C1 (CCLK, 25000, clk0);
	pbdebounce M1(clk0, BTN2_IN, BTN2);
	pbdebounce M2(clk0, BTN3_IN, BTN3);


   
	initial begin
		strdata <= "01234567 00 0123f01d01e01m01w01 ";
		SW_old = 4'b0;
		clk_cnt <= 8'b0;
		cls <= 1'b0;
		//if_npc[31:0]=0;
	end
	
	display M0 (CCLK, cls, strdata, rslcd, rwlcd, elcd, lcdd);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

	always @(posedge CCLK) begin
		if ((BTN3 == 1'b1) || (BTN2 == 1'b1)) begin
			//first line 8 4-bit Instrution
			strdata[255:248] <= 8'h30 + if_inst[31:28];
			strdata[247:240] <= 8'h30 + if_inst[27:24];
			strdata[239:232] <= 8'h30 + if_inst[23:20];
			strdata[231:224] <= 8'h30 + if_inst[19:16];
			strdata[223:216] <= 8'h30 + if_inst[15:12];
			strdata[215:208] <= 8'h30 + if_inst[11:8];
			strdata[207:200] <= 8'h30 + if_inst[7:4];
			strdata[199:192] <= 8'h30 + if_inst[3:0];
			//space
			strdata[191:184] <= " ";
			//2 4-bit CLK
			strdata[183:176] <= 8'h30 + clk_cnt[7:4];
			strdata[175:168] <= 8'h30 + clk_cnt[3:0];
			//space
			strdata[167:160] <= " ";

			//second line
			strdata[127:120] <= 8'h30+15;
			strdata[119:112] <= 8'h30 + IF_ins_number;
			strdata[111:104] <= 8'h30 + IF_ins_type;
			strdata[103:96] <= 8'h30+13;
			strdata[95:88] <= 8'h30 + ID_ins_number;
			strdata[87:80] <= 8'h30 + ID_ins_type;
			strdata[79:72] <= 8'h30+14;
			strdata[71:64] <= 8'h30 + EX_ins_number;
			strdata[63:56] <= 8'h30 + EX_ins_type;
			strdata[55:48] <= 8'h30+22;
			strdata[47:40] <= 8'h30 + MEM_ins_number;
			strdata[39:32] <= 8'h30 + MEM_ins_type;
			strdata[31:24] <= 8'h30+32;
			strdata[23:16] <= 8'h30 + WB_ins_number;
			strdata[15:8] <= 8'h30 + WB_ins_type;
			
		end
		if((BTN3 == 1'b1) || (BTN2 == 1'b1)||(SW_old != SW)) begin
			//first line after CLK and space
			strdata[159:152] <= 8'h30 + reg_content[15:12];
			strdata[151:144] <= 8'h30 + reg_content[11:8];
			strdata[143:136] <= 8'h30 + reg_content[7:4];
			strdata[135:128] <= 8'h30 + reg_content[3:0];
			SW_old <= SW;
			cls <= 1;
		end
		else
			cls <= 0;
	end
	
	always @(posedge BTN3) begin
		clk_cnt <= clk_cnt + 1;
	end

	assign rst = BTN2;
	
	assign pc [31:0] = if_npc[31:0];
	if_stage x_if_stage(CCLK, BTN3, rst, pc, id_pc4, branch, id_wpcir,
		if_npc, if_pc4, if_inst, IF_ins_type, IF_ins_number,ID_ins_type,ID_ins_number);

	id_stage x_id_stage(BTN3, rst, if_inst, if_npc, wb_destR, wb_dest,wb_wreg, 
		id_wreg, id_m2reg, id_wmem, id_aluc, id_shift, id_aluimm, id_branch, id_pc4, id_inA, id_inB, id_imm, id_regrt,id_rt,id_rd,id_wpcir, 
		ID_ins_type, ID_ins_number, EX_ins_type, EX_ins_number, {1'b0,which_reg}, reg_content,id_FWA,id_FWB,if_rs,stall,mem_dest,ex_aluR,id_destR,branch);
		
	ex_stage x_ex_stage(BTN3, rst, id_imm, id_inA, id_inB, id_wreg, id_m2reg, id_wmem, id_aluc, id_aluimm,id_shift, id_branch, id_pc4,id_regrt,id_rt,id_rd,
		ex_wreg, ex_m2reg, ex_wmem, ex_aluR, ex_inB, ex_destR, ex_branch, ex_pc, ex_zero, 
		EX_ins_type, EX_ins_number, MEM_ins_type, MEM_ins_number,id_FWA,id_FWB,mem_aluR,wb_dest,id_destR);
	  
	mem_stage x_mem_stage(BTN3, rst, ex_destR, ex_inB, ex_aluR, ex_wreg, ex_m2reg, ex_wmem, ex_branch,ex_pc,ex_zero,  
		mem_wreg, mem_m2reg, mem_mdata, mem_aluR, mem_destR, mem_branch, mem_pc,
		MEM_ins_type, MEM_ins_number, WB_ins_type, WB_ins_number,mem_dest);

	wb_stage x_wb_stage(BTN3, rst, mem_destR, mem_aluR, mem_mdata, mem_wreg, mem_m2reg, 
		wb_wreg, wb_dest, wb_destR, WB_ins_type, WB_ins_number,OUT_ins_type, OUT_ins_number);
		
endmodule
