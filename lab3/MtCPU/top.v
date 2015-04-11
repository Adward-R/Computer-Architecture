//////////////////////////////////////////////////////////////////////////////////
// Company:    Zhejiang University
// Author:     Kang Sun 
// 
// Create Date:    06/19/2006 
// Design Name:    top module
// Module Name:    top 
// Project Name:   cpu_lab
// Target Devices: xilinx spatan-3
// Tool versions: 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module top(// inputs
           oclk,
           rst,
           uclk,
           dbg,
			  SW,
           // outputs
           LED_O,
           LED_SEL,
           LED_DAT,
           indi
          );
			 
parameter LED_IF = 8'b1111_1001, LED_ID = 8'b1010_0100, LED_EX = 8'b1011_0000,
          LED_MEM = 8'b1001_1001, LED_WB = 8'b1001_0010;
          
input         oclk;
input         uclk;
input         rst;
input         dbg;
input [6:0] SW; //

output [7:0]  LED_O;
output [3:0]  LED_SEL;
output        indi;
output [6:0]  LED_DAT;

wire          clk;
wire          rst;         

wire [10:0]   raddr;
wire [10:0]   waddr;
wire [31:0]   mem_data;
wire          wmem;
wire [31:0]		alu_out;
wire [1:0]		alu_ctl;
wire				ls_i;
//wire			alu_i;
wire [15:0]   offset;
wire [4:0]    rreg_nA;
wire [4:0]    rreg_nB;
wire [4:0]    rreg_nC;
wire [31:0]   rdata_A;
wire [31:0]   rdata_B;
wire [31:0]   rdata_C;
wire [31:0]   ld_data;
wire [10:0]   pc;
wire          insn_fth;
wire [31:0]   data2mem;
wire          wreg;
wire [4:0]    wregn;
wire          jmp;
wire          dbg;

wire          indi;
wire [7:0]    state_out;
wire [7:0]    insn_type;
wire [7:0]    insn_code;

reg  [7:0]    LED_O;
reg  [3:0]    LED_SEL;
reg  [3:0]    led_state;
reg           lclk;
reg  [15:0]   counter;
wire  [63:0]   led_code; //

assign raddr = (insn_fth || jmp)?pc:alu_out[10:0];
assign waddr = alu_out[10:0];
assign clk   = dbg?uclk:oclk;
assign rreg_nC=SW[4:0];

assign indi = uclk;
assign LED_DAT[6]=oclk;
assign LED_DAT[5]=rst;

reg [4:0] rhythm;
always @ (posedge clk)begin
	case (state_out)
		LED_IF: rhythm=5'b00001;
		LED_ID: rhythm=5'b00010;
		LED_EX: rhythm=5'b00100;
		LED_MEM: rhythm=5'b01000;
		LED_WB: rhythm=5'b10000;
		default: rhythm=5'b11111;
	endcase
end
assign LED_DAT[4:0]=rhythm[4:0];

always @ (posedge oclk)
   if (rst == 1)
   begin
      counter <= 16'h0000;
      lclk <= 1'b0;
   end     
   else   
   begin
      if (counter == 16'hffff)
      begin
         counter <= 16'h0000;
         lclk <= ~lclk;
      end
      else counter <= counter + 1;      
   end   

////



///
led_decoder x1_led_decoder(lclk,rdata_C[31:28],led_code[63:56]);
led_decoder x2_led_decoder(lclk,rdata_C[27:24],led_code[55:48]);
led_decoder x3_led_decoder(lclk,rdata_C[23:20],led_code[47:40]);
led_decoder x4_led_decoder(lclk,rdata_C[19:16],led_code[39:32]);
led_decoder x5_led_decoder(lclk,rdata_C[15:12],led_code[31:24]);
led_decoder x6_led_decoder(lclk,rdata_C[11:8],led_code[23:16]);
led_decoder x7_led_decoder(lclk,rdata_C[7:4],led_code[15:8]);
led_decoder x8_led_decoder(lclk,rdata_C[3:0],led_code[7:0]);

always @ (posedge lclk or posedge rst)
   if (rst == 1)
   begin
      LED_O <= 8'b1100_0000;
      LED_SEL <= 4'b0000;
      led_state <= 4'b0001;
   end
   else   
      case (led_state)
         4'b0001: 
         begin
				if (SW[6]==1)
					LED_O <= clk;//state_out;
				else begin
					if (SW[5]==1)
						LED_O <= led_code[63:56];
					else
						LED_O <= led_code[55:48];
				end
            LED_SEL <= 4'b0111;
            led_state <= 4'b0010;
         end
         4'b0010:
         begin
				if (SW[6]==1)
					LED_O <= insn_type;//state_out;
				else begin
					if (SW[5]==1)
						LED_O <= led_code[47:40];
					else
						LED_O <= led_code[39:32];
				end
            LED_SEL <= 4'b1011;
            led_state <= 4'b0100;
         end
         4'b0100:
         begin
				if (SW[6]==1)
					LED_O <= state_out;//insn_code;
				else begin
					if (SW[5]==1)
						LED_O <= led_code[31:24];
					else
						LED_O <= led_code[23:16];
				end
            LED_SEL <= 4'b1101;
            led_state <= 4'b1000;
         end
			4'b1000:
         begin
				if (SW[6]==1)
					LED_O <= pc;//insn_code;
				else begin
					if (SW[5]==1)
						LED_O <= led_code[15:8];
					else
						LED_O <= led_code[7:0];
				end
            LED_SEL <= 4'b1110;
            led_state <= 4'b0001;
         end
         default:
         begin
            LED_O <= 8'b1100_0000;
            LED_SEL <= 4'b0000;
            led_state <= 3'b001;
         end
      endcase      
 
 
/*
memory x_memory(
	        .addra(raddr),
	        .addrb(waddr),
	        .clka(clk),
	        .clkb(clk),
	        .dinb(data2mem),
	        .douta(mem_data),
	        .web(wmem));   
*/
x_memory mainram(
	.addr(raddr[7:0]),
	.clk(clk),
	.din(data2mem),
	.dout(mem_data),
	.we(wmem)
	);

ctrl   x_ctrl(
	        .clk(clk),
          .rst(rst),
          .mem_data(mem_data),
          .mem_reg(ld_data),
          .alu_ctl(alu_ctl),
          .insn_fth(insn_fth),
          .wregnum(wregn),
          .rreg_A(rreg_nA),
          .rreg_B(rreg_nB),
          .wreg(wreg),
          .wmem(wmem),
          .ls(ls_i),
          .off(offset),
          .pc(pc),
          .jmp(jmp),
          .state_out(state_out),
          .insn_type(insn_type),
          .insn_code(insn_code));  
            
alu_wrapper   x_alu_wrapper(
                 .rin_A(rdata_A),
                 .rin_B(rdata_B),  
                 .off(offset),
                 .ls(ls_i),
                 .alu_ctl(alu_ctl),
                 .res(alu_out));
              
wire [6:0] LED_DATX;              
reg_wrapper   x_reg_wrapper(
                 .clk(clk),
                 .rst(rst),
                 .rnum_A(rreg_nA),
                 .rnum_B(rreg_nB),
					  .rnum_C(rreg_nC),//
                 .wnum(wregn),
                 .alu_data(alu_out),
                 .ld_data(ld_data),
                 .we(wreg),
                 .ls(ls_i), 
                 .rdata_A(rdata_A),
                 .rdata_B(rdata_B),
					  .rdata_C(rdata_C),//
                 .data2mem(data2mem),
                 .r6out(LED_DATX)); 
                 
endmodule                              
            