module main(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input middle,
    input quick,
    input  [14:0]year_d,
   input  [3:0]month_d,
   input  [4:0]day_d,
   input  [5:0]hour_d,
   input  [5:0]min_d,
   input  [5:0]sec_d,
   input  [3:0]week_s,
   input  [3:0]mode, 
    output [7:0]seg,  //七段顯示???
    output [7:0]show,  //七段顯示??????電?????
    output sound, //聲音
    output dot 
    
);
wire [15:0]year;
wire [5:0]month;
wire [10:0]day; 
wire[10:0]hour; 
wire [10:0]minute; 
wire [10:0]second; 
wire [10:0]week;  //年?????????日??????????????????????????
wire newclk;  //??????
wire secclk, msecclk;  //秒???毫??
wire [10:0]num;  
reg [2:0]light = 0; //????????
wire[2:0] alarm_mode = 0;  //0:正常 1:改變秒 2:改變分 3:改變時

divider aaa(clk, secclk, msecclk, newclk);  //秒???毫??


//鬧鐘
wire [10:0]temp_hour;
wire[10:0] temp_minute;
wire[10:0]temp_second;

wire[5:0] music;//拿蘭傳音符
always @(posedge newclk)
begin
    light <= light + 1;
end



current_time ttt(
   .clk(clk),
   .year_d(year_d),
   .month_d(month_d),
   .day_d(day_d),
   .hour_d(hour_d),
   .min_d(min_d),
   .sec_d(sec_d),
   .week_s(week_s),
   .mode(mode), 
   .year(year), 
   .month(month), 
   .day(day), 
   .hour(hour), 
   .minute(minute), 
   .second(second), 
   .week(week)
   
);                    

basic_clk ddd(mode, light, year, month, day, hour, minute, second, week, alarm_mode, temp_hour, temp_minute, temp_second, num, dot); //????????????(mode 1) ???:???:??    //檢查完???
seven_seg eee(num, seg);//七段顯示???(???字??????)                                                                //檢查完???
shower ccc(light, newclk, msecclk, alarm_mode, show);//七段顯示???(????????)

alarm fff(switch, newclk, mode, up, down, left, right, hour, minute, second, middle, alarm_mode,temp_hour, temp_minute, temp_second, do); //鬧鐘(mode 3)
musicwake ggg(do, music);  //啟動音樂(樂譜)
music hhh( clk, music, sound);  //聲音轉換(sound為輸出)




endmodule
