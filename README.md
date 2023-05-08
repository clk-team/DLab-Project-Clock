# DLab-Project-Clock

## 基本架構

![clk](https://user-images.githubusercontent.com/130990374/236692992-d3ca25b6-dc13-4971-ac23-f3fa7f4eb61b.svg)

# 完成清單
- [ ] 時間資訊
- [ ] 時間模式選擇
- [ ] 溫度
- [ ] 顯示模式
- [ ] 鬧鐘
- [ ] 碼表
- [ ] 倒計時
- [ ] Mode選擇器

預計接口
    input clk;
    input up;
    input down;
    input left;
    input right;
    output seg[7:0];  //七段顯示器
    output show[7:0];  //七段顯示器的電晶體
    output sound; //聲音

    
