module freq_div_q(clk, clk_1, quick);  //clk嚗撓??????   clk_1: 頛詨????
    input clk;
    input [25:0]fre;
    input quick;

    output clk_1;
    reg[26:0] counter=0;  //摰儔閮?,??閮?????25000000嚗?閬25雿??嚗?
    reg clk_1=0;
    always@(posedge clk)begin
    if(quick)begin
        if(counter == 49999999 / 1000) //憒??49999999
                begin
                    counter <= 0;     //??ounter?敺拇??0
                    clk_1 <= ~clk_1;      //??lk_1蝧餉??
                end
            else
                counter <= counter + 1'b1; //counter 蝜潛??
    end
    else begin
        if(counter == 49999999) //憒??49999999
                begin
                    counter <= 0;     //??ounter?敺拇??0
                    clk_1 <= ~clk_1;      //??lk_1蝧餉??
                end
            else
                counter <= counter + 1'b1; //counter 蝜潛??
    end
            

	end
endmodule