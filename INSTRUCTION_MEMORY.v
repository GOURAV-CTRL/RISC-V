`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: TADAKAMALLA GOURAV
// 
// Create Date: 07/08/2024 04:59:21 PM
// Design Name: 
// Module Name: INSTRUCTION_MEMORY
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module instruction_memory(
    input clk,
    input [31:0] pc,                    // PROGRAMME COUNTER
    input reset,                        // ACTIVE HIGH RESET
    output [31:0] instruction_code      // 32 BIT INSTRUCITON      
    );
    
    
    reg [7:0] memory [108 :0];          // MEMORY FOR STORING THE INSTRUCTION OF WIDTH 32 BITS AND NUMBER OF LOCATIONS : 109
    
    
    //INSTRUCTION FETCHING FROM THE MEMORY
    
    assign instruction_code = {memory[pc+3],memory[pc+2],memory[pc+1],memory[pc]}; 
    
    
    always@(posedge clk)
        begin
                 if(reset == 1)
                   begin
                       // Setting 32-bit instruction: add : 0x00940333 
                       memory[3] = 8'h00;
                       memory[2] = 8'h94;
                       memory[1] = 8'h03;
                       memory[0] = 8'h33;
                       // Setting 32-bit instruction: sub : 0x800100b3
                       memory[7] = 8'h80;
                       memory[6] = 8'h01;
                       memory[5] = 8'h00;
                       memory[4] = 8'hb3;
                       // Setting 32-bit instruction: sll : 0x00209133
                       memory[11] = 8'h00;
                       memory[10] = 8'h20;
                       memory[9] = 8'h91;
                       memory[8] = 8'h33;
                       // Setting 32-bit instruction: xor : 0x00c54ab3 
                       memory[15] = 8'h00;
                       memory[14] = 8'hc5;
                       memory[13] = 8'h4A;
                       memory[12] = 8'hb3;
                       // Setting 32-bit instruction: srl : 0x00c55ab3
                       memory[19] = 8'h00;
                       memory[18] = 8'hc5;
                       memory[17] = 8'h5a;
                       memory[16] = 8'hb3;
                       // Setting 32-bit instruction: all : 0z01bd5f33
                       memory[23] = 8'h01;
                       memory[22] = 8'hbd;
                       memory[21] = 8'h5f;
                       memory[20] = 8'h33;
                       // Setting 32-bit instruction: or : 0x00d67fb3
                       memory[27] = 8'h00;
                       memory[26] = 8'hd6;
                       memory[25] = 8'h7f;
                       memory[24] = 8'hb3;
                       // Setting 32-bit instruction: and : 0x00f78b3
                       memory[31] = 8'h00;
                       memory[30] = 8'hf7;
                       memory[29] = 8'h68;
                       memory[28] = 8'hb3;
                      
                       // setting 32 - bit instruction : addi : 0x00a08513 
                       memory[35] = 8'h00;
                       memory[34] = 8'ha0;
                       memory[33] = 8'h85;
                       memory[32] = 8'h13;
                       
                       // setting 32 bit instruction : slli : 
                       memory[39] = 8'h00;
                       memory[38] = 8'h41;
                       memory[37] = 8'h93;
                       memory[36] = 8'h13;
                       
                       
                       
                       
                       // setting 32 bit instruction for xor immediate
                       
                       memory[43] = 8'h03;
                       memory[42] = 8'hf2;
                       memory[41] = 8'hc7;
                       memory[40] = 8'h26 ;
                       
                       
                       // setting 32 bit instruction for set less than immediate
                       
                       memory[47] = 8'h00;
                       memory[46] = 8'ha1;
                       memory[45] = 8'h20;
                       memory[44] = 8'h93;
                       
                       //setting 32 bit instruction for shift right logical immediate
                       
                       memory[51] = 8'h00;
                       memory[50] = 8'h31;
                       memory[49] = 8'h50;
                       memory[48] = 8'h93;
                       
                       // setting 32 bit instructino for or immediate
                       memory[55] = 8'h00;
                       memory[54] = 8'hf1;
                       memory[53] = 8'h60;
                       memory[52] = 8'h93;
                       
                       
                       // setting 32 bit instrcution for and immediate
                       memory[59] = 8'h00;
                       memory[58] = 8'hf1;
                       memory[57] = 8'h70;
                       memory[56] = 8'h93;
                       
                       //LOAD INSTRUCTIONS I TYPE 
                       //LOAD WORD
                       memory[63] = 8'h00;
                       memory[62] = 8'h43;
                       memory[61] = 8'h02;
                       memory[60] = 8'h83;
                       
                       // STORE INSTUCTION IN I TYPE
                       // STORE WORD
                       memory[67] = 8'h00;
                       memory[66] = 8'h73;
                       memory[65] = 8'h28;
                       memory[64] = 8'h23;
                       
                       
                       //BRANCH INSTRUCTIONS
                       //BRANCH EQUAL
                        
                       memory[71] = 8'H00;
                       memory[70] = 8'H41;
                       memory[69] = 8'H00;
                       memory[68] = 8'H63;
                       
                       
                       //BRANCH NOT EQUAL
                       
                       memory[75] = 8'h00;
                       memory[74] = 8'h20;
                       memory[73] = 8'h94;
                       memory[72] = 8'h63;
                       
                       //HERE AFTER GIVING BNE INSTRUCTION THE PC VALUE DECIMAL 80
                       
                       //BRANCH GREATER THAN OR EQUAL TO INSTRUCTION
                       memory[83] = 8'h00;
                       memory[82] = 8'h41;
                       memory[81] = 8'ha4;
                       memory[80] = 8'h63;
                       
//                       //BRANCH LESS THAN INSTRUCTION
//                       memory[87] = 8'h00;
//                       memory[86] = 8'h20;
//                       memory[85] = 8'hc1;
//                       memory[84] = 8'h63;
                       
                       
                       //LOAD UPPER IMMEDIATE INSTRUCTION
                       memory[91] = 8'h12;
                       memory[90] = 8'h34;
                       memory[89] = 8'h52;
                       memory[88] = 8'hb7;
                       
                       // JUMP AND LINK INSTRUCTION
                       memory[95] = 8'h00;
                       memory[94] = 8'h00 ;
                       memory[93] = 8'h80;
                       memory[92] = 8'hef;
                       
                       
                       
            end
            end

                
endmodule


