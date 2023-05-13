`timescale 1ns/1ps
module words (sc, clk, tmp1, mode, count, clk_o);


input clk;
input [3:0]mode;
input [83:0]tmp1;
input [4:0]count;
input clk_o;

output reg [3:0]sc;

wire [31:0]string;
reg [3:0] se [0:7];
reg  [3:0]counter = 0;



reg [7:0]pwm = 0;

wire [4:0]count_8;
wire clk_sec;

freq_div fr(clk_o, clk_sec, 1);
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

always @(posedge clk_sec) begin
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