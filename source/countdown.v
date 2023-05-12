module countdown(clk,sec_clk,up,down,left,right,start,reset,hr_10,hr_1,min_10,min_1,sec_10,sec_1,
hr_2_10,hr_2_1,min_2_10,min_2_1,sec_2_10,sec_2_1)

    input clk,sec_clk,up,down,left,right,start,reset;
    input [3:0]hr_10,hr_1,min_10,min_1,sec_10,sec_1;
    output reg[3:0]hr_2_10,hr_2_1,min_2_10,min_2_1,sec_2_10,sec_2_1;

    reg [31:0]min_counter=0;
    reg [5:0]min_count=0,hr_count=0;
    reg hr_clk=0,min_clk=0;
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
            if(min_count > 59) begin
                min_count <= 0;
                min_clk <= ~min_clk;
                hr_count <= hr_count + 1;
            end
        end
        else begin
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
        else begin
            hr_clk <= 0;
        end
    end

endmodule