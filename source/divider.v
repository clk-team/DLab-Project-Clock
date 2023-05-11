module divider(
    input clk,
    output reg secclk,
    output reg msecclk,
    output reg newclk
);

reg [30:0]counter;
reg [32:0]counter2;
reg [20:0]counter3;

initial begin
  counter = 0;
  counter2 = 0;
  counter3 = 0;
  secclk = 0;
  msecclk = 0;
  newclk = 0;
  end
  
always @(posedge clk)
  begin
    counter <= counter + 1;
    counter2 <= counter2 + 1;
    counter3 <= counter3 + 1;
    if(counter >= 50_000_000)
    begin
      counter <= 0;
      secclk = ~secclk;
    end

    if(counter2 >= 50_000)
    begin
      counter2 = 0;
      msecclk = ~msecclk;
    end
    newclk = counter3[13];
  end
  
endmodule