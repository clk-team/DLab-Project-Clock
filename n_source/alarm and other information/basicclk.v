`timescale 1ns / 1ps

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
    input [2:0]alarm_mode,
    input [10:0]temp_hour,
    input [10:0]temp_minute,
    input [10:0]temp_second,
    output reg [10:0]num,
    output reg dot
);

always @(light)
begin
if(mode == 5 && alarm_mode != 0)
begin
     case(light)
        0 : num = temp_hour / 10;
        1 : num = temp_hour - 10 * (temp_hour/10);
        2 : num = 11;
        3 : num = temp_minute / 10;
        4 : num = temp_minute - 10 * (temp_minute / 10);
        5 : num = 11;
        6 : num = temp_second / 10;
        7 : num = temp_second - 10 * (temp_second / 10);
    endcase
end

if(mode == 1 || (mode == 5 && alarm_mode == 0))
  begin 
      case(light)
        0 : num = hour / 10;
        1 : num = hour - 10 * (hour/10);
        2 : num = 11;
        3 : num = minute / 10;
        4 : num = minute - 10 * (minute / 10);
        5 : num = 11;
        6 : num = second / 10;
        7 : num = second - 10 * (second / 10);
        
    endcase
   end

if(mode == 2)  
begin    //星期、日期
  case(light)
        0 : num = month / 10;
        1 : num = month - 10 * (month/10);
        2 : num = 11;
        3 : num = day / 10;
        4 : num = day - 10 * (day / 10);
        5 : num = 11;
        6 : num = 11;
        7 : num = week;
        
    endcase
end
if(mode != 3)
  dot = 1;
if(mode == 3)
begin

    case(light)
        0 : dot = 1;
        1 : dot = 1;
        2 : dot = 1;
        3 : dot = 0;
        4 : dot = 1;
        5 : dot = 1;
        6 : dot = 1;
        7 : dot = 1; 
    endcase

  if(year >= 2911)
  case(light)
        0 : num = year / 1000;
        1 : num = year / 100 - 10 * (year/1000);
        2 : num = year / 10 - 10 * (year/100);
        3 : num = year - 10 * (year/10);
        4 : num = (year - 1911) / 1000;
        5 : num = (year - 1911) / 100 - 10 * ((year - 1911) / 1000);
        6 : num = (year - 1911) / 10 - 10 * ((year - 1911) / 100) ;
        7 : num = (year - 1911) - 10 * ((year - 1911) / 10);      
    endcase

      else if(year < 2911 && year >= 2011)
  case(light)
        0 : num = year / 1000;
        1 : num = year / 100 - 10 * (year/1000);
        2 : num = year / 10 - 10 * (year/100);
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = (year - 1911) / 100;
        6 : num = (year - 1911) / 10 - 10 * ((year - 1911) / 100) ;
        7 : num = (year - 1911) - 10 * ((year - 1911) / 10);      
    endcase

     else if(year < 2011 && year >= 1921)
  case(light)
        0 : num = year / 1000;
        1 : num = year / 100 - 10 * (year/1000);
        2 : num = year / 10 - 10 * (year/100);
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = 12;
        6 : num = (year - 1911) / 10 - 10 * ((year - 1911) / 100) ;
        7 : num = (year - 1911) - 10 * ((year - 1911) / 10);      
    endcase

      else if(year < 1921 && year > 1911)
  case(light)
        0 : num = year / 1000;
        1 : num = year / 100 - 10 * (year/1000);
        2 : num = year / 10 - 10 * (year/100);
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = 12;
        6 : num = 12;
        7 : num = year - 1911;      
    endcase

   else if(year >= 1000 && year <= 1911)
  case(light)
        0 : num = year / 1000;
        1 : num = year / 100 - 10 * (year/1000);
        2 : num = year / 10 - 10 * (year/100);
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = 12;
        6 : num = 12;
        7 : num = 12;      
    endcase
    
    else if(year >= 100 && year < 1000)
  case(light)
        0 : num = 12;
        1 : num = year / 100;
        2 : num = year / 10 - 10 * (year/100);
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = 12;
        6 : num = 12;
        7 : num = 12;      
    endcase

    else if(year >= 10 && year < 100)
  case(light)
        0 : num = 12;
        1 : num = 12;
        2 : num = year / 10;
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = 12;
        6 : num = 12;
        7 : num = 12;      
    endcase

     else if(year < 10)
  case(light)
        0 : num = 12;
        1 : num = 12;
        2 : num = 12;
        3 : num = year - 10 * (year/10);
        4 : num = 12;
        5 : num = 12;
        6 : num = 12;
        7 : num = 12;      
    endcase
 end
// if(!(mode==3))
//    dot <= 1;
end
endmodule