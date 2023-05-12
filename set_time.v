`timescale 1ns/1ps

module set_time (clk, button_mid, button_r, button_l, button_up, button_down, year, month, day, hour, minute, sec, week,mode);

input clk;
input button_mid;
input button_l;
input button_r;
input button_down;
input button_up;
input [3:0]mode;

output reg[15:0]year = 16'h2023;
output reg[7:0]month = 8'h1;
output reg[7:0]day = 8'h1;
output reg[7:0]hour = 0;
output reg[7:0]minute = 0;
output reg[7:0]sec = 0;
output reg [3:0]week = 0;

reg start_set = 0;
reg [83:0] set_string;
reg[4:0] count = 20;
reg[31:0] timer;
reg[31:0] timer2;

reg [3:0]year_th = 2;
reg [3:0]year_h = 0;
reg [3:0]year_t = 2;
reg [3:0]year_u = 3;

reg [3:0]month_t = 0;
reg [3:0]month_u = 1;

reg [3:0]day_t = 0;
reg [3:0]day_u = 1;

reg [3:0]hour_t = 0;
reg [3:0]hour_u = 0;

reg [3:0]min_t = 0;
reg [3:0]min_u = 0;

reg [3:0]sec_t = 0;
reg [3:0]sec_u = 0;

reg [14:0]year_d;
reg [3:0]month_d;
reg [4:0]day_d;
reg [5:0]hour_d;
reg [5:0]min_d;
reg [5:0]sec_d;

reg [14:0]year_f;
reg [3:0]month_f;


always @(*) begin
    
   set_string <= {year , 4'd10 , month , 4'd10 , day , 4'd10 , week , 4'd10 , hour , 4'd10 , minute , 4'd10 , sec};
 
end


always @(*) begin
    year <= {year_th , year_h , year_t , year_u};
    month <= {month_t , month_u};
    day <= {day_t , day_u};
    hour <= {hour_t , hour_u};
    minute <= {min_t , min_u};
    sec <= {sec_t , sec_u};

    year_d <= year_th*1000 + year_h*100 + year_t*10 + year_u;
    month_d <= month_t*10 + month_u;
    day_d <= day_t*10 + day_u;
    hour_d <= hour_t*10 + hour_u;
    min_d <= min_t*10 + min_u;
    sec_d <= sec_t*10 + sec_u;


    if(month_d == 1 || month_d == 2)begin
        month_f <= month_d + 12;
        year_f <= year_d - 1;
        
    end
    
    else begin
        month_f <= month_d ;
        year_f <= year_d ;
        
    end

    week = (day_d + 2*month_f + 3*(month_f + 1)/5 + year_f + year_f / 4 - year_f / 100 + year_f / 400 + 1) % 7;
   
end


always @(mode) begin
    if(mode == 0)
        start_set <= 1;
    
    else
        start_set <= 0;
end

always @(posedge clk) begin
    if(start_set == 1)begin

    if(button_l == 1 || button_r == 1)
        timer <= timer + 1;
        else
            timer <= 0;

    if(timer == 3)begin    //2500000
        if(button_l == 1) begin

            if(count >= 20)
                count <= 0;
            else if(count == 1)
                count <= 3;
            else if(count == 4 )
                count <= 6;
            else if(count == 7)
                count <= 9;
            else if(count == 9)
                count <= 11;
            else if(count == 12)
                count <= 14;
            else if(count == 15)
                count <= 17;
            else
                count <= count + 1;

            // if(count == 4 || count == 7 || count == 10 || count == 12 || count == 15 || count == 18) //2 5 8 10 13 16
            //     count <= count + 1;

        end
        else if(button_r == 1)begin

            if(count <= 0)
                count <= 20;
            else if(count == 3)
                count <= 1;
            else if(count == 6 )
                count <= 4;
            else if(count == 9)
                count <= 7;
            else if(count == 11)
                count <= 9;
            else if(count == 14)
                count <= 12;
            else if(count == 17)
                count <= 15;
            else
                count <= count - 1;

            // if(count == 4 || count == 7 || count == 10 || count == 12 || count == 15 || count == 18) //4 7 10 12 15 18
            //     count <= count - 1;
        end
    
    end
    end
end

always @(posedge clk or posedge start_set) begin

    if(button_up == 1 || button_down == 1)
        timer2 <= timer2 + 1;
        else
            timer2 <= 0;

    if(timer2 == 3)begin //2500000
        if(button_up == 1) begin //2 5 8 10 13 16

            case (count)
            /*year*/
            20: 
                begin
                    if(year_th >= 9)
                        year_th <= 0;
                    else
                        year_th <= year_th + 1; 
                end

            19:
                begin
                    if(year_h >= 9)
                        year_h <= 0;
                    else
                        year_h <= year_h + 1; 
                end

            18:
                begin
                    if(year_t >= 9)
                        year_t <= 0;
                    else
                        year_t <= year_t + 1; 
                end

            17:
                begin
                    if(year_u >= 9)
                        year_u <= 0;
                    else
                        year_u <= year_u + 1; 
                end

            /*month*/
            15:
                begin
                    if(month_t >= 1)
                        month_t <= 0;
                    else
                        month_t <= month_t + 1; 
                end

            14:
                begin
                    if(month_t != 1)begin
                        if(month_u >= 9)
                        month_u <= 1;
                    else
                        month_u <= month_u + 1; 
                    end

                    else begin
                        if(month_u >= 2)
                            month_u <= 0;
                        else
                            month_u <= month_u + 1; 
                    end
                    
                        
                end

                    

            /*day*/
            12:
                begin
                    if(month_d != 2)begin
                        if(day_t >= 3)
                        day_t <= 0;
                    else
                        day_t <=day_t + 1; 
                    end

                    else begin
                        if(day_t >= 2)
                            day_t <= 0;
                        else
                            day_t <=day_t + 1; 
                    end
                    
                end

            11:
                begin
                    if(month_d == 2)begin // Feb
                        if(day_t == 2)begin
                            if(year_d % 400 == 0 || (year_d % 4 == 0 && year_d%100!=0))begin // 閏年
                                if(day_u >= 9)
                                    day_u <= 0;  
                                else
                                    day_u <= day_u + 1;   
                            end

                            else begin
                                if(day_u >= 8)
                                    day_u <= 0;  
                                else
                                    day_u <= day_u + 1;
                            end
                        end

                    end

                    else if(month_d == 1 || month_d == 3 || month_d == 5 || month_d == 7 || month_d == 8 || month_d == 10 || month_d == 12 )begin //months that have 31 days
                        if(day_t == 3)begin
                            if(day_u >= 1)
                                day_u <= 0;
                            else
                                day_u <= day_u + 1;
                        end

                        else begin
                            if(day_u >= 9)
                                day_u <= 0;
                            else
                                day_u <=day_u + 1;     
                        end

                    end

                    else begin // 30 days
                        if(day_t == 3)begin
                            day_u <= 0;
                        end

                        else begin
                            if(day_u >= 9)
                                day_u <= 0;
                            else
                                day_u <=day_u + 1;     
                        end
                    end
                    
                end

            /*hour*/
            7:
                begin
                    if(hour_t >= 2)
                        hour_t <= 0;
                    else
                        hour_t <=hour_t + 1; 
                end

            6:
                begin
                    if(hour_u >= 9)
                        hour_u <= 0;
                    else
                        hour_u <=hour_u + 1; 
                end

            /*minute*/
            4:
                begin
                    if(min_t >= 5)
                        min_t <= 0;
                    else
                        min_t <=min_t + 1; 
                end

            3:
                begin
                    if(min_u >= 9)
                        min_u <= 0;
                    else
                        min_u <=min_u + 1; 
                end

            /*sec*/
            1:
                begin
                    if(sec_t >= 5)
                        sec_t <= 0;
                    else
                        sec_t <=sec_t + 1; 
                end
            0:
                begin
                    if(sec_u >= 9)
                        sec_u <= 0;
                    else
                        sec_u <= sec_u + 1; 
                end
                
            endcase
                
            

        end
        else if(button_down == 1)begin

            case (count)
            /*year*/
            20: 
                begin
                    if(year_th <= 0)
                        year_th <= 9;
                    else
                        year_th <= year_th - 1; 
                end

            19:
                begin
                    if(year_h <= 0)
                        year_h <= 9;
                    else
                        year_h <= year_h - 1; 
                end

            18:
                begin
                    if(year_t <= 0)
                        year_t <= 9;
                    else
                        year_t <= year_t - 1; 
                end

            17:
                begin
                    if(year_u <= 0)
                        year_u <= 9;
                    else
                        year_u <= year_u - 1; 
                end

            /*month*/
            15:
                begin
                    if(month_t <= 0)
                        month_t <= 1;
                    else
                        month_t <= month_t - 1; 
                end

            14:
                begin
                    if(month_t != 1)begin
                        if(month_u <= 1)
                        month_u <= 9;
                    else
                        month_u <= month_u - 1; 
                    end

                    else begin
                        if(month_u <= 0)
                            month_u <= 2;
                        else
                            month_u <= month_u - 1; 
                    end 
                end

            /*day*/
            12:
                begin
                     if(month_d != 2)begin
                        if(day_t <= 0)
                        day_t <= 3;
                    else
                        day_t <=day_t - 1; 
                    end

                    else begin
                        if(day_t <= 0)
                            day_t <= 2;
                        else
                            day_t <=day_t - 1; 
                    end 
                end

            11:
                begin
                    if(month_d == 2)begin // Feb
                        if(day_t == 2)begin
                            if(year_d % 400 == 0 || (year_d % 4 == 0 && year_d%100!=0))begin // 閏年
                                if(day_u <= 0)
                                    day_u <= 9;  
                                else
                                    day_u <= day_u - 1;   
                            end

                            else begin
                                if(day_u <= 0)
                                    day_u <= 8;  
                                else
                                    day_u <= day_u - 1;
                            end
                        end
                        else begin
                            if(day_t == 0)begin
                                if(day_u <= 1)
                                    day_u <= 9;
                                else
                                    day_u <= day_u - 1; 
                            end

                            else begin
                                if(day_u <= 0)
                                    day_u <= 9;
                                else
                                    day_u <= day_u - 1;
                            end
                        end

                    end

                    else if(month_d == 1 || month_d == 3 || month_d == 5 || month_d == 7 || month_d == 8 || month_d == 10 || month_d == 12 )begin //months that have 31 days
                        if(day_t == 3)begin
                            if(day_u <= 0)
                                day_u <= 1;
                            else
                                day_u <= day_u - 1;
                        end

                        else begin
                            if(day_t == 0)begin
                                if(day_u <= 1)
                                    day_u <= 9;
                                else
                                    day_u <=day_u - 1;
                            end

                            else begin
                                if(day_u <= 0)
                                    day_u <= 9;
                                else
                                    day_u <=day_u - 1;
                            end
                                 
                        end

                    end

                    else begin // 30 days
                        if(day_t == 3)begin
                            day_u <= 0;
                        end

                        else begin
                            if(day_t == 0)begin
                                if(day_u <= 1)
                                    day_u <= 9;
                                else
                                    day_u <=day_u - 1;
                            end

                            else begin
                                if(day_u <= 0)
                                    day_u <= 9;
                                else
                                    day_u <=day_u - 1;
                            end
                                 
                        end
                    end
                end

            /*hour*/
            7:
                begin
                    if(hour_t <= 0)
                        hour_t <= 5;
                    else
                        hour_t <=hour_t - 1; 
                end

            6:
                begin
                    if(hour_u <= 0)
                        hour_u <= 9;
                    else
                        hour_u <=hour_u - 1; 
                end

            /*minute*/
            4:
                begin
                    if(min_t <= 0)
                        min_t <= 5;
                    else
                        min_t <=min_t - 1; 
                end

            3:
                begin
                    if(min_u <= 0)
                        min_u <= 9;
                    else
                        min_u <=min_u - 1; 
                end

            /*sec*/
            1:
                begin
                    if(sec_t <= 0)
                        sec_t <= 5;
                    else
                        sec_t <=sec_t - 1; 
                end
            0:
                begin
                    if(sec_u <= 0)
                        sec_u <= 9;
                    else
                        sec_u <= sec_u - 1; 
                end
                
            endcase
        end
    
    end
end




endmodule //set_time