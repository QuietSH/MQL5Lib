//+------------------------------------------------------------------+
//|                                           UIButtonCollection.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "Button/BuyButton.mq5";

class UIButtonCollection{
   public:
      BuyButton buy;
      
      void Init(){
         buy.Init("btn_buy","Buy",190,70,75,30);
      }
      
      void DeInit(){
         buy.DeInit();
      }
};
