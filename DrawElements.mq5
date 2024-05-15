//+------------------------------------------------------------------+
//|                                                 DrawElements.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

class DrawElements{

   public:
   
      //sucht ein Element nach Namen im Chart
      bool FindElement(string Name){
         int res = ObjectFind(NULL,Name);
         if(res == 0)
            return true;
         return false;
      }
      
      double HLinePrice(string Name){
         if(FindElement(Name))
            return ObjectGetDouble(NULL,Name,OBJPROP_PRICE);
         return -1;
      }
   
};