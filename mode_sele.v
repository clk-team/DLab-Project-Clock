`timescale 1ns/1ps
module mode_sel (clk, button_l, button_r, button_m, mode);

input clk;
input button_l, button_m, button_r;
input set;

output reg[3:0]mode = 1;

reg [31:0] timer = 0;

reg change = 0;

always @(posedge clk) begin
    
    if(button_l == 1 || button_r == 1 || button_m == 1)
        timer <= timer + 1;
    else begin
        timer <= 0;
        
    end
        

    if(timer == 2500000)begin

        if(mode != 0 && set == 0)begin
            if(button_l == 1)begin
            if(mode <= 1)
                mode <= 7;
            else
                 mode <= mode - 1;
        end

        if(button_r == 1)begin
            if(mode >= 7)
                mode <= 1;
            else
                 mode <= mode + 1;
        end
        end
        
            

    end

    if(timer == 100000000) begin
        if(button_m == 1)begin
            
            if(change == 0)begin
                mode = 0;
                change = ~change;
            end
                
            else begin
                mode = 1;
                change = ~change;
            end
                 
            
        end
    end


end
    
endmodule