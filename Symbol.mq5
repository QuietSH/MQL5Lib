//+------------------------------------------------------------------+
//|                                                       Symbol.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

class clsSymbol{
   
   public:
   
      //Gibt den Ask Kurs zurück
      double Ask(){ return SymbolInfoDouble(_Symbol,SYMBOL_ASK); }
      
      //Gibt den Bid Kurs zudück
      double Bid(){ return SymbolInfoDouble(_Symbol,SYMBOL_BID); }
      
      //Gibt den Spread zudück
      double Spread(){
         double res = Ask()-Bid();
         return StringToDouble(DoubleToString(res * MathPow(10,_Digits)/100,2));
      }
      
      //Gibt den Marginwert für das jeweilige Symbol zurück, abhängig von den übergebenen Werten
      //Standardwerte sind für den aktuellen Preis und des kleinsten Volumen auf eine Buy Order
      double Margin(double Volumen = 0, double Price = 0, ENUM_ORDER_TYPE OrderType = ORDER_TYPE_BUY){
         double val;
         
         if(Volumen == 0)
            Volumen = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
         
         if(Price == 0.0)
            Price = SymbolInfoDouble(_Symbol,SYMBOL_BID);
            
         OrderCalcMargin(OrderType,_Symbol,Volumen,Price,val);
         return val;
      }
      
      //Gibt das Tagestief zurück
      //ago = 0 entspricht dem aktuellen Tag, ago = 1 gestern usw.
      double DayLow(int ago = 0){
         return iLow(_Symbol,PERIOD_D1,ago);
      }
      
      //Gibt das Tageshoch zurück
      //ago = 0 entspricht dem aktuellen Tag, ago = 1 gestern usw.
      double DayHigh(int ago = 0){
         return iHigh(_Symbol,PERIOD_D1,ago);
      }
      
      //Gibt die Tageseröffnung zurück (erster Kurs des Tages des Tages)
      //ago = 0 entspricht dem aktuellen Tag, ago = 1 gestern usw.
      double DayOpen(int ago = 0){
         return iOpen(_Symbol,PERIOD_D1,ago);
      }
      
      //Gibt den TagesSchlusskurs zurück
      //ago = 0 entspricht dem aktuellen Tag, ago = 1 gestern usw.
      //da der aktuelle Tag nie geschlossen ist wird hier ein Tag hinzuaddiert
      double DayClose(int ago = 0){
         return iClose(_Symbol,PERIOD_D1,ago + 1);
      }
};