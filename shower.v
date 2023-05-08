
module shower(
    input light,
    output reg [7:0]a
);

always @(posedge light)
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
  endmodule