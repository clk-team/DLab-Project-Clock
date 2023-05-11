module musicwake(
   input do,
   input newclk,
   input msecclk,
   output reg [5:0]music
);

reg [2:0]tempclk; //八分音符間隔
reg [10:0]song;
reg allow;//開放放歌

initial begin
  music = 63;
  tempclk = 0;
  song = 0;
end

always @(posedge msecclk)
  begin 
   tempclk <= tempclk + 1;
  end
  always @(do) begin
if(do == 0)
begin
  song = 0;
  music = 1;
  allow = 0;
end

if(do == 1)
  begin
  allow = 1;
  end 
 end
 
 always @(posedge tempclk[2])
 begin
 if(allow == 1)
   begin
     song <= song + 1;
   end
 else
     song <= 0;
 end
 
 always @(song)
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
     endcase
   end
endmodule