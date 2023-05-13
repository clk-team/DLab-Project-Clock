`timescale 1ns/1ps
module words (sc, clk,reset, sel, tmp1, clk_o);

input clk_o;
input reset;
input clk;
input sel;
output reg [3:0]sc;
wire [31:0]string;
reg [3:0] se [0:7];
reg  [3:0]counter;
wire clk2;
input [79:0]tmp1;

reg pwm = 0;

wire [4:0]count_8;

frequency_dividerslow div(clk, clk2);
selectstring sele(string, clk, tmp1, count, mode, count_8);
always @(posedge clk)begin

 se[7] <= (count_8 == 7) ? ((pwm <= 50) ? string[31:28] : 4'ha): string[31:28];   
 se[6] <= (count_8 == 6) ? ((pwm <= 50) ? string[27:24] : 4'ha): string[27:24];
 se[5] <= (count_8 == 5) ? ((pwm <= 50) ? string[23:20] : 4'ha): string[23:20];
 se[4] <= (count_8 == 4) ? ((pwm <= 50) ? string[19:16] : 4'ha): string[19:16];
 se[3] <= (count_8 == 3) ? ((pwm <= 50) ? string[15:12] : 4'ha): string[15:12];
 se[2] <= (count_8 == 2) ? ((pwm <= 50) ? string[11:8] : 4'ha): string[11:8];
 se[1] <= (count_8 == 1) ? ((pwm <= 50) ? string[7:4] : 4'ha): string[7:4];
 se[0] <= (count_8 == 0) ? ((pwm <= 50) ? string[3:0] : 4'ha): string[3:0];   
end

always @(posedge clk2) begin
    if(pwm >=100)
        pwm <= 0;
    else
        pwm <= pwm + 1;
end                                                                                      

always @(posedge clk) begin
    if(counter >= 7)
        counter = 0;
   else
   counter <= counter+1;

end

always @(counter) begin

   sc <= se[counter]; 

end
    
endmodule