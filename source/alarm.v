
module alarm(
    input clk,
    input mode,
    input [10:0]hour,
    input [10:0]minute,
    input [10:0]second, 
    input middle,
    output[2:0]alarm_mode,
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
  end

  if(temp == 0 && middle == 1)
     begin
        open_do = ~open_do;
        temp = 1;
     end
  if(middle == 0 && temp == 1)
  begin
    temp = 0;
  end
endmodule