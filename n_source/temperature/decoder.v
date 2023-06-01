`timescale 1ns/1ps

module decoder (
    output reg[7:0]q,
    input [3:0]bcd
);

always @(bcd) begin

    case (bcd)
        0: q = 8'b00000011; 
        1: q = 8'b10011111;
        2: q = 8'b00100101;
        3: q = 8'b00001101;
        4: q = 8'b10011001;
        5: q = 8'b01001001;
        6: q = 8'b01000001;
        7: q = 8'b00011111;
        8: q = 8'b00000001;
        9: q = 8'b00001001;
        10: q = 8'b11111111;
        11: q = 8'b11111101;
        12: q = 8'b01100011;
        13: q = 8'b10000101;
        14: q = 8'b00111001;
        15: q = 8'b01110001;
        default: q = 8'b11111111;
    endcase
    
end
    
endmodule