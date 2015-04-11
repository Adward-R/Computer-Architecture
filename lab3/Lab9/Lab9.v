`timescale 1ns / 1ps
`include "macro.vh"
module MicroCtrl(clk,rst,OP,out);
   input clk;
   input rst;
   output reg [5:0] OP;
   output reg [17:0] out;
   reg [3:0] 	     PC,mpc;
   wire [17:0] 	     mpe,ctrl;

   initial begin
      PC=0;
      OP=0;
      mpc=0;
   end

   ctrlmem mem(clk,mpc,ctrl);

   MicroMux mux(clk,OP,mpc,ctrl[1],ctrl[0],mpe);

   always @ (posedge clk) begin
      if (ctrl[1]==0 && ctrl[0]==0)
	case (PC)
	  0: OP=`INSTR_RTYPE;
	  1: OP=`INSTR_LW;
	  2: OP=`INSTR_SW;
	  3: OP=`INSTR_BEQ;
	  4: OP=`INSTR_JUMP;
	  default: OP=0;
	endcase // case (PC)
   end // always @ (posedge clk)

   always @ (negedge clk) begin
      if (ctrl[1]==0 && ctrl[0]==0)
	PC=PC+1;
      mpc=mpe;
      out=ctrl;
   end

endmodule // MicroCtrl

module ctrlmem(clk,mpc,out);
   input clk;
   input [3:0] mpc;
   output reg [17:0] out;

   always @ (posedge clk) begin
      case (mpc)
	0: out<=18'b000010000101000111;	//Fetch
	1: out<=18'b000110000000000001;	//Decode
	2: out<=18'b001100000000000010;	//Mem
	3: out<=18'b000000001100000011;	//LW
	4: out<=18'b000000110000000000;	//...
	5: out<=18'b000000001010000000;	//SW
	6: out<=18'b101000000000000011;	//Rtype
	7: out<=18'b000001010000000000;	//...
	8: out<=18'b011000000000011000;	//Beq
	9: out<=18'b000000000000100100;	//Jump
	default: out<=18'b000010000101000111;	//Fetch
      endcase
   end // always @ (posedge clk)
endmodule // ctrlmem

module MicroMux(clk,op,mpc,next1,next0,out);
   input clk;
   input [5:0] op;
   input [3:0] mpc;
   input next1,next0;
   output reg [3:0] out;	//0..9

   always @(posedge clk) begin
      if (next1==0) begin
	 if (next0==0) out<=0;
	 else begin
	    case (op)	//Dispatch 1
	     `INSTR_LW: out <= 2;	//LW
	     `INSTR_SW:	out <= 2;	//SW
	     `INSTR_RTYPE: out <= 6;	//Rtype
	     `INSTR_BEQ: out <= 8;	//BEQ
	     `INSTR_JUMP: out <= 9;	//J
	      default: out <= `INSTR_RTYPE;
	    endcase
	 end // else: !if(next0==0)
      end // if (next1==0)
      else begin
	 if (next0==0) begin
	    case (op)	//Dispatch 2
	      `INSTR_LW: out <= 3;	//LW
	      `INSTR_SW: out <= 5;	//SW
	      default: out <= 0;
	   endcase
	 end
	 else out<=mpc+1;
      end // else: !if(next1==0)
   end // always @ (posedge clk)
endmodule // MicroMux