`timescale 1ns / 1ps


module BCD_Encoder_c(
     bcd,
     seg
    );
     
     //Declare inputs,outputs and internal variables.
     input [3:0] bcd;
     output [7:0] seg;
     reg [7:0] seg;

//always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : seg = 8'b00000011;
            1 : seg = 8'b10011111;
            2 : seg = 8'b00100101;
            3 : seg = 8'b00001101;
            4 : seg = 8'b10011001;
            5 : seg = 8'b01001001;
            6 : seg = 8'b01000001;
            7 : seg = 8'b00011111;
            8 : seg = 8'b00000001;
            9 : seg = 8'b00001001;
           11 : seg = 8'b11111101;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 8'b11111111; 
        endcase
    end
    
endmodule
