`timescale 1ns / 1ps

module top(input wire CCLK, BTN3_IN, BTN2_IN,BTN4_IN, BTN1_IN, input wire [3:0]SW, output wire  LCDE, LCDRS, LCDRW, output wire [3:0]LCDDAT,output wire[5:0]LED);

	wire BTN3;
	wire BTN2;
	wire rst;
	wire id_wpcir;
	reg [31:0] if_inst_old;
	reg [31:0] reg_content_old;
	
	wire [31:0] if_npc;
	wire [31:0] if_pc4;
	wire [31:0] if_inst;
	
	wire [31:0] id_pc4;	
	wire [31:0] id_inA;
	wire [31:0] id_inB;
	wire [31:0] id_imm;
	wire [4:0] id_destR;
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
	
	wire mem_wreg;
	wire mem_m2reg;
	wire[31:0] mem_mdata;
	wire[31:0] mem_aluR;
	wire[4:0] mem_destR;
	
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
	wire [31:0]ppc;
	wire [31:0] reg_content;
	wire [4:0] which_reg;
	
	wire [255:0] strdata;
	reg [3:0] SW_old;
	reg [7:0] clk_cnt;
	reg cls;
	reg sel_reg;

	wire [3:0] lcdd;
	wire rslcd, rwlcd, elcd;
	wire clk_1ms;

	assign LCDDAT[3] = lcdd[3];
	assign LCDDAT[2] = lcdd[2];
	assign LCDDAT[1] = lcdd[1];
	assign LCDDAT[0] = lcdd[0];
	
	assign LCDRS = rslcd;
	assign LCDRW = rwlcd;
	assign LCDE = elcd;

	initial begin
		SW_old = 4'b0;
		clk_cnt <= 8'b0;
		cls <= 1'b0;
	end
	
//显示模块的辅助模块，把数值转化为相应的ASCII码，便于显示
hex2ascii h1( if_inst[3:0], strdata[7:0]);
hex2ascii h2( if_inst[7:4], strdata[15:8]);
hex2ascii h3( if_inst[11:8], strdata[23:16]);
hex2ascii h4( if_inst[15:12], strdata[31:24]);
hex2ascii h5( if_inst[19:16], strdata[39:32]);
hex2ascii h6( if_inst[23:20], strdata[47:40]);
hex2ascii h7( if_inst[27:24], strdata[55:48]);
hex2ascii h8( if_inst[31:28], strdata[63:56]);
hex2ascii h9( reg_content[3:0],   strdata[71:64]);
hex2ascii h10( reg_content[7:4],   strdata[79:72]);
hex2ascii h11( reg_content[11:8],  strdata[87:80]);
hex2ascii h12( reg_content[15:12], strdata[95:88]);
hex2ascii h13( reg_content[19:16], strdata[103:96]);
hex2ascii h14( reg_content[23:20], strdata[111:104]);
hex2ascii h15( reg_content[27:24], strdata[119:112]);
hex2ascii h16( reg_content[31:28], strdata[127:120]);
hex2ascii h18(ID_ins_type,strdata[247:240]);
hex2ascii h19(EX_ins_type,strdata[231:224]);
hex2ascii h20(MEM_ins_type,strdata[215:208]);
hex2ascii h21(WB_ins_type,strdata[199:192]);
hex2ascii h22(OUT_ins_type,strdata[183:176]);
hex2ascii h23(ppc[7:4],strdata[167:160]);
hex2ascii h24(ppc[3:0],strdata[159:152]);
//按键去抖模块
clock C1 (CCLK, 25000, clk0);	
pbdebounce M1(clk0, BTN1_IN, BTN1);	
pbdebounce M2(clk0, BTN2_IN, rst);  //复位
pbdebounce M3(clk0, BTN3_IN, BTN3); //手动时钟
pbdebounce M4(clk0, BTN4_IN, BTN4); //寄存器选择

//显示模块
display x_display(CCLK, rst,strdata,rslcd, rwlcd, elcd,lcdd);

//查看寄存器时的选择
always@(posedge BTN4)begin
	sel_reg = ~sel_reg;
end
assign which_reg ={sel_reg,SW};
//分配led灯
//assign LED[6] = rst;
assign LED[5] = id_aluimm;
assign LED[4:0] = which_reg;
//初始化lcd显示屏
assign strdata[255:248] = "f";
assign strdata[239:232] = "d";
assign strdata[223:216] = "e";
assign strdata[207:200] = "m";
assign strdata[191:184] = "w";
assign strdata[175:168] = " ";
assign strdata[151:128] = "   ";
	
	
	
	
		
	always @(posedge BTN3) begin
		clk_cnt <= clk_cnt + 1;
	end

	assign pc[31:0] = if_npc[31:0];
	
	if_stage x_if_stage(CCLK,BTN3, rst, pc, id_pc4, id_branch, id_wpcir, 
			if_npc, if_pc4, if_inst, IF_ins_type, IF_ins_number,ID_ins_type,ID_ins_number,ppc);

	id_stage x_id_stage(BTN3, rst, if_inst, if_pc4, wb_destR, wb_dest, wb_wreg, 
			id_wreg, id_m2reg, id_wmem, id_aluc, id_shift, id_aluimm, id_branch, id_pc4, id_inA, id_inB, id_imm, id_destR, 
			id_wpcir, ID_ins_type, ID_ins_number, EX_ins_type, EX_ins_number, which_reg, reg_content, mem_aluR, mem_mdata, ex_aluR);
		
	ex_stage x_ex_stage(BTN3, id_imm, id_inA, id_inB, id_wreg, id_m2reg, id_wmem, id_aluc, id_aluimm, id_shift, id_destR, 
			ex_wreg, ex_m2reg, ex_wmem, ex_aluR, ex_inB, ex_destR,  
			EX_ins_type, EX_ins_number, MEM_ins_type, MEM_ins_number);	
   mem_stage xt_mem_stage(BTN3, ex_destR, ex_inB, ex_aluR, ex_wreg, ex_m2reg, ex_wmem, 
			mem_wreg, mem_m2reg, mem_mdata, mem_aluR, mem_destR, 
			MEM_ins_type, MEM_ins_number, WB_ins_type, WB_ins_number);
	wb_stage x_wb_stage(BTN3, mem_destR, mem_aluR, mem_mdata, mem_wreg, mem_m2reg, 
			wb_wreg, wb_dest, wb_destR, WB_ins_type, WB_ins_number,OUT_ins_type, OUT_ins_number);
endmodule
