
module alarm(
    input newclk,
    input mode,
    input [10:0]hour,
    input [10:0]minute,
    input [10:0]second, 
    input middle,
    output reg[2:0]alarm_mode,
    output reg do
    );

    reg temp;
    reg stop = 0;
    reg [20:0]count = 0;

    reg [10:0]temp_hour;
    reg [10:0]temp_minute;
    reg [10:0]temp_hour;
    reg open_do;

  initial begin
    temp = middle;
    do = 0;
    open_do = 0;  //open_do == 1 代表編譯狀態
    alarm_mode = 0;
  end
always @(posedege newclk)
begin
  if(temp == 0 && middle == 1)//轉換狀態
  begin
    if(open_do == 0)  //開始編譯
      alarm_mode = 1;
    if(open_do == 1)  //結束編譯
      alarm_mode = 0;
      #100_000
     open_do = ~open_do;
        temp = 1;
  end

  if(middle == 0 && temp == 1)
  begin
        temp = 0;
  end
   
  if(alarm_mode == 1 &&open_do == 0)
    begin
        temp_hour = hour;
        temp_minute = minute;
        temp_second = second;
    end
  end
endmodule