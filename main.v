
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

reg [15:0]year;
reg [5:0]month;
reg [10:0]day; 
reg [10:0]hour; 
reg [10:0]minute; 
reg [10:0]second; 
reg [10:0]week;  //年、月、日、時、分、秒、星期
reg newclk;  //除頻
reg secclk, msecclk;  //秒、毫秒
reg num = 0;  
reg light = 0; //電晶體

divider aaa(clk, secclk, msecclk, newclk);  //秒、毫秒

always @(posedge newclk)
begin
    light <= light + 1;
    if(light == 8)
    light = 0;
end

current_time bbb(secclk, year, month, day, hour, minute, second, week); //基礎時間
shower ccc(light, show);//七段顯示器(電晶體)
sevenseg ddd(num, seg);//七段顯示器(數字轉換)

endmodule