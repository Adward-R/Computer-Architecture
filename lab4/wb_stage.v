module wb_stage(clk,  mem_destR, mem_aluR, mem_mdata, mem_wreg, mem_m2reg, wb_wreg, 
				wb_dest, wb_destR, MEM_ins_type, MEM_ins_number, WB_ins_type, WB_ins_number);
	input clk;
	input[4:0] mem_destR;
	input[31:0] mem_aluR;
	input[31:0] mem_mdata;
	input mem_wreg;
	input mem_m2reg;
	
	input[3:0] MEM_ins_type;
	input[3:0]	MEM_ins_number;
	output[3:0] WB_ins_type;
	output[3:0] WB_ins_number;
	
	output wb_wreg;
	output[4:0] wb_destR;
	output[31:0] wb_dest;

	wire wm2reg;
	wire [31:0] 	wdata_out,waluout;
	
	assign wb_dest=wm2reg?wdata_out:waluout;
	
	Reg_MEM_WB x_Reg_MEM_WB(clk,	mem_wreg,mem_m2reg,mem_mdata,mem_aluR,mem_destR,	//inputs
											wb_wreg,wm2reg,wdata_out,waluout,wb_destR,		 //outputs
											MEM_ins_type, MEM_ins_number, WB_ins_type, WB_ins_number);	
endmodule