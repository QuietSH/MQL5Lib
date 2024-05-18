//+------------------------------------------------------------------+
//|                                                     UIButton.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

class BaseButton{
   private:
      string name, label;
      int x,y,width, height;
      
      void Create(){
         if(!ObjectCreate(0,name,OBJ_BUTTON,0,0,0))
            return;
         ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
         ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
         ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
         ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
         ObjectSetInteger(0,name,OBJPROP_ZORDER,1);
         ObjectSetString(0,name,OBJPROP_TEXT,label);
      }
   public:
      void Init(string Name, string Label, int X, int Y, int Width, int Height){
         name = Name; label = Label;x = X; y = Y; width = Width; height = Height;
         Create();
      }
      
      void virtual OnClick(){
      
      }
      
      void DeInit(){
         ObjectDelete(0,name);
      }
};