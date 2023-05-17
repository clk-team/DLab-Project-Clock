`timescale 1ns/1ps
module words (sc, clk,  TEMP_t, TEMP_u);


input clk;
input [3:0] TEMP_t, TEMP_u;

output reg [3:0]sc;

reg [3:0] se [0:7];
reg  [3:0]counter = 0;


always @(posedge clk)begin

 se[7] <= 4'ha;    
 se[6] <= 4'ha;
 se[5] <= 4'ha;
 se[4] <= 4'ha;
 se[3] <= TEMP_t;
 se[2] <= TEMP_u;
 se[1] <=  4'he;
 se[0] <=  4'hc;
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