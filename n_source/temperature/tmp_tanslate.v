`timescale 1ns/1ps

module tmp_translate (clk ,TEMP_O, TEMP_t, TEMP_u, led);

input clk;
input [12:0]TEMP_O;

output reg[3:0]TEMP_t, TEMP_u;
output [2:0]led;
reg [8:0]temp;

reg [7:0]R;
reg [7:0]G;
reg [7:0]B;

reg [23:0] nowcolor;

reg [11:0]pwm = 0;

parameter RGB_10 =  24'h180DF3,
          RGB_15 =  24'h15D7EB,
          RGB_20 =  24'h22DE6E,         
          RGB_25 =  24'h43C739,
          RGB_30 =  24'hF2C10E,
          RGB_38 =  24'hE4471C,
          RGB_40 =  24'hFF0000;


always @(posedge clk) begin
    temp = TEMP_O / 16;
    TEMP_t <= temp /10;
    TEMP_u <= temp % 10;
    
    if(temp >= 0 && temp <= 10)
        nowcolor <= RGB_10;
    else if(temp >= 11 && temp <= 15)
        nowcolor <= RGB_15;
    else if (temp >= 16 && temp <= 20)
        nowcolor <= RGB_20;
    else if(temp >= 21 && temp <= 25)
        nowcolor <= RGB_25;
    else if(temp >= 26 && temp <= 30)
        nowcolor <= RGB_30;
    else if(temp >= 31 && temp <= 38)
        nowcolor <= RGB_38;
    else if(temp > 38)
        nowcolor <= RGB_40;

    R <= (nowcolor >> 16) & 8'hFF;
    G <= (nowcolor >> 8) & 8'hFF;
    B <= nowcolor & 8'hFF;

end

always @(posedge clk) begin
    if(pwm >= 510)
        pwm <= 0;
    else
        pwm <= pwm + 1;
end

    assign led[2] = (pwm < R) ? 1 : 0;
    assign led[1] = (pwm < G) ? 1 : 0;
    assign led[0] = (pwm < B) ? 1 : 0;

endmodule