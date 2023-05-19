`timescale 1ns/1ps

module musicwake(
   input do,
   input clk,
   input newclk,
   input msecclk,
   output reg [5:0]music
);

reg [2:0]tempclk; //八分音符間隔
reg [10:0]song;
reg allow;//開放放歌

initial begin
  tempclk = 0;
  music = 0;
  song = 0;
end

always @(posedge msecclk)
  begin 
   tempclk <= tempclk + 1;
  end

always @(msecclk) begin
 if(do == 0)
  begin
    allow = 0;
  end

else if(do == 1)
  begin
  allow = 1;
  end 
end
 
 always @(posedge tempclk[2])
 begin
 if(allow == 1)
   begin
     song <= song + 1;
     if(song == 137)
       song <= 0;
   end
 else
     song <= 0;
 end
 
 always @(tempclk[2])

   begin
     case(song)
       0 : music = 63;
       1 : music = 19;
       2 : music = 10;
       3 : music = 19;
       4 : music = 10;
       5 : music = 19;
       6 : music = 10;
       7 : music = 20;
       8 : music = 10;

       9 : music = 19;
       10 : music = 10;
       11 : music = 19;
       12 : music = 10;
       13 : music = 19;
       14 : music = 10;
       15 : music = 15;
       16 : music = 17;

       17 : music = 19;
       18 : music = 10;
       19 : music = 19;
       20 : music = 10;
       21 : music = 19;
       22 : music = 10;
       23 : music = 20;
       24 : music = 10;

       25 : music = 22;
       26 : music = 10;
       27 : music = 20;
       28 : music = 10;
       29 : music = 19;
       30 : music = 10;
       31 : music = 17;
       32 : music = 17;

       33 : music = 15;
       34 : music = 10;
       35 : music = 15;
       36 : music = 10;
       37 : music = 15;
       38 : music = 10;
       39 : music = 17;
       40 : music = 10;

       41 : music = 15;
       42 : music = 10;
       43 : music = 15;
       44 : music = 10;
       45 : music = 15;
       46 : music = 10;
       47 : music = 22;
       48 : music = 22;

       49 : music = 15;
       50 : music = 10;
       51 : music = 15;
       52 : music = 17;
       53 : music = 19;
       54 : music = 17;
       55 : music = 15;
       56 : music = 10;

       57 : music = 15;
       58 : music = 10;
       59 : music = 15;
       60 : music = 17;
       61 : music = 19;
       62 : music = 17;
       63 : music = 15;
       64 : music = 17;

       65 : music = 19;
       66 : music = 10;
       67 : music = 19;
       68 : music = 10;
       69 : music = 19;
       70 : music = 10;
       71 : music = 20;
       72 : music = 10;

       73 : music = 19;
       74 : music = 10;
       75 : music = 19;
       76 : music = 10;
       77 : music = 19;
       78 : music = 10;
       79 : music = 15;
       80 : music = 17;

       81 : music = 19;
       82 : music = 10;
       83 : music = 19;
       84 : music = 10;
       85 : music = 19;
       86 : music = 10;
       87 : music = 19;
       88 : music = 20;

       89 : music = 22;
       90 : music = 10;
       91 : music = 27;
       92 : music = 10;
       93 : music = 22;
       94 : music = 20;
       95 : music = 19;
       96 : music = 17;

       97 : music = 15;
       98 : music = 10;
       99 : music = 15;
       100 : music = 10;
       101 : music = 15;
       102 : music = 10;
       103 : music = 22;
       104 : music = 10;

       105 : music = 27;
       106 : music = 10;
       107 : music = 22;
       108 : music = 20;
       109 : music = 19;
       110 : music = 17;
       111 : music = 15;
       112 : music = 10;

       113 : music = 15;
       114 : music = 10;
       115 : music = 15;
       116 : music = 17;
       117 : music = 19;
       118 : music = 17;
       119 : music = 15;
       120 : music = 10;

       121 : music = 15;
       122 : music = 10;
       123 : music = 15;
       124 : music = 22;
       125 : music = 20;
       126 : music = 19;
       127 : music = 17;
       128 : music = 17;

       129 : music = 15;
       130 : music = 15;
       131 : music = 63;
       132 : music = 63;
       133 : music = 63;
       134 : music = 63;
       135 : music = 63;
       136 : music = 63;
       default : music = 63;
     endcase
   end

endmodule