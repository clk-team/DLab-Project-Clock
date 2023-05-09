`timescale 1ns / 1ps

module mode_selection(clk,sel,up,down,rel);

        input clk;
        input [2:0]sel;
        input up,down;
        output reg [2:0]rel;
        
        parameter IDLE = 0,
                S1   = 1,
                S2   = 2,
                S3   = 3,
                S4   = 4;
                
        reg [2:0] cur_state; 
        reg [2:0] next_state,cur_state_1;
        reg debounce;
        initial begin
             cur_state <= sel;
             next_state <= IDLE;
        end
      
        
        always@(posedge clk) begin
            if(!up && !down) 
                cur_state <= IDLE;
        end
        
        always@(posedge clk) begin
            if(!debounce)
                cur_state_1 <= sel;
            cur_state <= next_state;
            end
        always@(posedge debounce) begin
            cur_state <= cur_state_1;
        end    
         
        always@(posedge clk) begin
        if(cur_state && !debounce)
            rel <= cur_state;
        else
            rel <= cur_state_1;
        end
        always@(cur_state or up or down) begin
                case(cur_state)
                        IDLE: begin
                             if   (up && !debounce) begin
                                            next_state <= cur_state_1 + 1;
                                            debounce   <= 1;
                                    end
                                    else if (down && !debounce) begin
                                            next_state <= cur_state_1 - 1;
                                            debounce   <= 1;
                                    end
                                    else begin
                                            next_state <= cur_state_1;
                                            debounce <= 0;
                                    end
                            end
                        
                        S1: begin
                                if      (up && !debounce) begin
                                        next_state <= S2;
                                        debounce   <= 1;
                                end
                                else if (down && !debounce) begin
                                        next_state <= S4;
                                        debounce   <= 1;
                                end
                                else begin
                                        next_state <= S1;
                                        debounce <= 0;
                                end
                        end
                        S2: begin
                                if      (up && !debounce) begin
                                        next_state <= S3;
                                        debounce   <= 1;
                                end
                                else if (down && !debounce) begin
                                        next_state <= S1;
                                        debounce   <= 1;
                                end
                                else begin
                                        next_state <= S2;
                                        debounce   <= 0;
                                end
                        end
                        S3: begin
                                if    (up && !debounce) begin
                                        next_state <= S4;
                                        debounce   <= 1;
                                end
                                else if (down && !debounce) begin
                                        next_state <= S2;
                                        debounce   <= 1;
                                end
                                else begin
                                        next_state <= S3;
                                        debounce   <= 0;
                                end
                        end
                        S4: begin
                                if      (up && !debounce) begin
                                        next_state <= S1;
                                        debounce   <= 1;
                                end
                                else if (down && !debounce) begin
                                        next_state <= S3;
                                        debounce   <= 1;
                                end
                                else begin
                                        next_state <= S4;
                                        debounce   <= 0;
                                end
                        end
                endcase
        end
        
      
endmodule
