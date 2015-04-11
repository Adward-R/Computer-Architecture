//////////////////////////////////////////////////////////////////////////////////
// Company:    Zhejiang University
// Author:     Kang Sun 
// 
// Create Date:    06/23/2006 
// Design Name:    alu wrapper
// Module Name:    alu_wrap
// Project Name:   cpu_lab
// Target Devices: xilinx spatan-3
// Tool versions: 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module alu_wrapper(// inputs
                rin_A,
                rin_B,  
                off,
                ls,
                alu_ctl,
                // outputs
                res
                );
                
// input signals
input [31:0]   rin_A;
input [31:0]   rin_B;
input [15:0]   off;
input [1:0]    alu_ctl;
//input          al;
input          ls;

// output signals
output [31:0]  res;

// wires and regs for all ports
wire [31:0]    rin_A;
wire [31:0]    rin_B;
wire [15:0]    off;
wire           ls;
wire [1:0]     alu_ctl;
wire [31:0]    res;

wire [31:0]    in_B;

assign in_B = ls?{16'h0000, off}:rin_B;

alu   x_alu(.in_A(rin_A),
            .in_B(in_B),
            .alu_ctl(alu_ctl),
            .res(res));
            
endmodule                            