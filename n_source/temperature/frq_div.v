module frequency_divider (
    input clk,
    output out
);

reg [30:0]q =0;

always@(posedge clk)begin

    q <= q+1;

end

assign out = q[15];
    
endmodule