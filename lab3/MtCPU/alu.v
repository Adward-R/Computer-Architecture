//////////////////////////////////////////////////////////////////////////////////
// Company:    Zhejiang University
// Author:     Kang Sun 
// 
// Create Date:    06/19/2006 
// Design Name:    arithmetic and logic unit
// Module Name:    alu 
// Project Name:   cpu_lab
// Target Devices: xilinx spatan-3
// Tool versions: 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module alu (//inputs
            in_A,
            in_B,
            alu_ctl,
            //outputs
            res);

// input signals
input [31:0] in_A;
input [31:0] in_B;
input [1:0]  alu_ctl;

// output signals
output [31:0] res;

// wire signals for all ports
wire [31:0] in_A;
wire [31:0] in_B;
wire [1:0]  alu_ctl;
reg [31:0] res;

always @ (alu_ctl or in_A or in_B)
   case (alu_ctl)
      2'b00: res = in_A + in_B;
      2'b01: res = in_A - in_B;
      2'b11: res = in_A & in_B;
      2'b10: res = ~(in_A | in_B);
   endcase

endmodule             