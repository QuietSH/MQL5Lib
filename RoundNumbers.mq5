//+------------------------------------------------------------------+
//|                                                 RoundNumbers.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

/*
Zeichnet ein horizontales Gitter in den Chart mit unterschiedlichen Abständen, je nach Instument
RNCount muss nicht zwingend die Anzahl der Linien*2 (oben/unten) sein
*/

#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

input group "RoundNumber Settings";
//wichtig für die Schleife, Standard ist 15
input int RNCount = 15;
input group " ";

class RoundNumbers{
   private:
   int counts;
   int digit(){
      return (int)(MathPow(10,_Digits));
   }
   
   double value(){
      return SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   }
   
   double size(){
      return SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   }
   
   void L50(double Price, string Name){
      ObjectCreate(NULL,Name,OBJ_HLINE,0,0,Price);
      ObjectSetInteger(NULL,Name,OBJPROP_COLOR,clrDarkGray);
      ObjectSetInteger(NULL,Name,OBJPROP_STYLE,STYLE_DOT);
   }
   
   void L100(double Price, string Name){
      ObjectCreate(NULL,Name,OBJ_HLINE,0,0,Price);
      ObjectSetInteger(NULL,Name,OBJPROP_COLOR,clrDarkGray);
      ObjectSetInteger(NULL,Name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
   }
   
   void L1000(double Price, string Name){
      ObjectCreate(NULL,Name,OBJ_HLINE,0,0,Price);
      ObjectSetInteger(NULL,Name,OBJPROP_COLOR,clrDarkGray);
      ObjectSetInteger(NULL,Name,OBJPROP_WIDTH,2);
      ObjectSetInteger(NULL,Name,OBJPROP_STYLE,STYLE_SOLID);
   }
   
   //Zeichnet die Linien für Instrumente mit 2 Digits
   void Draw2Digits(double Price){
      double p1 = Price, p2 = Price;
      if(_Digits != 2)
         return;
         //Zeichnet die AnfangsBezugsLinie
         if(MathMod(p1,1000) == 0){
            L1000(p1,"RN_" + 0);
         }else{
            L100(p1,"RN_" + 0);
         }
         
         for(int i = 1;i < counts;i++){
            //Erhöhung der Werte für das Gitter
            p1 = p1 + (50);
            p2 = p2 - (50);
            
            if(MathMod(p1,1000) == 0){
               L1000(p1,"RN_" + i);
            }else if(MathMod(p1,100) == 0){
               L100(p1,"RN_" + i);
            }else if(MathMod(p1,50) == 0){
               L50(p1,"RN_" + i);
            }
            
            if(MathMod(p2,1000) == 0){
               L1000(p2,"RN_" + -i);
            }else if(MathMod(p2,100) == 0){
               L100(p2,"RN_" + -i);
            }else if(MathMod(p2,50) == 0){
               L50(p2,"RN_" + -i);
            }
            
         }
   }
   
   //Zeichnet die Linien für Instrumente mit 3 Digits
   void Draw3Digits(double Price){
      double p1 = Price, p2 = Price, p1_tmp, p2_tmp;
      if(_Digits != 3)
         return;
         //Zeichnet die AnfangsBezugsLinie
         if(MathMod(p1,1000) == 0){
            L1000(p1,"RN_" + 0);
         }else{
            L100(p1,"RN_" + 0);
         }
         
         for(int i = 1; i < counts; i++){
            
            //Erhöhung der Werte für das Gitter
            //Zwischenspeichern und umrechnen der Werte für den Vergleich
            p1 = p1 + 0.5;
            p2 = p2 - 0.5;

            p1_tmp = p1 * 1000;
            p2_tmp = p2 * 1000;
            
            if(MathMod(p1_tmp,10000) == 0){
               L1000(p1,"RN_" + i);
            }else if(MathMod(p1_tmp,1000) == 0){
               L100(p1,"RN_" + i);
            }else if(MathMod(p1_tmp,500) == 0){
               L50(p1,"RN_" + i);
            }
            
            if(MathMod(p2_tmp,10000) == 0){
               L1000(p2,"RN_" + -i);
            }else if(MathMod(p2_tmp,1000) == 0){
               L100(p2,"RN_" + -i);
            }else if(MathMod(p1_tmp,500) == 0){
               L50(p2,"RN_" + -i);
            }
            
         }
   }
   
   //Zeichnet die Linien für Instrumente mit 4 und mehr Digits
   void Draw4DigitsMore(double Price){
      double p1 = Price, p2 = Price, p1_tmp, p2_tmp;
      string t;
      if(_Digits < 3)
         return;
         //Zeichnet die AnfangsBezugsLinie
         if(MathMod(p1,1000) == 0){
            L1000(p1,"RN_" + 0);
         }else if(MathMod(p1,500) == 0){
            L100(p1,"RN_" + 0);
         }else if(MathMod(p1,250) == 0){
            L50(p1,"RN_" + 0);
         }
         
         for(int i = 1; i < counts; i++){
         
            //Erhöhung der Werte für das Gitter
            //Zwischenspeichern und umrechnen der Werte für den Vergleich
            p1 = p1 + (50*size());
            p1_tmp = p1 * MathPow(10,_Digits);
            
            p2 = p2 - (50*size());
            p2_tmp = p2 * MathPow(10,_Digits);
            
            //Umwandlung der Werte in einen String und wieder zurück,
            //um Rundungsfehler zu umgehen
            t = DoubleToString(p1_tmp,3);
            p1_tmp = StringToDouble(t);
            t = DoubleToString(p2_tmp,3);
            p2_tmp = StringToDouble(t);
            
            
            if(MathMod(p1_tmp,1000) == 0){
               L1000(p1,"RN_" + i);
            }else if(MathMod(p1_tmp,500) == 0){
               L100(p1,"RN_" + i);
            }else if(MathMod(p1_tmp,250) == 0){
               L50(p1,"RN_" + i);
            }
            
            if(MathMod(p2_tmp,1000) == 0){
               L1000(p2,"RN_" + -i);
            }else if(MathMod(p2_tmp,500) == 0){
               L100(p2,"RN_" + -i);
            }else if(MathMod(p2_tmp,250) == 0){
               L50(p2,"RN_" + -i);
            }
            
         }
   }
   
   public:
   
      double Bid(){
         return SymbolInfoDouble(_Symbol,SYMBOL_BID);
      }
      
      //Berechnung des Bezugspreises, dieser liegt in der Nähe des aktuellen Kurses bei Ausführung der Funktion
      double FirstPrice(){
         double p = SymbolInfoDouble(_Symbol,SYMBOL_BID);
         string nr;
         int tmp = p;
         
         //Um Rundungsfehler zu vermeiden wird der Kurs in einen String umgewandelt und dann wieder zurück
         //da aus expl: 1.01000 auch 1.0099999999999 werden kann
         if(_Digits == 2){
            tmp = tmp /100;
            tmp = tmp * 100;
            nr=DoubleToString(tmp,_Digits);
            return StringToDouble(nr);
         }
         
         if(_Digits == 3){
            tmp = p;
            nr=DoubleToString(tmp,_Digits);
            return StringToDouble(nr);
         }
         
         if(_Digits > 3){
            tmp = p*MathPow(10,_Digits-2);
            nr=DoubleToString(tmp/MathPow(10,_Digits-2),_Digits);
            return StringToDouble(nr);
         }
          
         return -1;
      }
      
      void Init(int Counts = 15){
         counts = Counts;
         //Zuweisen des Bezugspreises zu einer Variablen, damit diese Funktion nur einmal ausgeführt werden muss
         double p = FirstPrice();
         
         //Aufrufen der Zeichenfunktionen
         Draw2Digits(p);
         Draw3Digits(p);
         Draw4DigitsMore(p);
      }
      
      void DeInit(){
         //Löschen des Gitters
         for(int i = 1;i < counts;i++){
            ObjectDelete(NULL,"RN_0");
            ObjectDelete(NULL,"RN_" + i);
            ObjectDelete(NULL,"RN_" + -i);
         }
      }
};