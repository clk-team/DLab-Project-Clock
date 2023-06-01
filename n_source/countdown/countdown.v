`timescale 1ns / 1ps

module countdown(clk,start,tmp1,tmp,finish,go,do);

    input clk,start;
    input [31:0]tmp1;
    input go;
    output [31:0]tmp;
    output reg finish=0;
    output reg do;
//    inout [6:0]hour1;
//    inout [5:0]min1,sec1;
    
    parameter S0 = 0, 
              S1 = 1,
              S2 = 2,
              S3 = 3,
              S4 = 4,
              S5 = 5,
              S6 = 6, 
              S7 = 7; // end countdown
    reg[3:0] hr_10=1,hr_1=9,min_10=4,min_1=9,sec_10=5,sec_1=4;
    reg [31:0]counter=0;
    reg [6:0]min_count=0,hr_count=0;
    reg hr_clk=0,min_clk=0;
    reg [3:0]cur_state=S0,next_state=S0;
    reg sec_clk=0;
    reg sc=0,mc=0;
    reg [7:0] sec=0;
    reg [7:0] min=0;
    reg [7:0] hour=0;
    reg [31:0]time_counter=0;
    reg [31:0]up_counter=0;
    reg [31:0]down_counter=0;
    reg [31:0]left_counter=0;
    reg [31:0]right_counter=0;
    integer i=0;
    reg debounce=0;
    reg [31:0]tmp2=32'h00a00a01;
    
     
   always@(posedge clk) begin
           if(counter == 49999999) begin //slow counting
               counter <= 0;
               sec_clk <= ~ sec_clk;
           end
           else
               counter <= counter + 1'b1;
    end  
    
    always@(posedge sec_clk) begin
        if(hr_10 != 0 || hr_1 != 0 || min_10 != 0 || min_1 != 0 || sec_10 != 0 || sec_1 != 0) begin
             sec_1 <= sec_1 - 1;
             finish <= 0;
        end
        if(go) begin
            if(sec_1 == 0 && sec_10 > 0) begin
                sec_1 <= 9;
                sec_10 <= sec_10 - 1;
            end
            else if(sec_10 == 0 && sec_1 == 0 && min_1 > 0) begin
                sec_10 <= 5;
                sec_1 <= 9;
                min_1 <= min_1 - 1;
            end
            else if(min_1 == 0 && sec_10 == 0 && sec_1 == 0 && min_10 > 0) begin
                min_1 <= 9;
                min_10 <= min_10 - 1;
            end
            else if(min_10 == 0 && min_1 == 0 && sec_10 == 0 && sec_1 == 0 && hr_1 > 0) begin
                min_10 <= 5;
                min_1  <= 9;
                sec_10 <= 5;
                sec_1  <= 9;
                hr_1 <= hr_1 - 1;
            end
            else if(min_10 == 0 && min_1 == 0 && sec_10 == 0 && sec_1 == 0 && hr_1 == 0 && hr_10 > 0) begin
               hr_1 <= 9;
               min_10 <= 5;
               min_1  <= 9;
               sec_10 <= 5;
               sec_1  <= 9;
               hr_10 <= hr_10 - 1;
            end
            else if(hr_10 == 0 && hr_1 == 0 && min_10 == 0 && min_1 == 0 && sec_10 == 0 && sec_1 == 0) begin
                finish <= 1;
                do <= 1;
            end
        end
        else begin
                sec_1       <= tmp1[3:0];
                sec_10      <= tmp1[7:4];
                min_1       <= tmp1[15:12];
                min_10      <= tmp1[19:16];
                hr_1        <= tmp1[27:24];
                hr_10       <= tmp1[31:28];
        end
//           else begin
//                sec_1  <= tmp2[3:0];
//                sec_10 <= tmp2[7:4];
//                min_1  <= tmp2[15:12];
//                min_10 <= tmp2[19:16];
//                hr_1   <= tmp2[27:24];
//                hr_10  <= tmp2[31:28];
//           end
       end

    
    assign tmp = {hr_10,hr_1,4'hf,min_10,min_1,4'hf,sec_10,sec_1};
endmodule