module mode_selection(clk,sel,up,down,rel);

        input clk;
        input [2:0]sel;
        input up,down;
        output reg [2:0]rel;

        parameter IDLE = 0,
                S1   = 1,
                S2   = 2,
                S3   = 3,
                S4   = 4,

        reg [2:0] cur_state,next_state,cur_state_1;
        reg debounce;

        always@(posedge clk) begin
        if(!sel)
                cur_state_1 <= cur_state;
                cur_state   <= IDLE;
        else
                cur_state <= next_state;
        end

        assign rel = cur_state;

        always@(cur_state or up or down) begin
                case(cur_state)
                        IDLE: begin
                                if      (up && !debounce) begin 
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