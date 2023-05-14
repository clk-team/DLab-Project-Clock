
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
    output reg [10:0]temp_hour;
    output reg [10:0]temp_minute;
    output reg [10:0]temp_second;
    output reg do
    );

    reg temp;
    reg stop = 0;
    reg [20:0]count = 0;

  
    reg open_do;

  initial begin
    temp = middle;
    do = 0;
    open_do = 0;  //open_do == 1 代表不可型態轉換
    alarm_mode = 0;
  end

always @(posedege newclk)
begin
  if(temp == 0 && middle == 1 && open_do == 0 && alarm_mode == 0)//開啟轉換狀態
  begin
     alarm_mode = 1;
     open_do = 1;
     temp = 1;

     temp_hour = hour;
     temp_minute = minute;
     temp_second = second;
  end

  if(middle == 0 && temp == 1 && left == 0 && right == 0) //可以再次編譯
  begin
        temp = 0;
  end
   
  if(alarm_mode == 1 && open_do == 0)  //改秒
    begin
        
    end

  
  if(alarm_mode == 0 && temp_hour == hour && temp_minute == minute && temp_second == second)
    begin
      go = 1; //開始編譯
    end

  end
endmodule