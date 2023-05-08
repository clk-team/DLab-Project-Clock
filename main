
module main(
    input clk;
    input up;
    input down;
    input left;
    input right;
    output seg[7:0];  //七段顯示器
    output show[7:0];  //七段顯示器的電晶體
    output sound; //聲音
);

reg secclk, msecclk;  //秒、毫秒
divider second(clk, secclk, msecclk);  //秒、毫秒


sevenseg kkk(num, seg);