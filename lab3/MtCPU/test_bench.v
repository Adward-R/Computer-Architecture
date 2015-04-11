//////////////////////////////////////////////////////////////////////////////////
// Company:    Zhejiang University
// Author:     Kang Sun 
// 
// Create Date:    06/19/2006 
// Design Name:    test bentch
// Module Name:    t_bench
// Project Name:   cpu_lab
// Target Devices: xilinx spatan-3
// Tool versions: 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module t_bench;

reg      clk;
reg      rst;
reg      oclk;

wire [7:0] LED;
wire [3:0] SEL;
wire       indi;





always
begin
    clk = 1'b0;
    #10;
    clk = 1'b1;
    #10;
end

always
begin
    oclk = 1'b0;
    #2;
    oclk = 1'b1;
    #2;
end
    
initial
begin
    rst = 1'b1;
    #110;
    rst = 1'b0;
    #2000
    $stop;
end

top   x_top(
         .oclk(oclk),
         .rst(rst),
         .uclk(clk),
         .dbg(1'b1),
         .LED_O(LED),
         .LED_SEL(SEL),
         .indi(indi));
         
endmodule
