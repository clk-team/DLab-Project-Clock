module devider(
    input clk,
    output reg secclk = 0,
    output reg msecclk = 0
);

reg counter[30:0] = 0;
reg counter2[20:0] = 0;

always @(posedge clk)
  begin
    counter <= 1;
    counter2 <= 1;
    if(counter == 50_000_000)
    begin
      counter = 0;
      secclk = ~secclk;
    end

    if(counter2 == 50_000)
    begin
      counter2 = 0;
      msecclk = ~msecclk;
    end
  end
