`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: TADAKAMALLA GOURAV
// 
// Create Date: 07/15/2024 10:23:37 AM
// Design Name: 
// Module Name: data_path
// Project Name: 
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
//////////////////////////////////////////////////////////////////////////////////


module data_path(
    input clk,
    input rst,
    input [4:0] read_reg_num1,
    input [4:0] read_reg_num2,
    input [4:0] write_reg_num1,
    input [5:0] alu_control,
    input jump,beq_control,zero_flag,reg_dst,mem_to_reg,bne_control,
    input [31:0] imm_val,
    input [3:0] shamt,
    input lb,
    input sw,
    input bgeq_control,
    input blt_control,
    input lui_control,
    input [31:0] imm_val_lui,
    input [31:0] imm_val_jump,
    input [31:0] return_address,
    output [4:0] read_data_addr_dm,
    output  beq,bneq,bge,blt
    );
    
    reg [31:0] pc_current;
    reg [31:0] pc_next,pc_2;
    wire [31:0] instr;
    wire [31:0] ext_imm;
    wire [31:0] read_reg_data_2;
    wire [31:0] read_reg_data_1;
    wire [31:0] reg_write_dest;
    
    wire [31:0] reg_read_data_2;// wire for getting data from register file
    
    wire [31:0] pc_j,pc_beq,pc_bneq;
    
    
    wire bneq_control;
    
    wire [31:0] pc_2beq;
    
    wire [31:0] pc_2bneq;
    
    wire [31:0] read_data1;
    
    wire [31:0] read_data2;
    
    wire [4:0] read_data_addr_dm_2;
    
    wire [31:0] write_data_alu;
    
    wire [31:0] write_data_dm;
    
    wire [4:0] rd_addr;
    
    wire [31:0] data_out;
    
    wire [31:0]  data_out_2_dm;
    
    
    
    
    

    register_file rfu (clk,rst,read_reg_num1,read_reg_num2,write_reg_num1,data_out,lb,lui_control,imm_val_lui,return_address,jump,read_data1,read_data2,read_data_addr_dm_2,data_out_2_dm,sw);
    
    alu alu_unit(read_data1,read_data2,alu_control,imm_val,shamt,write_data_alu);
    
    data_memory dmu(clk,rst,imm_val[4:0],data_out_2_dm,sw,imm_val[4:0],data_out);
   
    initial
        begin
        pc_current <= 32'd0;
        end
        
     always@(posedge clk)
        begin
            pc_current <= pc_next;
         end
         
     assign pc2 = pc_current + 4;
     
     assign jump_shift = {instr[11:0],1'b0};
     
     assign reg_read_addr_1 = instr[13:10];
     assign reg_read_addr_2 = instr[9 :6];
     
     assign read_data_addr_dm = read_data_addr_dm_2;
     
//    always@(posedge clk)
//        begin
//            if(rst)
//             begin
//                beq <= 0;
//                bneq <= 0;
//             end
             
//            else if(write_data_alu && beq_control)
//                begin
//                    beq <= 1;
//                end
//             else if(write_data_alu && bneq_control)
//                begin
//                    bneq <= 1;
//                 end
//        end
        
    

     
     assign beq = (write_data_alu == 1 && beq_control == 1) ? 1 : 0;
     
     assign bneq = (write_data_alu == 1 && bne_control == 1) ? 1 : 0;
     
     assign bge = (write_data_alu == 1 && bgeq_control == 1) ? 1 : 0 ;
     
     assign blt = (write_data_alu == 1 && blt_control == 1) ? 1 : 0;
     
     

     
     assign ext_imm = {{10{instr[31]}},instr[31:21]};
     
     
     assign pc_beq = pc2 + {ext_imm[31:21],1'b0};
     
     assign pc_bneq = pc2 + {ext_imm[31:21],1'b0};
     
     
     
     
     
     assign reg_write_dest = (reg_dst == 1'b1) ? instr[24 : 20] : instr[19 : 15];
     
     
     
         
endmodule
