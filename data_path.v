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
    input jump,beq_control,bne_control,
    input [31:0] imm_val,
    input [3:0] shamt,  //havent discussed yet 
    input lb,
    input sw,
    input bgeq_control,
    input blt_control,
    input lui_control,
    input [31:0] imm_val_lui,
    
    output [4:0] read_data_addr_dm,
    output  beq,bneq,bge,blt //these signals are going to ifu
    );
    
    
    
    
    
    
    
    
    wire [31:0] read_data1;
    
    wire [31:0] read_data2;
    
    wire [4:0] read_data_addr_dm_2;
    
    wire [31:0] write_data_alu;
    
    
    
    wire [31:0] data_out;
    
    wire [31:0]  data_out_2_dm;
    
    
    
    
    

    register_file rfu (clk,rst,read_reg_num1,read_reg_num2,write_reg_num1,data_out,lb,lui_control,imm_val_lui,jump,read_data1,read_data2,read_data_addr_dm_2,data_out_2_dm,sw);
    
    alu alu_unit(read_data1,read_data2,alu_control,imm_val,shamt,write_data_alu);
    
    data_memory dmu(clk,rst,imm_val[4:0],data_out_2_dm,sw,imm_val[4:0],data_out);
   
   
     assign read_data_addr_dm = read_data_addr_dm_2;
     

        
    

     
     assign beq = (write_data_alu == 1 && beq_control == 1) ? 1 : 0;
     
     assign bneq = (write_data_alu == 1 && bne_control == 1) ? 1 : 0;
     
     assign bge = (write_data_alu == 1 && bgeq_control == 1) ? 1 : 0 ;
     
     assign blt = (write_data_alu == 1 && blt_control == 1) ? 1 : 0;
     
     

     
     
     
     
     
     
     
     
     
     
     
     
         
endmodule
