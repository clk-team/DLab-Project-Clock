`timescale 1ns/1ps

module display_temperature (clk, chs,oout, mode,  SCL, SDA, RDY_O,ERR_O);

output [7:0]chs ;
output [7:0]oout;
output RDY_O;
output ERR_O;

input clk;
input [3:0]mode;

inout SCL;
inout SDA;

wire [3:0]last;
wire clk2;
wire  [12:0]TEMP_O;
wire [3:0] TEMP_t, TEMP_u;


 frequency_divider div(clk, clk2);
 TempSensorCtl tempsensor(
    .TMP_SCL(SCL),
    .TMP_SDA(SDA),
    .TEMP_O(TEMP_O),
    .RDY_O(RDY_O),
    .ERR_O(ERR_O),
    .CLK_I(clk),
    .SRST_I(0)
 );
 tmp_translate tmp_t(clk ,TEMP_O, TEMP_t, TEMP_u);
 plus2counter c(clk2, chs);
 words ww(last, clk2,  TEMP_t, TEMP_u);
 decoder de(oout, last);

    
endmodule