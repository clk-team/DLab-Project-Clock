`timescale 1ns / 1ps

module mode_selection(clk,up,down,rel,modify);

        input clk;
        input up,down,modify;
        output reg [3:0]rel=1;
        
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
                 
       always@(posedge modify) begin //當中間按下時切換至mode 0,並在下次按時再切回cur_state_1
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
                    if(cur_state_1 != S7) begin //透過先前記下的cur_state_1來改變(排除mode 0情況)
                        debounce <= 1;
                        rel <= cur_state_1 + 1;
                    end
                    else begin
                        debounce <= 1;
                        rel <= S1;
                    end
                end
           endcase
           end
           else if(down && !debounce) begin //透過先前記下的cur_state_1來改變(排除mode 0情況)
           case(cur_state)
                IDLE: begin
                    if(cur_state_1 != S1) begin
                        debounce <= 1;
                        rel <= cur_state_1 - 1;
                    end
                    else begin
                        debounce <= 1;
                        rel <= S7;
                    end
                end
           endcase
           end
           else if(!up && !down)begin //沒輸入時IDLE,將這時的輸入記下，以便下次up or down更改時利用
               cur_state <= IDLE;
               cur_state_1 <= rel;
           end
       end
                
endmodule
