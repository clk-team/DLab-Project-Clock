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
- [ ] 時間資訊
- [ ] 時間模式選擇
- [ ] 溫度
- [ ] 顯示模式
- [ ] 鬧鐘
- [ ] 碼表
- [ ] 倒計時
- [x] Mode選擇器  
  

  
 
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


    
