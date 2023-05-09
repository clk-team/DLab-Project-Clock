
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

  initial begin
    temp = middle;
    do = 0;
  end

    if(temp != middle)
    begin
        count <= count + 1;
        if(count == 1_000_000)
      begin 
        count <= 0;
        tenp <= middle;
      end
    end
    else
        count <= 0;
    
    if(middle == 1 && stop == 0)
      begin
        stop = 1;
      end

endmodule