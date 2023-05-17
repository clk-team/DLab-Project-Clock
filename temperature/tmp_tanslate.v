`timescale 1ns/1ps

module tmp_translate (clk ,TEMP_O, TEMP_t, TEMP_u);

input clk;
input [12:0]TEMP_O;

output reg[3:0]TEMP_t, TEMP_u;
reg [8:0]temp;

always @(posedge clk) begin
    temp = TEMP_O / 16;
    TEMP_t <= temp /10;
    TEMP_u <= temp % 10;
end
    
endmodule