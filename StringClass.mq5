//+------------------------------------------------------------------+
//|                                                  StringClass.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

//Gibt die aktuelle Uhrzeit als STring wieder, im Format hh:mm:ss
string GetTime(){
   MqlDateTime time;
   TimeCurrent(time);
   string h,m,s;
   
   if(time.hour < 10)
      h = "0" + time.hour;
   else
      h = time.hour;
   
   if(time.min < 10)
      m = "0" + time.min;
   else
      m = time.min;
      
   if(time.sec < 10)
      s = "0" + time.sec;
   else
      s = time.sec;
   return h + ":" + m + ":" + s;
}

//Gibt ein DoubleWert als String zurück mit zwei Stellen nach dem Kommata
string GetDblStr(double Number){
   return DoubleToString(Number,2);
}

//Kürzt einen DoubleWert auf zwei Stellen nach dem Kommata
double GetClrDbl(double Number){
   return StringToDouble(GetDblStr(Number));
}