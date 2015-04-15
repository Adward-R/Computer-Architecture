`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:30:27 03/30/2014 
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
module reg_wrapper(clk, rst, ir_data, dr_data, c_data, memtoreg, regdst, write_reg,
						rdata_A, rdata_B, r6out);
	input         	clk;
	input				rst;
	input	[31:0]  	ir_data;
	input	[31:0]  	dr_data;
	input [31:0]	c_data;
	input				memtoreg;
	input				regdst;
	input				write_reg;
	output [31:0]	rdata_A;
	output [31:0]	rdata_B;
	output [7:0]	r6out;
	
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
					  .wnum(nd),
					  .wdata(ni),
					  .we(write_reg),
					  .rdata_A(rdata_A),
					  .rdata_B(rdata_B),
					  .r6out(r6out));

endmodule

//regs module
module regs(clk, rst, rnum_A, rnum_B, wnum, wdata, we, rdata_A, rdata_B, r6out);
    input        clk;
	input        rst;
	input [4:0]  rnum_A;
	input [4:0]  rnum_B;
	input [4:0]  wnum;
	input [31:0] wdata;
	input        we;
	output [31:0] rdata_A;
	output [31:0] rdata_B;
   output [7:0] r6out;
	wire         clk;
	wire         rst;
	wire [4:0]   rnum_A;
	wire [4:0]   rnum_B;
	wire [4:0]   wnum;
	wire [31:0]  wdata;
	wire         we;
   wire [7:0]   r6out;
	reg [31:0]   rdata_A;
	reg [31:0]   rdata_B;

	reg [31:0]   r0;
	reg [31:0]   r1;
	reg [31:0]   r2;
	reg [31:0]   r3;
	reg [31:0]   r4;
	reg [31:0]   r5;
	reg [31:0]   r6;
	reg [31:0]   r7;
	reg [31:0]   r8;
	reg [31:0]   r9;
	reg [31:0]   r10;
	reg [31:0]   r11;
	reg [31:0]   r12;
	reg [31:0]   r13;
	reg [31:0]   r14;
	reg [31:0]   r15;
   assign  r6out=r6[7:0];
	always @ (posedge clk or posedge rst)
	begin
 		if (rst == 1)
		begin
			r0 <= 0;
			r1 <= 0;
			r2 <= 0;
			r3 <= 0;
			r4 <= 0;
			r5 <= 0;
			r6 <= 0;
			r7 <= 0;
			r8 <= 0;
			r9 <= 0;
			r10 <= 0;
			r11 <= 0;
			r12 <= 0;
			r13 <= 0;
			r14 <= 0;
			r15 <= 0;
		end
		else if (we == 1)
		begin
			case (wnum)
				5'b00000: r0 <= 0;
				5'b00001: r1 <= wdata;
				5'b00010: r2 <= wdata;
				5'b00011: r3 <= wdata;
				5'b00100: r4 <= wdata;
				5'b00101: r5 <= wdata;
				5'b00110: r6 <= wdata;
				5'b00111: r7 <= wdata;
				5'b01000: r8 <= wdata;
				5'b01001: r9 <= wdata;
				5'b01010: r10 <= wdata;
				5'b01011: r11 <= wdata;
				5'b01100: r12 <= wdata;
				5'b01101: r13 <= wdata;
				5'b01110: r14 <= wdata;
				5'b01111: r15 <= wdata;
		      default:  r0 <= 0;
			endcase
	  end
	  else 
	  begin
		 case(rnum_A)
			 5'b00000: rdata_A <= r0;
			 5'b00001: rdata_A <= r1;
			 5'b00010: rdata_A <= r2;
			 5'b00011: rdata_A <= r3;
			 5'b00100: rdata_A <= r4;
			 5'b00101: rdata_A <= r5;
			 5'b00110: rdata_A <= r6;
			 5'b00111: rdata_A <= r7;
			 5'b01000: rdata_A <= r8;
			 5'b01001: rdata_A <= r9;
			 5'b01010: rdata_A <= r10;
			 5'b01011: rdata_A <= r11;
			 5'b01100: rdata_A <= r12;
			 5'b01101: rdata_A <= r13;
			 5'b01110: rdata_A <= r14;
			 5'b01111: rdata_A <= r15;
			 default:  rdata_A <= r0;
		 endcase 
         	 
		 case(rnum_B)
		    5'b00000: rdata_B <= r0;
			 5'b00001: rdata_B <= r1;
			 5'b00010: rdata_B <= r2;
			 5'b00011: rdata_B <= r3;
			 5'b00100: rdata_B <= r4;
			 5'b00101: rdata_B <= r5;
			 5'b00110: rdata_B <= r6;
			 5'b00111: rdata_B <= r7;
			 5'b01000: rdata_B <= r8;
			 5'b01001: rdata_B <= r9;
			 5'b01010: rdata_B <= r10;
			 5'b01011: rdata_B <= r11;
			 5'b01100: rdata_B <= r12;
			 5'b01101: rdata_B <= r13;
			 5'b01110: rdata_B <= r14;
			 5'b01111: rdata_B <= r15;
			 default:  rdata_B <= r0;
		 endcase
	  end
	end
endmodule
