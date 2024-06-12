//+------------------------------------------------------------------+
//|                                           UIButtonCollection.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "UIWindow.mq5";
#include "UILabel.mq5";
#include "Button/BuyButton.mq5";
#include "Button/SellButton.mq5";

class UIElements{
   public:
      UIWindow win;
      
      UILabel lbl_rsi;
      UILabel lbl_sl;
      UILabel lbl_sl_value;

      BuyButton btn_buy;
      SellButton btn_sell;
      
      void Init(){
         win.Init("Win",200,30,190,200);
         lbl_rsi.Init("lbl_rsi",70,40,15);
         lbl_sl.Init("lbl_SL",190,70);
         lbl_sl_value.Init("lbl_SL_value",140,70);
         btn_buy.Init("btn_buy","Buy",190,100,75,30);
         btn_sell.Init("btn_sell","Sell",90,100,75,30);
      }
      
      void DeInit(){
         win.DeInit();
         lbl_rsi.DeInit();
         lbl_sl.DeInit();
         lbl_sl_value.DeInit();
         btn_buy.DeInit();
         btn_sell.DeInit();
      }
};
