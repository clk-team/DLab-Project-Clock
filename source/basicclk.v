
module basic_clk(
    input mode,
    input light,
    input [15:0]year, 
    input [5:0]month, 
    input [10:0]day, 
    input [10:0]hour, 
    input [10:0]minute, 
    input [10:0]second, 
    input [10:0]week,
    output reg num
);


always @(posedge light)
if(mode == 1)
begin
  begin 
      case(light)
        0 : num = hour / 10;
        1 : num = hour - 10 * (hour/10);
        2 : num = minute / 10;
        3 : num = minute - 10 * (minute / 10);
        4 : num = second;
        5 : num = second - 10 * (second / 10);
        6 : num = 11;
        7 : num = 11;
    endcase
  end
end
endmodule