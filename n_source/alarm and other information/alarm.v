`timescale 1ns / 1ps

module alarm(
    input switch,
    input newclk,
    input [5:0]mode,
    input up, 
    input down,
    input left,
    input right,
    input [10:0]hour,
    input [10:0]minute,
    input [10:0]second, 
    input middle,
    output reg[2:0]alarm_mode,
    output reg [10:0]temp_hour,
    output reg [10:0]temp_minute,
    output reg [10:0]temp_second,
    output reg do,
    input do_1
    );

    reg temp;
    reg [15:0]count;
    reg new;
  initial begin
    temp = 0;  //??蝺刻陌
    do = 0;    
    alarm_mode = 2;
    count = 0;
    temp_hour = 26;
    temp_minute = 0;
    temp_second = 0;
    new = 0;
  end

always @(posedge newclk)
begin
    if(mode != 5)
      alarm_mode = 0;
      if(mode == 5)
      begin
    if(middle == 0 && temp == 1 && left == 0 && right == 0) 
        count <= count + 1;
      else
      count <= 0;
    if(count >= 2000)
    begin
      count <= 0;
      temp = 0;
    end
      
    if(temp == 0 && middle == 1 && alarm_mode == 0 && new ==0)
    begin
     alarm_mode = 1;
     temp = 1;
     new = 1;
     
     temp_hour = hour;
     temp_minute = minute;
     temp_second = second;
  end
    else if(temp == 0 && middle == 1 && alarm_mode == 0 && new == 1)
    begin
     alarm_mode = 1;
     temp = 1;
  end

    if(temp == 0 && middle == 1 && alarm_mode != 0)
      begin
         alarm_mode = 0;
         temp = 1;
      end

    if(alarm_mode == 1 && left == 1 && temp == 0) 
    begin
       alarm_mode = 2;
       temp = 1;
    end 
    else if(alarm_mode == 2 && left == 1 && temp == 0)
    begin
       alarm_mode = 3; 
       temp = 1;
    end
    
    else if(alarm_mode == 3 && left == 1 && temp == 0)
    begin
       alarm_mode = 1;
       temp = 1;
    end    
    else if(alarm_mode == 1 && right == 1 && temp == 0)
    begin
       alarm_mode = 3;
       temp = 1;
    end 
    else if(alarm_mode == 2 && right == 1 && temp == 0)
    begin
       alarm_mode = 1;
       temp = 1;
     end 
    else if(alarm_mode == 3 && right == 1 && temp == 0)
    begin
       alarm_mode = 2;        
       temp = 1;
    end
    
    if(alarm_mode == 1)  
    begin
        if(up == 1 && temp == 0)
        begin
            temp_second = temp_second + 1;
            temp = 1;
        end

        else if(down == 1 && temp == 0)
        begin
            temp_second = temp_second - 1;
            temp = 1;
        end
    end
  
    if(alarm_mode == 2)  
    begin
        if(up == 1 && temp == 0)
        begin
            temp_minute = temp_minute + 1;
            temp = 1;
        end

         else if(down == 1 && temp == 0)
        begin
            temp_minute = temp_minute - 1;
            temp = 1;
        end
    end

    if(alarm_mode == 3)  
    begin
        if(up == 1 && temp == 0)
        begin
            temp_hour = temp_hour + 1;
            temp = 1;
        end

        else if(down == 1 && temp == 0)
        begin
            temp_hour = temp_hour - 1;
            temp = 1;
        end
    end
  
    if(alarm_mode == 0 && temp_hour == hour && temp_minute == minute && temp_second == second)  
    begin
      do = 1;
    end
    
    if(do_1 == 1)
        do <= 1;
    
    if(switch == 1)
       do = 0;
    
    if(alarm_mode != 0 && temp_second > 90)
      temp_second <= 59;
    else if(alarm_mode != 0 && temp_second >= 60)
      temp_second <= 0;
      
    if(alarm_mode != 0 && temp_minute > 90)
      temp_minute = 59;
    else if(alarm_mode != 0 && temp_minute >= 60)
      temp_minute = 0;
      
    if(alarm_mode != 0 && temp_hour >= 60)
      temp_hour = 23;
    else if(alarm_mode != 0 && temp_hour >= 24)
      temp_hour = 0;
  end
  end
endmodule