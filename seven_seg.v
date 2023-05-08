
module seven_seg{
    input num, 
    output seg[7:0]
}

always @(num)
  begin 
      case(num)
        0 : seg = 8'b00000011;
        1 : seg = 8'b10011111;
        2 : seg = 8'b00100101;
        3 : seg = 8'b00001101;
        4 : seg = 8'b10011001;
        5 : seg = 8'b01001001;
        6 : seg = 8'b01000001;
        7 : seg = 8'b00011111;
        8 : seg = 8'b00000001;
        9 : seg = 8'b00001001;
  end

endmodule