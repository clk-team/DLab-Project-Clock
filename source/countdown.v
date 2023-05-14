`timescale 1ns / 1ps

module countdown(clk,up,down,left,right,start,reset,modify,quick,hr_10,hr_1,min_10,min_1,sec_10,sec_1);

    input clk,up,down,left,right,start,reset,modify,quick;
    output reg[3:0]hr_10,hr_1,min_10,min_1,sec_10,sec_1;
    
    
    parameter S0 = 0, 
              S1 = 1,
              S2 = 2,
              S3 = 3,
              S4 = 4,
              S5 = 5,
              S6 = 6, 
              S7 = 7; // end countdown
              
    reg [31:0]counter=0;
    reg [6:0]min_count=0,hr_count=0;
    reg hr_clk=0,min_clk=0;
    reg debounce=0,up_debounce=0,down_debounce=0,modi_debounce=0,left_debounce=0,right_debounce=0;
    reg go=0,modi_go=0;
    reg [3:0]cur_state=S0,next_state=S0;
    reg sec_clk=0;
    reg sc=0,mc=0;
    reg [5:0] sec=0;
    reg [5:0] min=0;
    reg [6:0] hour=0;
    integer i;
    
    always@(posedge clk) begin
        if(reset) begin
            hour <= 0;
            min  <= 0;
            sec  <= 0;
            go <= 0;
        end
    end
            
    
    always@(posedge clk) begin
        if(go==0)    begin
            counter <= counter;
        end
        else if(go==1)   begin
            if(quick==0)  begin
                if(counter == 49999999) begin //slow counting
                    counter <= 0;
                    sec_clk <= ~ sec_clk;
                end
                else
                    counter <= counter + 1'b1;
            end
            else begin
                if(counter == 1) begin //fast counting
                    counter <= 0;
                    sec_clk <= ~sec_clk;
                end
                else
                    counter <= counter + 1'b1;
            end
        end
    end      
    
    always@(posedge sec_clk) begin
        if(sec < 1) begin
            sec <= 59;
            sc <= 1;
        end
        else  begin
            sec <= sec - 1;
            sc <= 0;
        end
    end
    
    always @(posedge sc) begin
        if(min < 1) begin
            min <= 59;
            mc <= 1;
        end
        else begin
            min <= min - 1;
            mc <= 0;
        end
    end
    
    always @(posedge mc) begin
            hour <= hour - 1;
    end
    
    always@(hour) begin
        hr_1  = 4'd0;
        hr_10 = 4'd0;
    
    for(i = 6 ; i >= 0 ; i = i - 1) begin
    
        if(hr_10 >= 5)
           hr_10 = hr_10 + 3;
        if(hr_1 >= 5)
            hr_1 = hr_1 + 3;
            
        hr_10 = hr_10 << 1;
        hr_10[0] = hr_1[3];
        
        hr_1 = hr_1 << 1;
        hr_1[0] = hour[i];
    end
    end
    always@(min) begin
        min_1  = 4'd0;
        min_10 = 4'd0;
    
    for(i = 5 ; i >= 0 ; i = i - 1) begin
    
        if(min_10 >= 5)
           min_1 = min_1 + 3;
        if(min_1 >= 5)
            min_1 = min_1 + 3;
            
        min_10 = min_10 << 1;
        min_10[0] = min_1[3];
        
        min_1 = min_1 << 1;
        min_1[0] = min[i];
    end
    end
    always@(sec) begin
        sec_1  = 4'd0;
        sec_10 = 4'd0;
    
    for(i = 5 ; i >= 0 ; i = i - 1) begin
    
        if(sec_1 >= 5)
           sec_1 = sec_1 + 3;
        if(sec_10 >= 5)
            sec_10 = sec_10 + 3;
            
        sec_10 = sec_10 << 1;
        sec_10[0] = sec_1[3];
        
        sec_1 = sec_1 << 1;
        sec_1[0] = sec[i];
    end
    end
    
    
    always@(posedge clk) begin
        if(start && !debounce) begin
            debounce <= 1;
            go <= ~go;
            next_state <= S0;
        end
    end
    
    always@(posedge clk) begin
        if(!start && debounce) begin
          debounce <= 0;
        end
    end


//modify setting

    always@(posedge clk) begin
        if(modify && !modi_debounce) begin
            modi_debounce <= 1;
            next_state <= S1;
            go <= 0;
        end
        else if(!modify && modi_debounce) begin
            modi_debounce <= 0;
        end
    end

//    always@(posedge clk) begin
//        if(modify && modi_go == 1)
//            next_state <= S1;
////        else if(!modi_go)
////            next_state <= S0;
//    end

    always@(posedge clk) begin
        cur_state <= next_state;
    end

       always@(posedge clk) begin
        if(up && !up_debounce) begin
            up_debounce <= 1;
            case(cur_state)
                S1 : begin
                    if(sec_1 == 9) begin
                        sec_1 <= 0;
                        sec   <= sec - 9;
                    end
                    else begin
                        sec_1 <= sec_1 + 1;
                        sec   <= sec + 1;
                    end
                end
                S2 : begin
                    if(sec_10 == 5) begin
                        sec_10 <= 0;
                        sec    <= sec - 50;
                    end
                    else begin
                        sec_10 <= sec_10 + 1;
                        sec    <= sec + 10;
                    end
                end 
                S3 : begin
                    if(min_1 == 9) begin
                        min_1 <= 0;
                        min   <= min - 9;
                    end
                    else begin
                        min_1 <= min_1 + 1;
                        min   <= min + 1;
                    end
                end
                S4 : begin
                    if(min_10 == 5) begin
                        min_10 <= 0;
                        min    <= min - 50;
                    end
                    else begin
                        min_10 <= min_10 + 1;
                        min    <= min + 10;
                    end
                end
                S5 : begin
                    if(hr_1 == 9) begin
                        hr_1 <= 0;
                        hour <= hour - 9;
                    end
                    else begin
                        hr_1 <= hr_1 + 1;
                        hour <= hour + 1;
                    end
                end
                S6 : begin
                    if(hr_10 == 9) begin
                        hr_10 <= 0;
                        hour  <= hour -90;
                    end
                    else begin
                        hr_10 <= hr_10 + 1;
                        hour  <= hour + 10;
                    end
                end
            endcase
        end
        else if(!up && up_debounce) begin
            up_debounce <= 0;
        end
    end

    always@(posedge clk) begin
        if(down && !down_debounce) begin
            down_debounce <= 1;
            case(cur_state)
                S1 : begin
                    if(sec_1 == 0)
                        sec_1 <= 9;
                    else
                        sec_1 <= sec_1 - 1;
                end
                S2 : begin
                    if(sec_10 == 0)
                        sec_10 <= 5;
                    else
                        sec_10 <= sec_10 - 1;
                end 
                S3 : begin
                    if(min_1 == 0)
                        min_1 <= 9;
                    else
                        min_1 <= min_1 - 1;
                end
                S4 : begin
                    if(min_10 == 0)
                        min_10 <= 5;
                    else
                        min_10 <= min_10 - 1;
                end
                S5 : begin
                    if(hr_1 == 0)
                        hr_1 <= 9;
                    else
                        hr_1 <= hr_1 - 1;
                end
                S6 : begin
                    if(hr_1 == 0)
                        sec_1 <= 9;
                    else
                        sec_1 <= sec_1 - 1;
                end
            endcase
        end
        else if(!down && down_debounce) begin
            down_debounce <= 0;
        end
    end

    always@(posedge clk) begin
        if(left && !left_debounce) begin
            left_debounce <= 1;
            case(cur_state)
                S6 :
                    next_state <= S1;
                default :
                    next_state <= cur_state + 1;
            endcase
        end
        else if(!left && left_debounce) begin
            left_debounce <= 0;
        end
    end

    always@(posedge clk) begin
        if(right && !right_debounce) begin
            right_debounce <= 1;
            case(cur_state)
                S1 :
                    next_state <= S6;
                default :
                    next_state <= cur_state - 1;
            endcase
        end
        else if(!right && right_debounce) begin
            right_debounce <= 0;
        end
    end


endmodule