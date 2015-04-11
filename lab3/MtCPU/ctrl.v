//////////////////////////////////////////////////////////////////////////////////
// Company:    Zhejiang University
// Author:     Kang Sun 
// 
// Create Date:    06/19/2006 
// Design Name:    control logics
// Module Name:    ctrl 
// Project Name:   cpu_lab
// Target Devices: xilinx spatan-3
// Tool versions: 
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module ctrl(//inputs
            clk,
            rst,
            mem_data,
           // alu_res,
            //outputs
            mem_reg,
            alu_ctl,
            insn_fth,
            wregnum,
            rreg_A,
            rreg_B,
            wreg,
            wmem,
           // al,
            ls,
            off,
            pc,
            jmp,
            state_out,
            insn_type,
            insn_code
            );
parameter IF = 4'b0000, ID = 4'b0001, EX_R = 4'b0010, 
          EX_LD = 4'b0011, EX_ST = 4'b0100, MEM_RD = 4'b0101, 
          MEM_ST = 4'b0111, WB_R = 4'b1000, WB_LS = 4'b1001;
parameter ADD = 2'b00, SUB = 2'b01, AND = 2'b11, NOR = 2'b10;

parameter LED_IF = 8'b1111_1001, LED_ID = 8'b1010_0100, LED_EX = 8'b1011_0000,
          LED_MEM = 8'b1001_1001, LED_WB = 8'b1001_0010;

parameter LED_R = 8'b1111_1001, LED_J = 8'b1010_0100, LED_I = 8'b1011_0000, LED_N = 8'b1100_0000;

parameter LED_LD = 8'b1111_1001, LED_ST = 8'b1010_0100, LED_AD = 8'b1011_0000,
          LED_SU = 8'b1001_1001, LED_AN = 8'b1001_0010, LED_NO = 8'b1000_0010,
          LED_JP = 8'b1111_1000, LED_NI = 8'b1100_0000;
 
// input signals
input        clk;
input        rst;
input [31:0] mem_data;  // input memory data
//input [31:0] alu_res;   // alu results
// output signals

//output [31:0] insn_reg;  
output [1:0]  alu_ctl;  // alu control signal
output        insn_fth; // instruction fetch signal
output [4:0]  wregnum;     // write register number
output [4:0]  rreg_A;   // read register number A
output [4:0]  rreg_B;   // read register number B
//output        al;      // alu indication signal
output        ls;       // load/store indication signal
output [15:0] off;      // load/store offset
output [10:0] pc;       // prgram counter 
output [31:0] mem_reg;  // memory read data
output        wmem;
output        wreg;
output        jmp;
output [7:0]  state_out;
output [7:0]  insn_type;
output [7:0]  insn_code;

// wire signals for all ports

// reg singals for all ports
reg [31:0] insn_reg;
reg [1:0]  alu_ctl;
reg        insn_fth;
reg [4:0]  wregnum;
reg [4:0]  rreg_A;
reg [4:0]  rreg_B;
//reg        al;
reg        ls;
reg [15:0] off;
reg [10:0] pc;
reg [31:0] mem_reg;
reg        wmem;
reg        wreg;
reg        jmp;

reg [7:0]  state_out;
reg [7:0]  insn_type;
reg [7:0]  insn_code;


// module signals
reg [4:0]  state;  // status of state machine
reg [10:0] npc;
//reg [31:0] alu_reg; // register store alu results

//assign alu_out = alu_res;


