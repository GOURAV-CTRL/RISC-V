`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2024 02:20:44 PM
// Design Name: 
// Module Name: alu
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


module alu(
            input [31 :0 ] src1,
            input [31: 0 ] src2,
            input [5:0] alu_control,
            input [31:0] imm_val_r,
            input [3:0] shamt, // shift amount
            output reg [31:0 ] result

    );
    
    
    always@(*)
        begin
        
        
            case(alu_control)
            
            
                6'b000001 ://addition 
                                begin
                
                                        result = src1 + src2;
                                end
                6'b000010 : //subraction
                
                                        result = src1 - src2;
                6'b000011 : //shift left logical
                
                                        result = src1 << src2;
            
                6'b000100 : // set less than
                        begin
                            
                                        result = (src1 < src2) ? 1 : 0;
                            
                        end
                        
                 6'b000101 : // set less than unsigned
                        begin
                            
                            
                        end
                        
                        
                 6'b000110 : // xor operation
                        begin
                            
                                result = src1 ^ src2;
                        end
                        
                  6'b000111 : //shift right logical
                        begin
                                result = src1 >> src2;
                         end
                   
                   6'b001000 : // shift right arthimetic
                        begin
                                result = src1 >>> src2;
                         end
                         
                    6'b001001 : //or operation
                        begin
                                result = src1 | src2;
                        end
                        
                    6'b001010 : // and operation
                            
                         begin
                                result = (src1) & src2 ;
                          end
                          
              
            

                     6'b001011 :
                                result = src1 + imm_val_r; // add immediate

                     6'b001100 :
               
                                result = imm_val_r << shamt; // shift left logical immediate

                     6'b001101 :
                                result = (imm_val_r < src1) ? 1 : 0;// SET LESS THAN IMMEDIATE
                                        
                     6'b001110:
                                result = src1 & src2;
              
                     6'b001111 :
               
                               result = src1 ^ imm_val_r; // xor immediate
               
              
                    6'b010000 :              
                               result = src1 >> imm_val_r; // shift right logical immediate
              
                    6'b001001 :
          
                              result = (src1 < src2) ? 1 : 0;

              
                    6'b001011 :               //set less than unsigned this should be checked
                              result = src1 + imm_val_r;
               
            
                    6'b001101 :
                                begin
//                               result = src1 | imm_val_r;
                                end
                                
                    6'b001110 :
              
                               result = src1 & imm_val_r;
            
                     6'b001111 :
                               result = src1 >> imm_val_r;
                                       
                                       
                    6'b010000 :
                              result = src1 << imm_val_r;
           
                    6'b010001 :    // OR IMMEDIATE
                
                              result = src1 | imm_val_r;
                                         
                    6'b010010 :
                                
                               result = src1 & imm_val_r;
                               
                               
                    // BRANCH INSTRUCTIONS
                    
                    6'B011011 :
                                result  =  (src1 == src2) ? 1 : 0; // if the two registers consists
                                                                   // of same values then result will be 1
                                                                   //else result will be 0
                                                                   
                    6'b011100 :
                                result = (src1 != src2) ? 1 : 0; // if the two registers consists of 
                                                                 // different values then the result will be 0
                                                                 //else the result will be 1 
                                                                 
                                                                 
                   6'b011111 :
                                result = (src2 >= src1) ? 1 : 0 ; //bgeq;
                                
                   
                   6'b100000 : //branch less than instruction
                                
                                result = (src1 < src2) ? 1 : 0 ; 
                                
                                 
                                
                               
                               
            endcase
           end
 
endmodule
