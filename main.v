
module main(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input middle,
    output seg[7:0],  //七段顯示器
    output show[7:0],  //七段顯示器的電晶體
    output sound //聲音
);

reg [15:0]year, [5:0]month, [10:0]day, [10:0]hour, [10:0]minute, [10:0]second, [10:0]week;  //年、月、日、時、分、秒、星期
reg newclk;  //除頻
reg secclk, msecclk;  //秒、毫秒
divider second(clk, secclk, msecclk, newclk);  //秒、毫秒
reg num = 0;  //拿來弄電晶體

always @(posedge newclk)
begin
    num = num + 1;
    if(num == 8)
    num = 1;
end

time uuu(secclk, year, month, day, hour, minute, second, week); //基礎時間
shower ggg(num, show);
sevenseg kkk(num, seg);