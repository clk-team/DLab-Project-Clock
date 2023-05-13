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

frequency_dividerslow div(clk, clk2);
selectstring sele(string, clk2, reset, sel, tmp1, clk_o);
always @(posedge clk)begin

 se[7] <= string[31:28];   
 se[6] <= string[27:24];
 se[5] <= string[23:20];
 se[4] <= string[19:16];
 se[3] <= string[15:12];
 se[2] <= string[11:8];
 se[1] <= string[7:4];
 se[0] <= string[3:0];   
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