always @ (insn_reg or rst or npc)
   if (rst == 1)
   begin
      pc = 0;
      jmp = 1'b0;
   end
   else if(insn_reg[31:26] == 6'b000010)
        begin
           pc = insn_reg[10:0];
           jmp = 1'b1;
        end
        else
        begin
   	       pc = npc;
   	       jmp = 1'b0;
        end
   	  
always @ (posedge clk or posedge rst)
   if (rst == 1)
   begin
      state <= IF;
      insn_fth <= 1'b1;
      wreg  <= 1'b0;
      wmem  <= 1'b0;
   end
   else 
   	  case (state)
         IF: 
         begin
            insn_reg <= mem_data;
            insn_fth <= 1'b0;
            npc <= pc + 1;
            state <= ID;
         end
         ID:
         begin
            case (insn_reg[31:26])
               6'b000000: // R type insn
               begin
                  case(insn_reg[5:0])
                     6'b100000: alu_ctl <= ADD;
                     6'b100010: alu_ctl <= SUB;
                     6'b100100: alu_ctl <= AND;
                     6'b100111: alu_ctl <= NOR;
                     default:   alu_ctl <= ADD;
                  endcase
                  rreg_A <= insn_reg[25:21];
                  rreg_B <= insn_reg[20:16];
                  wregnum <= insn_reg[15:11];
                  wreg <= 1'b0;
                  state <= EX_R;
               end
               6'b000010:    // Jump insn
               begin
                  insn_fth <= 1'b1;
                  state <= IF;
               end
               6'b100011:   //Load
               begin
                  alu_ctl <= ADD;
                  rreg_A  <= insn_reg[26:21];
                  wregnum <= insn_reg[20:16];
                  off <= insn_reg[15:0];
                  ls <= 1'b1;
                  state <= EX_LD;
               end
               6'b101011:   // Store
               begin
                  alu_ctl <= ADD;
                  rreg_A <= insn_reg[26:21];
                  rreg_B <= insn_reg[20:16];
                  off <= insn_reg[15:0];
                  ls <= 1'b1;
                  wmem <= 1'b1;
                  state <= EX_ST;
               end
               default: state <= EX_R;
            endcase
         end
         EX_R:          // Excution of R-type
         begin
            wreg <= 1'b1;
            insn_fth <= 1'b1;
            state <= WB_R;
         end
         WB_R:
         begin
            wreg <= 1'b0;
            state <= IF;
         end
         EX_LD: state <= MEM_RD;
         MEM_RD:
         begin
            mem_reg <= mem_data;
            wreg <= 1'b1;
            insn_fth <= 1'b1;
            state <= WB_LS;
         end
         WB_LS:
         begin
            wreg <= 1'b0;
            ls <= 1'b0;
            state <= IF;
         end
         EX_ST:
         begin
            insn_fth <= 1'b1;
            state <= MEM_ST;
         end
         MEM_ST:
         begin
            wmem <= 1'b0;
            ls <= 1'b0;
            state <= IF; 
         end
         default: state <= IF;
      endcase
      
always @ (state)
   case(state)
      IF: state_out <= LED_IF;
      ID: state_out <= LED_ID;
      EX_R,  
      EX_LD, 
      EX_ST: state_out <= LED_EX;
      MEM_RD, 
      MEM_ST: state_out <= LED_MEM;
      WB_R, 
      WB_LS: state_out <= LED_WB;
      default: state_out <= LED_IF;
   endcase 
   
always @ (insn_reg)
   case (insn_reg[31:26])
      6'b000000: // R type insn
      begin
         case(insn_reg[5:0])
         6'b100000: insn_code <= LED_AD;
         6'b100010: insn_code <= LED_SU;
         6'b100100: insn_code <= LED_AN;
         6'b100111: insn_code <= LED_NO;
         default:   insn_code <= LED_AD;
         endcase
         insn_type <= LED_R;
      end
      6'b000010:    // Jump insn
      begin
         insn_code <= LED_JP;
         insn_type <= LED_J;
      end
      6'b100011:   //Load
      begin
         insn_code <= LED_LD;
         insn_type <= LED_I;
      end
      6'b101011:   // Store
      begin
         insn_code <= LED_ST;
         insn_type <= LED_I;
      end
      default: 
      begin
         insn_type <= LED_N;
         insn_code <= LED_NI;
      end
   endcase
                   
endmodule     
                