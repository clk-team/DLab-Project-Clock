`timescale 1ns / 1ps

module words_countdowm(last,clk,clk_o,tmp,tmp1,state,go,finish);
    
    input clk,clk_o;
    input [31:0]tmp1;
    input finish;
    input go;
    output reg[3:0]last;
    input [31:0]tmp;
    input [3:0]state;
  
    reg [3:0]se[0:7];
    reg [3:0]counter=0;
    reg [7:0]pwm = 0;
    wire sec_clk;
    
    timeset_sec t1(clk_o,sec_clk,100);
    
    always@(posedge clk) begin
        se[7] <= (!finish) ? ((!go) ? ((state != 6) ? tmp1[31:28] : ((pwm <= 50) ? tmp1[31:28] : 4'hf)) : tmp[31:28]) : ((pwm <= 50) ? 4'hf : tmp[31:28]);   
        se[6] <= (!finish) ? ((!go) ? ((state != 5) ? tmp1[27:24] : ((pwm <= 50) ? tmp1[27:24] : 4'hf)) : tmp[27:24]) : ((pwm <= 50) ? 4'hf : tmp[27:24]);
        se[5] <= 4'hb;
        se[4] <= (!finish) ? ((!go) ? ((state != 4) ? tmp1[19:16] : ((pwm <= 50) ? tmp1[19:16] : 4'hf)) : tmp[19:16]) : ((pwm <= 50) ? 4'hf : tmp[19:16]);
        se[3] <= (!finish) ? ((!go) ? ((state != 3) ? tmp1[15:12] : ((pwm <= 50) ? tmp1[15:12] : 4'hf)) : tmp[15:12]) : ((pwm <= 50) ? 4'hf : tmp[15:12]);
        se[2] <= 4'hb;
        se[1] <= (!finish) ? ((!go) ? ((state != 2) ? tmp1[7:4]   : ((pwm <= 50) ? tmp1[7:4]   : 4'hf)) : tmp[7:4])   : ((pwm <= 50) ? 4'hf : tmp[7:4]);
        se[0] <= (!finish) ? ((!go) ? ((state != 1) ? tmp1[3:0]   : ((pwm <= 50) ? tmp1[3:0]   : 4'hf)) : tmp[3:0])   : ((pwm <= 50) ? 4'hf : tmp[3:0]);
    end
        
    always@(posedge sec_clk) begin
        if(pwm >=100)
            pwm <= 0;
        else
            pwm <= pwm + 1;
    end    
        
   always@(posedge clk) begin
        if(counter >= 7)
            counter <= 0;
        else
            counter <= counter + 1;
        end
   always@(counter) begin
       last <= se[counter]; 
   end
    
endmodule
