module music(
clk,
music,
sound
    );
     input clk;
     input [5:0] music;
    output reg sound;
    reg[10:0] freq;
    reg [30:0]temp = 0;
//always block for converting bcd digit into 7 segment format
    always @(music)
    begin
        case (music) //case statement
            0 : freq = 11'd698;
            1 : freq = 11'd262;
            2 : freq = 11'd294;
            3 : freq = 11'd330;
            4 : freq = 11'd349;
            5 : freq = 11'd392;
            6 : freq = 11'd440;
            7 : freq = 11'd494;//494
            8 : freq = 11'd523;
            9 : freq = 11'd587;
           10 : freq = 11'd659;           
           11 : freq = 11'd784;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : freq = 11'd1;
        endcase
  //      sound = 125_00/freq;
    end

  always @(posedge clk)
    begin
    if(temp >= 50_000_000/freq)
      begin
        temp = 0;
        sound = ~sound;
      end
    else
      temp <= temp + 1;
    end
     
endmodule