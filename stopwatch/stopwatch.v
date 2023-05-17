`timescale 1ns / 1ps

module stopwatch(clk,start,reset,tmp,mode,modify);

    input clk,start,reset,modify;
    input [3:0]mode;
    output [31:0]tmp;
    
    reg[3:0] hr_10=1,hr_1=9,min_10=4,min_1=9,sec_10=5,sec_1=4;
    reg [31:0]counter=0;
    reg [6:0]min_count=0,hr_count=0;
    reg hr_clk=0,min_clk=0;
    reg sec_clk=0;
    reg sc=0,mc=0;
    reg go = 0;
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
    reg [31:0]tmp2=32'h00b00b01;
   always@(posedge clk) begin
        if(start) begin
            time_counter <= time_counter + 1;
        end
        else
            time_counter <= 0;
    end
    
    
    always@(posedge clk) begin
        if(mode == 6) begin
            if(modify) begin
                if(time_counter == 2500000) begin
                   go <= ~go;
                end
            end
        end
    end
     
    always@(posedge clk) begin
       if(counter == 499999) begin //slow counting
           counter <= 0;
           sec_clk <= ~ sec_clk;
       end
       else
           counter <= counter + 1'b1;
    end  
    
    always@(posedge sec_clk) begin
             sec_1 <= sec_1 + 1;
        if(go) begin
            if(sec_1 == 9 && sec_10 < 5) begin
                sec_1 <= 0;
                sec_10 <= sec_10 + 1;
            end
            else if(sec_10 == 5 && sec_1 == 9 && min_1 < 9) begin
                sec_10 <= 0;
                sec_1 <= 0;
                min_1 <= min_1 + 1;
            end
            else if(min_1 == 9 && sec_10 == 5 && sec_1 == 9 && min_10 < 5) begin
                sec_10 <= 0;
                sec_1 <= 0;
                min_1 <= 0;
                min_10 <= min_10 + 1;
            end
            else if(min_10 == 5 && min_1 == 9 && sec_10 == 5 && sec_1 == 9 && hr_1 < 9) begin
                min_10 <= 0;
                min_1  <= 0;
                sec_10 <= 0;
                sec_1  <= 0;
                hr_1 <= hr_1 + 1;
            end
            else if(min_10 == 5 && min_1 == 9 && sec_10 == 5 && sec_1 == 9 && hr_1 == 9 && hr_10 < 9) begin
               hr_1 <= 0;
               min_10 <= 0;
               min_1  <= 0;
               sec_10 <= 0;
               sec_1  <= 0;
               hr_10 <= hr_10 + 1;
            end
            else if(hr_10 == 9 && hr_1 == 9 && min_10 == 5 && min_1 == 9 && sec_10 == 5 && sec_1 == 9)
               hr_1 <= 0;
               min_10 <= 0;
               min_1  <= 0;
               sec_10 <= 0;
               sec_1  <= 0;
               hr_10  <= 0;
        end
    end

    assign tmp = {hr_10,hr_1,4'hb,min_10,min_1,4'hb,sec_10,sec_1};
endmodule