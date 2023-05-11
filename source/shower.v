module shower(
    input [2:0]light,
    input newclk,
    input msecclk,
    input [2:0]alarm_mode,
    output reg [7:0]a
);

reg[8:0]counter = 0;
always @(posedge msecclk)
  counter <= counter + 1;  //半秒閃一次

always @(light)
  begin 
    if(alarm_mode == 0)//正常模式
    begin
      case(light)
        0 : a = 8'b01111111;
        1 : a = 8'b10111111;
        2 : a = 8'b11011111;
        3 : a = 8'b11101111;
        4 : a = 8'b11110111;
        5 : a = 8'b11111011;
        6 : a = 8'b11111101;
        7 : a = 8'b11111110;
        default : a = 8'b11111111;
         endcase
    end

    if(alarm_mode == 1)//改變秒
    begin
      case(light)
        0 : a = 8'b01111111;
        1 : a = 8'b10111111;
        2 : a = 8'b11011111;
        3 : a = 8'b11101111;      
        4 : 
          if(counter[8] == 0)
            a = 8'b11110111;
          else
            a = 8'b11111111;
        5 : 
          if(counter[8] == 0)
            a = 8'b11111011;
          else
            a = 8'b11111111;

        6 : a = 8'b11111101;
        7 : a = 8'b11111110;
        default : a = 8'b11111111;
         endcase
    end

    if(alarm_mode == 2)//改變分
    begin
      case(light)
        0 : a = 8'b01111111;
        1 : a = 8'b10111111;
        2 :   
        if(counter[8] == 0)
            a = 8'b11011111;
          else
            a = 8'b11111111;

        3 :  
         if(counter[8] == 0)
            a = 8'b11101111;
          else
            a = 8'b11111111; 

        4 : a = 8'b11110111;
        5 : a = 8'b11111011;
        6 : a = 8'b11111101;
        7 : a = 8'b11111110;
        default : a = 8'b11111111;
         endcase
    end

if(alarm_mode == 1)//改變時
    begin
      case(light)
        0 :   
        if(counter[8] == 0)
            a = 8'b01111111;
          else
            a = 8'b11111111;

        1 :   
        if(counter[8] == 0)
            a = 8'b10111111;
          else
            a = 8'b11111111;

        2 : a = 8'b11011111;
        3 : a = 8'b11101111;      
        4 : a = 8'b11110111;
        5 : a = 8'b11111011;
        6 : a = 8'b11111101;
        7 : a = 8'b11111110;
        default : a = 8'b11111111;
         endcase
      end
    end
    endmodule