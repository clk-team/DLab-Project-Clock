
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

reg hour, minute, second;
reg newclk;  //除頻
reg secclk, msecclk;  //秒、毫秒
divider second(clk, secclk, msecclk, newclk);  //秒、毫秒
reg num = 0;

always @(newclk)
begin
    num = num + 1;
    if(num == 8)
    num = 1;
end

shower(num, show);
sevenseg kkk(num, seg);