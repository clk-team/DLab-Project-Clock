module basic_clk(
    input [5:0]mode,
    input [2:0]light,
    input [15:0]year, 
    input [5:0]month, 
    input [10:0]day, 
    input [10:0]hour, 
    input [10:0]minute, 
    input [10:0]second, 
    input [10:0]week,
    input alarm_mode,
    input temp_hour,
    input temp_minute,
    input temp_second,
    output reg [10:0]num
);


always @(light)
begin
if(mode == 3 && alarm_mode != 0)
begin
     case(light)
        0 : num = temp_hour / 10;
        1 : num = temp_hour - 10 * (temp_hour/10);
        2 : num = temp_minute / 10;
        3 : num = temp_minute - 10 * (temp_minute / 10);
        4 : num = temp_second / 10;
        5 : num = temp_second - 10 * (temp_second / 10);
        6 : num = 11;
        7 : num = 11;
    endcase
end

if(mode == 1 || (mode == 3 && alarm_mode == 0))
  begin 
      case(light)
        0 : num = hour / 10;
        1 : num = hour - 10 * (hour/10);
        2 : num = minute / 10;
        3 : num = minute - 10 * (minute / 10);
        4 : num = second / 10;
        5 : num = second - 10 * (second / 10);
        6 : num = 11;
        7 : num = 11;
    endcase
   end
 end
 
endmodule