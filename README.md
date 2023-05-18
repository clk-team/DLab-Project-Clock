# DLab-Project-Clock
本時鐘包含基本的時間顯示，還包刮以下項目：

1.調整時間  
2.分別顯示想觀看的資訊(如：年、月、日)  
3.溫度顯示功能  
4.鬧鐘  
5.碼表  
6.倒計時

其中***顯示時間與調整時間***的功能考慮儒略曆、格里曆，因此星期會自動調校




## 基本架構

![clk](picture/clk_update1.svg)

# 完成清單
- [x] 時間資訊
- [ ] 時間模式選擇
- [x] 溫度
- [x] 顯示模式
- [ ] 鬧鐘
- [ ] 碼表
- [ ] 倒計時
- [x] Mode選擇器  
- [x] 設定時間    

 # 測試包
 [Test Bag Link](https://drive.google.com/drive/folders/1XAJbarrVKNm8lw3I7C5_5kuRl_Auur8x?usp=share_link)
# Module port

**For example**
```verilog
module(clk, up, down, left, right, seg, show, sound)
    input clk;
    input up;
    input down;
    input left;
    input right;
    output seg[7:0];  //七段顯示器
    output show[7:0];  //七段顯示器的電晶體
    output sound; //聲音
```
**set_time(晚點添加輸出時間)**

```verilog
module set_time (clk, button_mid, button_r, button_l, button_up, button_down,  mode, set_string, count); //調整時間模塊

input clk;
input button_mid; //中間按鈕
input button_l;   //左邊按鈕
input button_r;   //右邊按鈕
input button_down;//下按鈕
input button_up;  //上按鈕
input [3:0]mode;  //模式輸入

output reg [83:0] set_string; //輸出調整過後時間訊息
output reg[4:0] count = 20;   //選擇第幾個要更改的參數
```
```verilog
module display (clk, chs,oout, sel, button_mid, button_r, button_l, button_up, button_down, mode); //顯示模塊

output [7:0]chs ; //選擇7段顯示要哪個亮
output [7:0]oout; //輸出decoder輸出的字形

input clk;
input button_mid;
input button_l;
input button_r;
input button_down;
input button_up;
input [3:0]mode;
```   
