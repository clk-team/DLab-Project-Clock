module alarm(
    input newclk,
    input mode,
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
    output reg do
    );

    reg temp;
    reg stop = 0;
    reg [20:0]count = 0;

  initial begin
    temp = 0;  //開放編譯
    do = 0;    
   // open_do = 0;  //open_do == 1 
    alarm_mode = 0;
  end

always @(posedge newclk)
begin
  if(temp == 0 && middle == 1 && alarm_mode == 0)//開啟轉換狀態
  begin
     alarm_mode = 1;
     temp = 1;

     temp_hour = hour;
     temp_minute = minute;
     temp_second = second;
  end

  if(temp == 0 && middle == 1 && alarm_mode != 0)//關閉轉換狀態
  begin
     alarm_mode = 0;
     temp = 1;

  end

  if(middle == 0 && temp == 1 && left == 0 && right == 0) //可以再次編譯
  begin
        temp = 0;
  end
   
  if(alarm_mode == 1)  //改秒
    begin
        if(up == 1 && temp == 0)
        begin
            temp_second = temp_second + 1;
            temp = 1;
        end

        if(down == 1 && temp == 0)
        begin
            temp_second = temp_second - 1;
            temp = 1;
        end
    end
  
    if(alarm_mode == 2)  //改分
    begin
        if(up == 1 && temp == 0)
        begin
            temp_minute = temp_minute + 1;
            temp = 1;
        end

         if(down == 1 && temp == 0)
        begin
            temp_minute = temp_minute - 1;
            temp = 1;
        end
    end

      if(alarm_mode == 3)  //改時
    begin
        if(up == 1 && temp == 0)
        begin
            temp_hour = temp_hour + 1;
            temp = 1;
        end

        if(down == 1 && temp == 0)
        begin
            temp_hour = temp_hour - 1;
            temp = 1;
        end
    end
  
  if(alarm_mode == 0 && temp_hour == hour && temp_minute == minute && temp_second == second)
    begin
      do = 1; //開始放歌
    end

  end
endmodule