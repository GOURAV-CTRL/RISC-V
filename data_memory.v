`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2024 10:19:04 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk,rst,
    input [4:0] wr_addr,
    input [31:0] wr_data,
    input sw,
    input [4:0] rd_addr,
    output [31:0] data_out
    );
    
    reg [7:0] data_mem [31:0];
    integer i;
    
    always@(posedge clk)
        begin
            if(rst)
                begin
                    for(i = 0;i < 32;i = i+ 1)
                        data_mem[i] = i;
                 end
                 
             else
                if(sw)
                    begin
                        data_mem[wr_addr] = wr_data;
                    end
                    
       end
       
       assign data_out = data_mem[rd_addr];
                   
endmodule
