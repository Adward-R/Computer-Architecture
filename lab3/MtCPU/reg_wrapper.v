//////////////////////////////////////////////////////////////////////////////////
// Company:    Zhejiang University
// Author:     Kang Sun 
// 
// Create Date:    06/23/2006 
// Design Name:    register wrapper
// Module Name:    alu_wrap
// Project Name:   cpu_lab
// Target Devices: xilinx spatan-3
// Tool versions: 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module reg_wrapper(// inputs
                   clk,
                   rst,
                   rnum_A,
                   rnum_B,
						 rnum_C,//
                   wnum,
                   alu_data,
                   ld_data,
                   we,
                   ls,
                   // outputs 
                   rdata_A,
                   rdata_B,
						 rdata_C,//
                   data2mem,
                   r6out
                   );
                   
// input ports
input         clk;
input         rst;
input         we;
input [4:0]   rnum_A;
input [4:0]   rnum_B;
input [4:0]   rnum_C;
input [4:0]   wnum;
input [31:0]  alu_data;
input [31:0]  ld_data;
input         ls;

output [31:0] rdata_A;
output [31:0] rdata_B;
output [31:0] rdata_C;
output [31:0] data2mem;
output [6:0]  r6out;

// wires and regs for all signals
wire          clk;
wire          rst;
wire          we;
wire [4:0]    rnum_A;
wire [4:0]    rnum_B;
wire [4:0]    rnum_C;
wire [4:0]    wnum;
wire [31:0]   alu_data;
wire [31:0]   ld_data;
wire [31:0]   data2mem;
wire [31:0]   wdata;
wire [6:0]    r6out;

assign wdata = ls?ld_data:alu_data;
assign data2mem = rdata_B;

regs   x_regs(.clk(clk),
              .rst(rst),
              .rnum_A(rnum_A),
              .rnum_B(rnum_B),
				  .rnum_C(rnum_C),//
              .wnum(wnum),
              .wdata(wdata),
              .we(we),
              .rdata_A(rdata_A),
              .rdata_B(rdata_B),
				  .rdata_C(rdata_C),
              .r6out(r6out));
              
endmodule