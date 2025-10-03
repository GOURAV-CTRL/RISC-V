`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    TADAKAMALLA GOURAV
// 
// Create Date: 07/18/2024 04:07:13 PM
// Design Name: INSTRUTION FETCH UNIT
// Module Name: instruction_fetch_unit
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module instruction_fetch_unit(
                                input clk,                          //  Clock source
                                input reset,                        //  Reset signal
                                input [31:0] imm_address,           //  Immediate address for branch instructins
                                input [31:0] imm_address_jump,      //  Immediate address for jump instructions
                                input beq,                          //  control signal for enabling beq operation
                                input bneq,                         //  control signal for enabling bneq operation
                                input bge,                          //  control signal for enabling bge operation
                                input blt,                          //  control signal for enabling blt operation
                                input jump,                         //  control signal for enabling jump operation
                                output reg [31:0] pc,               //  programme counter
                                output reg [31:0] current_pc        //  register for storing retrun address of programme counter
    );
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////// LOGIC FOR INCREMENTING PROGRAMME COUNTER /////////////////////////////////////////////   

    always@(posedge clk)
        begin
            if(reset == 1)
                begin
                    pc <= 0;
                end
            else if(beq == 0 && bneq == 0 && bge == 0 && blt == 0 && jump == 0)
                    pc <= pc + 4;
                    
            else if(beq == 1 || bneq == 1 || bge == 1 || blt == 1)
                    pc <= pc + imm_address;
          
            else if(jump)
                    pc <= pc + imm_address_jump;
         end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////  LOGIC FOR STORING RETURN ADDRESS OF PROGRAMME COUNTER  /////////////////////////////////////////////////////
        
         always@(posedge clk)
            begin
            if(reset)
                begin
                    current_pc = 0;
                 end
                 
                else if(reset == 0 && jump == 0)
                    current_pc <= pc + 4;
                else
                    current_pc <= current_pc;
            end
    
endmodule
