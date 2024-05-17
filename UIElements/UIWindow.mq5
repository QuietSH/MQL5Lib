//+------------------------------------------------------------------+
//|                                                     UEWindow.mq5 |
//|                                                            Quiet |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Quiet"
#property link      "https://www.mql5.com"
#property version   "1.00"

class UIWindow{
   private:
      string name;
      ENUM_BORDER_TYPE btype;
      bool hide;
      
      void Create(string Name, int X, int Y, int width, int height){
         if(!ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,0,0,0))
            return;
            
         SetBorderType();
         ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
         ObjectSetInteger(0,name,OBJPROP_XDISTANCE,X);
         ObjectSetInteger(0,name,OBJPROP_YDISTANCE,Y);
         ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
         ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
      }
   public:
      
      void Init(string Name, int X, int Y, int width, int height){
         name = Name;
         Create(Name,X,Y,width,height);
         Hide();
      }
      
      void Init(string Name, int X, int Y, int width, int height, bool hidden){
         name = Name;
         Create(Name,X,Y,width,height);
         Hide(hidden);
      }
      
      void SetBorderType(ENUM_BORDER_TYPE BType = BORDER_FLAT){
         btype = BType;
         ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,btype);
      }
      
      void Hide(bool toggle = true){
         hide = toggle;
         ObjectSetInteger(0,name,OBJPROP_HIDDEN,hide);
      }
};