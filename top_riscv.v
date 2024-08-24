`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    TADAKAMALLA GOURAV 
// 
// Create Date: 07/18/2024 04:05:01 PM
// Design Name: TOP 
// Module Name: top_riscv
// Project Name: RISC - V 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module top_riscv(
                    input clk,
                    input reset
    );
    
    wire [31:0] imm_val_top;        //extracted immediate value (sign extended)
    wire [31:0] pc;                 //programme counter
    wire [31:0] instruction_out;    //output of instruction memory
    wire  [5:0] alu_control;        // control signal for determining the type of the alu operation
    wire  mem_to_reg;               // control signal for enabling memory to register file operation           
    wire  bneq_control;             // control signal for enabling bneq instruction                  
    wire  beq_control;              // control signal for branch equal to instruction     
    wire  jump;                     // control signal for enabling jump instruction
    wire [31:0] read_data_addr_dm;  // address for reading the data from data memory
    wire [31:0] imm_val;            // extracted immediate value from the instruction (sign extended)
    wire lb;                        // signal for enabling load operation
    wire sw;                        // signal for enabling store opeation
    wire [31:0] imm_val_branch_top; // extracted immediate value for branch instruction (sign extended)
    wire beq,bneq;                  // control signals for performiing branch equal to and not equal to operations
    wire bgeq_control;              // control signals for enabling branch greater than or equal to instruction
    wire blt_control;               // control signal for enabling branch less than instruction
    wire bge;                       // control signal for enabling branch greater than instruciton       
    wire blt;                       // control signal for enabling branch less than instruction
    wire lui_control;               // control signal for enabling load upper immediate operation
    wire [31:0] imm_val_lui;        // extracted immediate value for load upper immediate instruction (sign extended)
    wire [31:0] imm_val_jump;       // extracted immediate value for jump instruction (sign extended)
    wire [31:0] current_pc;         // register for storing return programme counter
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                // INSTRUCTION FETCH UNIT // 
    
    // This unit will fetch the instructions which are stored in the instruction memory unit by providing the programme counter to instruction memory
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    instruction_fetch_unit ifu(clk,
                               reset,
                               imm_val_branch_top,
                               imm_val_jump,
                               beq,
                               bneq,
                               bge,
                               blt,
                               jump,
                               pc,
                               current_pc);

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                       // Instruction memory unit //
                                                        
    // this module is used as a rom all the instructions are stroed inside this unit
  
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
    instruction_memory imu(clk,
                           pc,
                           reset,
                           instruction_out);
                           
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                            // Control unit //
   
    // Control unit is like the brain of the processor which controls all the operations required in this processor
   
   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
    control_unit cu(reset,
                    instruction_out[31:25],
                    instruction_out[14:12],
                    instruction_out[6:0],
                    alu_control,
                    lb,
                    mem_to_reg,
                    bneq_control,
                    beq_control,
                    bgeq_control,
                    blt_control,
                    jump,
                    sw,
                    lui_control);
   
 
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                        // Data path unit //
                                                        
    // This unit is used to route the data between different modules in the design
                                                        
   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                    
        data_path dpu(clk,reset,
                  instruction_out[19:15],
                  instruction_out[24 : 20],
                  instruction_out[11 : 7],
                  alu_control,
                  jump,
                  beq_control,
                  zero_flag,
                  reg_dst,
                  mem_to_reg,
                  bneq_control,
                  imm_val_top,
                  instruction_out[24:20],
                  lb,
                  sw,
                  bgeq_control,
                  blt_control,
                  lui_control,
                  imm_val_lui,
                  imm_val_jump,
                  current_pc,
                  read_data_addr_dm,
                  beq,
                  bneq,
                  bge,
                  blt
                  
                  );
                  
    assign imm_val_top = {{20{instruction_out[31]}},instruction_out[31:21]};
    assign imm_val_branch_top = {{20{instruction_out[31]}},instruction_out[30:25],instruction_out[11:8],instruction_out[7]};
    assign imm_val_lui = {{10{instruction_out[31]}},instruction_out[31:12]};
    assign imm_val_jump = {{10{instruction_out[31]}},instruction_out[31:12]};
    assign imm_val = imm_val_top;
    
    
    
    endmodule
