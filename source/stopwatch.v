`timescale 1ns / 1ps

module stopwatch(clk,start,reset,quick,min_10,min_1,sec_10,sec_1,milli_10,milli_1);

    input clk,start,reset,quick;
    output reg[3:0] min_10,min_1,sec_10,sec_1,milli_10,milli_1;
    
    reg [31:0]counter=0;
    reg [5:0]count=0;
    reg min_clk=0;
    reg debounce=0;
    reg go=0;
    reg millic=0,sc=0,mc=0;
    reg [5:0] sec=0;
    reg [5:0] min=0;
    reg [5:0] milli=0;
    reg milli_clk=0;
    integer i;
    
    always@(posedge clk) begin
        if(reset) begin
            min   <= 0;
            sec   <= 0;
            milli <= 0;
            go    <= 0;
        end
    end
    
     always@(posedge clk) begin
        if(go==0)    begin
            counter <= counter;
        end
        else if(go==1)   begin
            if(quick==0)  begin
                if(counter == 49999) begin //slow counting
                    counter <= 0;
                    milli_clk <= ~ milli_clk;
                end
                else
                    counter <= counter + 1'b1;
            end
            else begin
                if(counter == 1) begin //fast counting
                    counter <= 0;
                    milli_clk <= ~milli_clk;
                end
                else
                    counter <= counter + 1'b1;
            end
        end
    end      
        
    
    always@(posedge clk) begin
        if(start && !debounce) begin
            debounce <= 1;
            go <= ~go;
        end
        else if(!start && debounce) begin
            debounce <= 0;
        end
    end
    
    always@(posedge milli_clk) begin
        if(milli > 59) begin
            milli <= 0;
            millic <= 1;
        end
        else  begin
            milli <= milli + 1;
            millic <= 0;
        end
    end
    
    always @(posedge millic) begin
        if(sec > 59) begin
            sec <= 0;
            sc <= 1;
        end
        else begin
            sec <= sec + 1;
            sc <= 0;
        end
    end
    
    always @(posedge sc) begin
            min <= min + 1;
    end
    
    always@(milli) begin
        milli_1  = 4'd0;
        milli_10 = 4'd0;
    
    for(i = 5 ; i >= 0 ; i = i - 1) begin
    
        if(milli_1 >= 5)
           milli_1 = milli_1 + 3;
        if(milli_10 >= 5)
            milli_10 = milli_10 +3;
            
        milli_10 = milli_10 << 1;
        milli_10[0] = milli_1[3];
        
        milli_1 = milli_1 << 1;
        milli_1[0] = milli[i];
    end
    end
    
    always@(sec) begin
        sec_1  = 4'd0;
        sec_10 = 4'd0;
    
    for(i = 5 ; i >= 0 ; i = i - 1) begin
    
        if(sec_1 >= 5)
           sec_1 = sec_1 + 3;
        if(sec_10 >= 5)
            sec_10 = sec_10 +3;
            
        sec_10 = sec_10 << 1;
        sec_10[0] = sec_1[3];
        
        sec_1 = sec_1 << 1;
        sec_1[0] = sec[i];
    end
    end
    
    always@(min) begin
        min_1  = 4'd0;
        min_10 = 4'd0;
    
    for(i = 5 ; i >= 0 ; i = i - 1) begin
    
        if(min_1 >= 5)
           min_1 = min_1 + 3;
        if(min_10 >= 5)
            min_10 = min_10 +3;
            
        min_10 = min_10 << 1;
        min_10[0] = min_1[3];
        
        min_1 = min_1 << 1;
        min_1[0] = min[i];
    end
    end
    
endmodule