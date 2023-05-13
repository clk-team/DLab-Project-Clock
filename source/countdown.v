`timescale 1ns / 1ps

module countdown(clk,sec_clk,up,down,left,right,start,reset,modify,hr_10,hr_1,min_10,min_1,sec_10,sec_1,
hr_2_10,hr_2_1,min_2_10,min_2_1,sec_2_10,sec_2_1);

    input clk,sec_clk,up,down,left,right,start,reset,modify;
    input [3:0]hr_10,hr_1,min_10,min_1,sec_10,sec_1;
    output reg[3:0]hr_2_10,hr_2_1,min_2_10,min_2_1,sec_2_10,sec_2_1;

    parameter S0 = 0, 
              S1 = 1,
              S2 = 2,
              S3 = 3,
              S4 = 4,
              S5 = 5,
              S6 = 6, 
              S7 = 7; // end countdown

    reg [31:0]min_counter=0;
    reg [5:0]min_count=0,hr_count=0;
    reg hr_clk=0,min_clk=0;
    reg debounce=0,up_debounce=0,down_debounce=0,modi_debounce=0,left_debounce=0,right_debounce=0;
    reg go=0,modi_go=0;
    reg [2:0]cur_state=S0,next_state=S0;

    
    always@(posedge clk) begin
        if(cur_state == S0) begin
            if(start && !debounce) begin
                debounce <= 1;
                go <= ~go;
            end
            else if(!start && debounce) begin
                debounce <= 0;
            end
        end
    end


    always@(posedge reset) begin
           hr_2_10  <= 0;
           hr_2_1   <= 0;
           min_2_10 <= 0;
           min_2_1  <= 0;
           sec_2_10 <= 0;
           sec_2_1  <= 0;
    end
//modify setting

    always@(posedge clk) begin
        if(modify && !modi_debounce) begin
            modi_debounce <= 1;
            modi_go <= ~modi_go;
        end
        else if(!modify && modi_debounce) begin
            debounce <= 0;
        end
    end

    always@(posedge clk) begin
        if(modi_go == 1)
            next_state <= S1;
        else
            next_state <= S0;
    end

    always@(posedge clk) begin
        cur_state <= next_state;
    end

       always@(posedge clk) begin
        if(up && !up_debounce && modi_go) begin
            up_debounce <= 1;
            case(cur_state)
                S1 : begin
                    if(sec_1 == 9)
                        sec_2_1 <= 0;
                    else
                        sec_2_1 <= sec_1 + 1;
                end
                S2 : begin
                    if(sec_10 == 5)
                        sec_2_10 <= 0;
                    else
                        sec_2_10 <= sec_10 + 1;
                end 
                S3 : begin
                    if(min_1 == 9)
                        min_2_1 <= 0;
                    else
                        min_2_1 <= min_1 + 1;
                end
                S4 : begin
                    if(min_10 == 5)
                        min_2_10 <= 0;
                    else
                        min_2_10 <= min_10 + 1;
                end
                S5 : begin
                    if(hr_1 == 9)
                        hr_2_1 <= 0;
                    else
                        hr_2_1 <= hr_1 + 1;
                end
                S6 : begin
                    if(hr_1 == 9)
                        sec_2_1 <= 0;
                    else
                        sec_2_1 <= sec_1 + 1;
                end
            endcase
        end
        else if(!up && up_debounce) begin
            up_debounce <= 0;
        end
    end

    always@(posedge clk) begin
        if(down && !down_debounce && modify && modi_go) begin
            down_debounce <= 1;
            case(cur_state)
                S1 : begin
                    if(sec_1 == 0)
                        sec_2_1 <= 9;
                    else
                        sec_2_1 <= sec_1 - 1;
                end
                S2 : begin
                    if(sec_10 == 0)
                        sec_2_10 <= 5;
                    else
                        sec_2_10 <= sec_10 - 1;
                end 
                S3 : begin
                    if(min_1 == 0)
                        min_2_1 <= 9;
                    else
                        min_2_1 <= min_1 - 1;
                end
                S4 : begin
                    if(min_10 == 0)
                        min_2_10 <= 5;
                    else
                        min_2_10 <= min_10 - 1;
                end
                S5 : begin
                    if(hr_1 == 0)
                        hr_2_1 <= 9;
                    else
                        hr_2_1 <= hr_1 - 1;
                end
                S6 : begin
                    if(hr_1 == 0)
                        sec_2_1 <= 9;
                    else
                        sec_2_1 <= sec_1 - 1;
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

// countdown setting
    always@(posedge clk) begin
        if(go) begin
            if(min_counter > 49_999_999) begin
                min_count <= min_count + 1;
                min_counter <= 0;
            end
            else
                min_counter <= min_counter + 1;
        end
        else if(!go && !reset)
            min_counter <= min_counter; 
        else if(reset) begin
            min_counter <= 0;
            min_count <= 0;
        end
    end
    
    always@(posedge clk) begin
        if(go) begin
            if(min_count > 59) begin
                min_count <= 0;
                min_clk <= ~min_clk;
                hr_count <= hr_count + 1;
            end
        end
        else if(reset) begin
            min_clk <= 0;
        end
    end

    always@(posedge clk) begin
        if(go) begin
            if(hr_count > 59) begin
                hr_clk <= ~hr_clk;
                hr_count <= 0;
            end
        end
        else if(!go &&!reset)
            min_counter <= min_counter;
        else if(reset) begin
            hr_clk <= 0;
        end
    end

// start countdown
    always@(posedge sec_clk or negedge sec_clk) begin
        if(go) begin
            sec_2_1 <= sec_1 - 1;
            sec_2_10 <= sec_10;
        end
    end

    always@(posedge min_clk or negedge min_clk) begin
        if(go) begin
            min_2_1 <= min_1 - 1;
            min_2_10 <= min_10;
        end
    end

    always@(posedge hr_clk or negedge hr_clk) begin
        if(go) begin
            min_2_1 <= min_1 - 1;
            min_2_10 <= min_10;
        end
    end

    always@(posedge clk) begin
        if(go) begin
            if(sec_1 == 0) begin
                sec_2_1 <= 9;
                sec_2_10 <= sec_10 - 1;
            end
            if(sec_10 == 0) begin
                sec_2_10 <= 5;
                min_2_1 <= min_1 - 1;
            end
            if(min_1 == 0) begin
                min_2_1 <= 9;
                min_2_10 <= min_10 - 1;
            end
            if(min_10 == 0) begin
                min_2_10 <= 5;
                hr_2_1 <= hr_1 - 1;
            end
            if(hr_1 == 0) begin
                hr_2_1 <= 9;
                hr_2_10 <= hr_10 - 1;
            end
        end
    end
    
    always@(posedge clk) begin
        if(sec_1 == 0 && sec_10 == 0 && min_1 == 0 && min_10 == 0 && hr_1 == 0 &&hr_10 == 0)
            next_state <= S7;
    end

endmodule