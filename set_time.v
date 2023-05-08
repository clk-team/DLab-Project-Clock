`timescale 1ns/1ps

module set_time (clk, button_mid, year, month, day, hour, minute, sec);

input clk;
input button_mid;

output [15:0]year;
output [7:0]month;
output [7:0]day;
output [7:0]hour;
output [7:0]minute;
output [7:0]sec;

reg [3:0] count = 0;
reg [31:0] timer;
reg [31:0] wait_c = 0;
reg start_set = 0;

always @(posedge clk) begin

    if(button_mid == 1)
        timer <= timer + 1;
        else begin
            timer <= 0;
            wait_c <= 0;
        end
            

    if(timer >= 2500000)begin
        
        wait_c <= wait_c + 1;    
    
    end
end

always @(posedge clk) begin
    
    if(wait_c == 50000000*2)
        start_set <= ~start_set;
    
end

always @(posedge start_set) begin
    
end

endmodule //set_time