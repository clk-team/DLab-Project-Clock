`timescale 1ns/1ps

module selectstring (string, clk, tmp1, count, mode, count_8);
    
    output  reg[31:0]string;
    input clk;
    input [3:0] mode;
        
    input [4:0]count;
      
    input [83:0] tmp1;
    
    reg [7:0]pointer = 20;
    reg [4:0]edge_f = 20;
    reg [4:0]edge_b = 13;
    
    reg reset = 0;
    output reg [4:0]count_8;

    always @(posedge clk) begin
        if(mode == 0)
            reset <= 0;
        else
            reset <= 1;
    end

    always @(posedge clk ) begin

            if(reset == 1)begin
                edge_f <= 20;
                edge_b <= 13;
            end
                
        
            if(count > edge_f)begin
                edge_f <= count;
                edge_b <= count - 7;
            end
            else if(count < edge_b) begin
                edge_b <= count;
                edge_f <= count + 7; 
            end
            else if(count == 20)begin
                edge_f <= 20;
                edge_b <= 13;
            end
            else if(count == 0)begin
                edge_b <= 0;
                edge_f <= 7;
            end
         
        
        pointer <= edge_f * 4 + 3;
         

    end
    
    always @(posedge clk) begin
        if(count >= edge_b)
            count_8 <= count - edge_b;
    end

    always @(posedge clk) begin      
        
    string <= { tmp1[pointer-:32]};
    
                         
    end
    

endmodule