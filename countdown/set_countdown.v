`timescale 1ns / 1ps

module set_countdown(clk,up,down,left,right,start,tmp,state,go,modify,mode);

    input clk,up,down,left,right,start,modify;
    input [3:0]mode;
    output [31:0]tmp;
    output [3:0]state;
    output reg go=0;
    
    
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
    reg [7:0] sec=56;
    reg [7:0] min=34;
    reg [7:0] hour=12;
    reg [31:0]time_counter=0;
    reg [31:0]up_counter=0;
    reg [31:0]down_counter=0;
    reg [31:0]left_counter=0;
    reg [31:0]right_counter=0;
    reg [31:0]time1_counter=0;
    integer i=0;   
    
    always@(posedge clk) begin
        if(start) begin
            time_counter <= time_counter + 1;
        end
        else
            time_counter <= 0;
    end
    
    always@(posedge clk) begin
        if(time_counter == 2500000) begin
           go <= ~go;
        end
        else if(time_counter == 200000000)
           go <= 0;
    end
//modify setting
    
    always@(posedge clk) begin
        cur_state <= next_state;
    end
    
    always@(posedge clk) begin
        if(up)
            up_counter <= up_counter + 1;
        else
            up_counter <= 0;
    end
    
    always@(posedge clk) begin
        if(down)
            down_counter <= down_counter + 1;
        else
            down_counter <= 0;
    end
    
   

    always@(posedge clk) begin
    if(mode == 7) begin
    if(modify) begin
        if(up_counter == 2500000) begin
        if(!go) begin
            case(cur_state)
                S1 : begin
                    if(sec_1 == 9) begin
                        sec_1 <= sec_1 - 9;
                    end
                    else begin
                        sec_1 <= sec_1 + 1;
                    end
                end
                S2 : begin
                    if(sec_10 == 5) begin
                        sec_10 <= sec_10 - 5;
                    end
                    else begin
                        sec_10 <= sec_10 + 1;
                    end
                end 
                S3 : begin
                    if(min_1 == 9) begin
                        min_1 <= min_1 - 9;
                    end
                    else begin
                        min_1 <= min_1 + 1;
                    end
                end
                S4 : begin
                    if(min_10 == 5) begin
                        min_10 <= min_10 - 5;
                    end
                    else begin
                        min_10 <= min_10 + 1;
                    end
                end
                S5 : begin
                    if(hr_1 == 9) begin
                        hr_1 <= hr_1 - 9;
                    end
                    else begin
                        hr_1 <= hr_1 + 1;
                    end
                end
                S6 : begin
                    if(hr_10 == 9) begin
                        hr_10  <= hr_10 -9;
                    end
                    else begin
                        hr_10  <= hr_10 + 1;
                    end
                end
            endcase
            end
        end
        if(down_counter == 2500000) begin
        if(!go) begin
            case(cur_state)
                S1 : begin
                    if(sec_1 == 0) begin
                        sec_1 <= sec_1 + 9;
                    end
                    else begin
                        sec_1 <= sec_1 - 1;
                    end
                end
                S2 : begin
                    if(sec_10 == 0) begin
                        sec_10 <= sec_10 + 5;
                    end
                    else begin
                        sec_10 <= sec_10 - 1;
                    end
                end 
                S3 : begin
                    if(min_1 == 0) begin
                        min_1 <= min_1 + 9;
                    end
                    else begin
                        min_1 <= min_1 - 1;
                    end
                end
                S4 : begin
                    if(min_10 == 0) begin
                        min_10 <= min_10 + 5;
                    end
                    else begin
                        min_10 <= min_10 - 1;
                    end
                end
                S5 : begin
                    if(hr_1 == 0)
                        hr_1 <= hr_1 + 9;
                    else
                        hr_1 <= hr_1 - 1;
                end
                S6 : begin
                    if(hr_10 == 0)
                        hr_10 <= hr_10 + 9;
                    else
                        hr_10 <= hr_10 - 1; 
                end
            endcase
            end
        end
    end
    end
    end
    
    always@(posedge clk) begin
        if(left)
            left_counter <= left_counter + 1;
        else
            left_counter <= 0;
    end
    
    always@(posedge clk) begin
        if(right)
            right_counter <= right_counter + 1;
        else
            right_counter <= 0;
    end
    
    always@(posedge clk) begin
    if(mode == 7) begin
    if(modify) begin
        if(right_counter == 2500000) begin
        if(!go && cur_state) begin
            case(cur_state)
                S1 :
                    next_state <= S6;
                default :
                    next_state <= cur_state - 1;
            endcase
        end
        end
        else if(left_counter == 2500000) begin
        if(!go && cur_state) begin
            case(cur_state)
                S6 :
                    next_state <= S1;
                default :
                    next_state <= cur_state + 1;
            endcase
        end
        end
        else if(time_counter == 2500000) begin
            next_state <= S0;
        end
        else if(time_counter == 200000000) begin
            next_state <= S1;
        end
    end
    end
    end 
    
    assign tmp = {hr_10,hr_1,4'hf,min_10,min_1,4'hf,sec_10,sec_1};
    assign state = cur_state;
    
endmodule