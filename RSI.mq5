//+------------------------------------------------------------------+
//|                                                          RSI.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

//Benötigt die StringClass, die relevanten Stellen werden markiert.

input group "RSI Settings";
input double AlertLongValue = 35;
input double AlertShortValue = 65;
input int MAPeriod = 12;
input ENUM_APPLIED_PRICE PriceType = PRICE_CLOSE;
input ENUM_TIMEFRAMES TimeFrame = PERIOD_CURRENT;
input bool AlertMiddle = true;
input group " ";

class RSI{
   private:
      int handle;
      double buffer[1];
      int ma_period;
      ENUM_APPLIED_PRICE applied_price;
      ENUM_TIMEFRAMES tf;
      double longalertvalue, shortalertvalue; //Triggerwerte
      bool alert_long, alert_short; //Alert für Long und Short
      bool trigger_long, trigger_short, trigger_middle; //Trigger ausgelöst
      bool permaalert;
      
   public:
      
      void Init(){
         ma_period = MAPeriod;
         applied_price = PriceType;
         tf = TimeFrame;
         handle = iRSI(_Symbol,tf,ma_period,applied_price);
         CopyBuffer(handle,0,0,1,buffer);
      }
      
      //Defaultwerte, geeignet zum testen
      void DefaultInit(){
         ma_period = 12;
         applied_price = PRICE_CLOSE;
         tf = PERIOD_CURRENT;
         handle = iRSI(_Symbol,tf,ma_period,applied_price);
         CopyBuffer(handle,0,0,1,buffer);
         
         longalertvalue = 35;
         shortalertvalue = 65;
         alert_long = true;
         alert_short = true;
      }
      
      //Schaltet den die Alarme an oder aus, defaultwerte für beide ist true wenn
      //SetAlert(); ausgeführt wird
      void SetAlert(bool along = true, bool ashort = true){
         alert_long = along;
         alert_short = ashort;
      }
            
      //Setzt den Alarm permanent
      void SetPermaAlert(bool alert){
         permaalert = alert;
      }
      
      //***************************************
      // Gibt die Zustände der einzelnen Trigger wieder
      bool GetLongTrigger(){
         return trigger_long;
      }
      
      bool GetShortTrigger(){
         return trigger_short;
      }
      
      bool GetMiddleTrigger(){
         return trigger_middle;
      }
      //***************************************
      
      //***************************************
      //Setzt die Zustände der einzelnen Trigger
      void SetLongTrigger(bool toggle){
         trigger_long = toggle;
      }
      
      void SetShortTrigger(bool toggle){
         trigger_short = toggle;
      }
      
      void SetMiddleTrigger(bool toggle){
         trigger_middle = toggle;
      }
      //***************************************
      
      //Gibt den aktuellen RSIValue zurück
      double Value(){
         return buffer[0];
      }
      
      //Wandelt den RSIValue in einen String um mit zwei Stellen nach dem Kommata
      string StrValue(){
         return DoubleToString(Value(),2);
      }
      
      //Schreibt den RSIValue in die Console
      void PrintValue(){
         Print(DoubleToString(Value(),2));
      }
      
      
      //Function zum Alarmmanagement
      void AlertHandle(){
         //Wenn Alert aus, dann return
         if(!alert_long && !alert_short)
            return;
            
         //Wenn LongAlert aktiv und Trigger nicht ausgelöst wurde und
         //RSIValue kleiner als longalertvalue dann
         //Löse Alarm aus und setze den Trigger als ausgelöst
         if(alert_long && !trigger_long && Value() <= AlertLongValue){
            //************* Benotigt die StringClass ******************
            Alert(_Symbol + " " + GetTime() + " RSI Long: " + StrValue());
            if(!permaalert)
               trigger_long = !trigger_long;
         }
         
         //Wenn ShortAlert aktiv und Trigger nicht ausgelöst wurde und
         //RSIValue größer als shortalertvalue dann
         //Löse Alarm aus und setze den Trigger als ausgelöst
         if(alert_short && !trigger_short && Value() >= AlertShortValue){
            //************* Benotigt die StringClass ******************
            Alert(_Symbol + " " + GetTime() + " RSI Short: " + StrValue());
            if(!permaalert)
               trigger_short = !trigger_short;
         }
         
         //Short
         //Wenn RSIValue kleiner als 50 und der Trigger ausgelöst wurde, dann wird der Trigger zurückgesetzt
         if(Value() <= 50 && trigger_short)
            trigger_short = !trigger_short;
         
         //Long
         //Wenn RSIValue größer als 50 und der Trigger ausgelöst wurde, dann wird der Trigger zurückgesetzt   
         if(Value() >= 50 && trigger_long)
            trigger_long = !trigger_long;
      }
      
      
      //***********************************************************************
      //  Entweder OnTimer() oder OnTick() benutzen, nicht beide Funktionen
      //***********************************************************************
      
      //Function kommt in einem EA in die OnTimerFunction
      //expl: rsi.OnTimer();
      //Handle wird gesetzt und in ein Array übertragen um so den Value des RSI auslesen zu können
      void OnTimer(){
         handle = iRSI(_Symbol,tf,ma_period,applied_price);
         CopyBuffer(handle,0,0,1,buffer);
      }
      
      //Function kommt in einem EA in die OnTickFunction
      //expl: rsi.OnTick();
      //Handle wird gesetzt und in ein Array übertragen um so den Value des RSI auslesen zu können
      void OnTick(){
         handle = iRSI(_Symbol,tf,ma_period,applied_price);
         CopyBuffer(handle,0,0,1,buffer);
      }
      
};