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
            0 : freq = 11'd262;//C
            1 : freq = 11'd277;
            2 : freq = 11'd294;//D
            3 : freq = 11'd311;
            4 : freq = 11'd330;//E
            5 : freq = 11'd349;//F
            6 : freq = 11'd370;  
            7 : freq = 11'd392;//G
            8 : freq = 11'd415;
            9 : freq = 11'd440;//中央A
           10 : freq = 11'd466;           
           11 : freq = 11'd494;//B si
           12 : freq = 11'd523;//C do
           13 : freq = 11'd554;
           14 : freq = 11'd587;//D
           15 : freq = 11'd622;
           16 : freq = 11'd659;//E
           17 : freq = 11'd698;//F
           18 : freq = 11'd739;  
           19 : freq = 11'd783;//G  SO
           20 : freq = 11'd831;
           21 : freq = 11'd880;//A
           22 : freq = 11'd932;           
           23 : freq = 11'd988;//B
           24 : freq = 11'd1046; //c
           25 : freq = 11'd1109;
           26 : freq = 11'd1175;//d
           27 : freq = 11'd1245;
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