module main(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input middle,
    input  [14:0]year_d,
   input  [3:0]month_d,
   input  [4:0]day_d,
   input  [5:0]hour_d,
   input  [5:0]min_d,
   input  [5:0]sec_d,
   input  [3:0]week_s,
   input  [3:0]mode, 
    output [7:0]seg,  //ä¸ƒæ®µé¡¯ç¤º?™¨
    output [7:0]show  //ä¸ƒæ®µé¡¯ç¤º?™¨??„é›»?™¶é«?
    
);
wire [15:0]year;
wire [5:0]month;
wire [10:0]day; 
wire[10:0]hour; 
wire [10:0]minute; 
wire [10:0]second; 
wire [10:0]week;  //å¹´ã?æ?ˆã?æ—¥?æ?‚ã?å?†ã?ç?’ã?æ?Ÿæ??
wire newclk;  //?™¤? »
wire secclk, msecclk;  //ç§’ã?æ¯«ç§?
wire [10:0]num;  
reg [2:0]light = 0; //?›»?™¶é«?

divider aaa(clk, secclk, msecclk, newclk);  //ç§’ã?æ¯«ç§?

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

basic_clk ddd(mode, light, year, month, day, hour, minute, second, week, alarm_mode, temp_hour, temp_minute, temp_second, num); //?Ÿº?œ¬??‚é??(mode 1) ???:???:ç§?    //æª¢æŸ¥å®Œæ??
seven_seg eee(num, seg);//ä¸ƒæ®µé¡¯ç¤º?™¨(?•¸å­—è?‰æ??)                                                                //æª¢æŸ¥å®Œæ??
shower ccc(light, newclk, msecclk, alarm_mode, show);//ä¸ƒæ®µé¡¯ç¤º?™¨(?›»?™¶é«?)




endmodule
