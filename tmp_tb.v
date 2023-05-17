`timescale 1ns/1ps

module tmp_tb ();

reg clk;
reg [12:0]TEMP_O;

wire[3:0]TEMP_t, TEMP_u;

tmp_translate tmp_t(clk ,TEMP_O, TEMP_t, TEMP_u);

initial begin
    clk = 0;
    TEMP_O = 13'b000011000000;
end

always #10 clk = ~ clk;
    
endmodule