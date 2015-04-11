`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:09 04/11/2015 
// Design Name: 
// Module Name:    alu_wrapper 
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

module alu_wrapper(rin_A, rin_B, ir_data, pc, alu_srcA, alu_srcB, alu_ctrl, zero, res);
				 
	input [31:0] rin_A;
	input [31:0] rin_B;
	input [31:0] ir_data;
	input [31:0] pc;
	input        alu_srcA;
	input [1:0]  alu_srcB;
	input [1:0]	 alu_ctrl;
	output		 zero;
	output[31:0] res;

	wire [31:0]	 rin_A;
	wire [31:0]	 rin_B;
	wire [31:0]	 ir_data;
	wire [31:0]  pc;
	wire 			 alu_srcA;
	wire [1:0]   alu_srcB;
	wire [1:0]	 alu_ctrl;
	wire [31:0]	 res;
	wire [31:0]  in_A;
	wire [31:0]	 in_B;
	wire [31:0]  signimm;
	wire [31:0]  shiftimm;
	wire         zero;
	
	assign signimm = (ir_data[15] == 1'b0) ? {16'h0000, ir_data[15:0]} : {16'hFFFF, ir_data[15:0]};
	assign shiftimm = signimm;
	
	assign in_A = (alu_srcA == 1'b1)? rin_A : pc; 
	//assign in_A = pc; 
	assign in_B = (alu_srcB == 2'b00)? rin_B : ((alu_srcB == 2'b01)? 32'h00000001 : ((alu_srcB == 2'b10)? signimm: shiftimm));
	assign zero = (res == 32'h00000000)? 1 : 0;

	alu x_alu(in_A, in_B, alu_ctrl, res);

endmodule

//single_alu
module alu(i_r,i_s,i_aluc,o_alu);
	input [31:0] i_r;		//i_r: r input
	input [31:0] i_s;		//i_s: s input
	input [2:0] i_aluc;		//i_aluc: ctrl input
	//output o_zf;			//o_zf: zero flag output
	output [31:0] o_alu;		//o_alu: alu result output
	//reg o_zf;
	reg [31:0] o_alu;
	
	always @(i_aluc or i_r or i_s) begin
		case (i_aluc)
			3'b000:begin
		//		o_zf=0;
				o_alu=i_r&i_s;
				end
			3'b001:begin
			//	o_zf=0;
				o_alu=i_r|i_s;
				end
			3'b010:begin
		//		o_zf=0;
				o_alu=i_r+i_s;
				end
			3'b110:begin
				o_alu=i_r-i_s;
			//	o_zf=(o_alu==0);
				end
			3'b111:begin
			//	o_zf=0;
				if(i_r<i_s)
					o_alu=1;
				else
					o_alu=0;
				end
			default:begin
			//	o_zf=0;
				o_alu=0;
				end

		endcase
	end
endmodule

