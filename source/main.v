module main(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input middle,
    output [7:0]seg,  //七段顯示器
    output [7:0]show,  //七段顯示器的電晶體
    output sound //聲音
);
wire [15:0]year;
wire [5:0]month;
wire [10:0]day; 
wire[10:0]hour; 
wire [10:0]minute; 
wire [10:0]second; 
wire [10:0]week;  //年、月、日、時、分、秒、星期
wire newclk;  //除頻
wire secclk, msecclk;  //秒、毫秒
wire [10:0]num;  
reg [2:0]light = 0; //電晶體
wire[2:0] alarm_mode = 0;  //0:正常 1:改變秒 2:改變分 3:改變時
reg do = 0;
reg [5:0]mode = 1;
divider aaa(clk, secclk, msecclk, newclk);  //秒、毫秒
reg [3:0]sel; // 當前模式
wire [3:0]rel; //下個clk的模式

reg[5:0] music//拿蘭傳音符
always @(posedge newclk)
begin
    light <= light + 1;
end

always@(posedge clk) begin
    sel <= rel;
end

current_time bbb(secclk, year, month, day, hour, minute, second, week); //時間變動(mode 0)                    //檢查完成
mode_selection mode_sel(clk,sel,up,down,rel,middle);
basic_clk ddd(mode, light, year, month, day, hour, minute, second, week, num); //基本時間(mode 1) 時:分:秒    //檢查完成
seven_seg eee(num, seg);//七段顯示器(數字轉換)                                                                //檢查完成
shower ccc(light, newclk, msecclk, alarm_mode, show);//七段顯示器(電晶體)
alarm fff(newclk, mode, up, down, left, right, hour, minute, second, middle, alarm_mode,temp_hour, temp_minute, temp_second, do); //鬧鐘(mode 3)
musicwake ggg(do, music);  //啟動音樂(樂譜)
music hhh( clk, music, sound);  //聲音轉換(sound為輸出)

endmodule