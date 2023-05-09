`timescale 1ns / 1ps

module mode_selection(clk,sel,up,down,rel,modify);

        input clk;
        input [3:0]sel;
        input up,down,modify;
        output reg [3:0]rel;
        
        reg [3:0]cur_state,cur_state_1;
        
         
        reg debounce=0,debounce_modi=0;
        parameter IDLE = 8,
                 S0   = 0,
                 S1   = 1,
                 S2   = 2,
                 S3   = 3,
                 S4   = 4,
                 S5   = 5,
                 S6   = 6,
                 S7   = 7;
                 
       always@(posedge modify) begin
           if(!debounce_modi) begin
                rel <= S0;
                debounce_modi <= 1;
           end
           else if(debounce_modi) begin
                rel <= cur_state_1;
                debounce_modi <= 0;
           end
       end
       
       always@(posedge clk) begin
          if(up && !debounce) begin
            case(cur_state)
                IDLE: begin
                    if(cur_state_1 != S7 && !debounce_modi) begin
                        debounce <= 1;
                        rel <= cur_state_1 + 1;
                    end
                    else if(!debounce_modi)begin
                        debounce <= 1;
                        rel <= S1;
                    end
                end
           endcase
           end
           else if(down && !debounce) begin
            case(cur_state)
                IDLE: begin
                    if(cur_state_1 != S1 && !debounce_modi) begin
                        debounce <= 1;
                        rel <= cur_state_1 - 1;
                    end
                    else if(!debounce_modi)begin
                        debounce <= 1;
                        rel <= S7;
                    end
                end
           endcase
           end
           else if(!up && !down && !debounce_modi)begin
               cur_state <= IDLE;
               rel <= sel;
               debounce <= 0;
               cur_state_1 <= sel;
           end
       end
                
endmodule
