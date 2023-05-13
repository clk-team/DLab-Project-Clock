

module stopwatch(clk,sec_clk,milli_clk,start,reset,min_10,min_1,sec_10,sec_1,milli_10,milli_1,
min_2_10,min_2_1,sec_2_10,sec_2_1,milli_2_10,milli_2_1);

    input clk,start,reset,sec_clk,milli_clk;
    input [3:0] min_10,min_1,sec_10,sec_1,milli_10,milli_1;
    output reg[3:0] min_2_10,min_2_1,sec_2_10,sec_2_1,milli_2_10,milli_2_1;
    
    reg [31:0]min_counter=0,sec_counter=0,milli_counter=0;
    reg [5:0]count=0;
    reg min_clk=0;
    reg debounce=0;
    reg go=0;
    
    
    always@(posedge clk) begin
        if(start && !debounce) begin
            debounce <= 1;
            go <= ~go;
        end
        else if(!start && debounce) begin
            debounce <= 0;
        end
    end
    
    
    // always@(posedge clk) begin
    //     if(go) begin
    //         if(sec_counter > 49_999_999) begin
    //             sec_counter <= 0;
    //             sec_clk <= ~sec_clk;
    //         end
    //         else begin
    //             sec_counter <= sec_counter + 1;
    //         end
    //     end
    //     else begin
    //         sec_counter <= 0;
    //         sec_clk <= 0;
    //     end
    // end
    
    // always@(posedge clk) begin
    //     if(go) begin
    //         if(milli_counter > 49_999) begin
    //             milli_counter <= 0;
    //             milli_clk <= ~milli_clk;
    //         end
    //         else begin
    //             milli_counter <= milli_counter + 1;
    //         end
    //     end
    //     else begin
    //         milli_counter <= 0;
    //         milli_clk <= 0;
    //     end
    // end
    
    always@(posedge clk) begin
        if(go) begin
            if(min_counter > 49_999_999) begin
                count <= count + 1;
                min_counter <= 0;
            end
            else
                min_counter <= min_counter + 1;
        end
        else begin
            min_counter <= 0;
            count <= 0;
        end
    end
    
    always@(posedge clk) begin
        if(go) begin
            if(count > 59) begin
                count <= 0;
                min_clk <= ~min_clk;
            end
        end
        else begin
            min_clk <= 0;
        end
    end
                   
    always@(posedge milli_clk or negedge milli_clk) begin
        if(go) begin
            milli_2_1 <= milli_1 + 1;
            milli_2_10 <= milli_10;
        end
        else if(reset) begin
            milli_2_1 <= 0;
            milli_2_10 <= 0;
        end
    end
    
    always@(posedge clk) begin
        if(go) begin
            if(milli_2_1 > 9) begin
                milli_2_1 <= 0;
                milli_2_10 <= milli_2_10 + 1;
            end
            if(milli_2_10 > 9)
                milli_2_10 <= 0;
        end
    end
    
    always@(posedge sec_clk or negedge sec_clk) begin
        if(go) begin
            sec_2_1 <= sec_1 + 1;
            sec_2_10 <= sec_10;
        end
        else if(reset) begin
            sec_2_1 <= 0;
            sec_2_10 <= 0;
        end
    end
     
     always@(posedge clk) begin
     if(go) begin
        if(sec_2_1 > 9) begin
            sec_2_1 <= 0;
            sec_2_10 <= sec_2_10 + 1;
        end
        if(sec_2_10 > 5)
            sec_2_10 <= 0;
     end
     end
     
     always@(posedge min_clk or negedge min_clk) begin
        if(go) begin
            min_2_1 <= min_1 + 1;
            min_2_10 <= min_10;
        end
        else if(reset) begin
            min_2_1 <= 0;
            min_2_10 <= 0;
        end
    end
     
     always@(posedge clk) begin
     if(go) begin
        if(min_2_1 > 9) begin
            min_2_1 <= 0;
            min_2_10 <= min_2_10 + 1;
        end
        if(min_2_10 > 5)
            min_2_10 <= 0;
    end
    end
endmodule