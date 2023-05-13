`timescale 1ns/1ps

module selectstring (string, clk, reset, sel, tmp1, clk_o);
    
    output  reg[31:0]string;
    
    input clk_o;
    input clk;
    input reset;
    input sel;
  
    input [79:0] tmp1;
    
    reg [7:0]counter1 = 159;
    reg [7:0]counter2 = 128;
    reg [239:0] tmp;

    
    always @(posedge clk or posedge reset) begin
        if(reset == 1)
            counter1 <= counter1;
        else if (reset == 0) begin
            if(sel == 1)begin
            if(counter1 > 83)begin
            counter1 <= counter1 - 4;

        end
        else
            counter1 <= 159;
        end
        
        else begin
            if(counter1 < 187)begin
                counter1 <= counter1 + 4;
            end
            else
                counter1 <= 111;
        end
        end
        

    end

    always @(posedge clk or  posedge reset) begin
        
        if(reset == 1)
            counter2 <= counter2;

        else if (reset == 0) begin
           if (sel == 1) begin
            if(counter2 > 52)begin
            counter2 <= counter2 - 4;

        end
        else
            counter2 <= 128;
        end
        
        else begin
            if(counter2 < 156)begin
                counter2 <= counter2 +4;
            end
            else
                counter2 <= 80;
        end 
        end
      
    end

    always @(*) begin
        tmp = {tmp1,tmp1,tmp1};
    end

    always @(posedge clk or  posedge reset) begin
       
        if(reset == 1)begin
            if(sel == 1)
                string <= { tmp[counter1-:32]};
            else
                string <= { tmp[counter2+:32]};
        end
            
        else if(sel) //left
        begin
                      
            string <= { tmp[counter1-:32]};
                      
        end
        else if(sel == 0) //right
            begin
                            
                string <= { tmp[counter1-:32]};
                       
           
          end
    end
    

endmodule