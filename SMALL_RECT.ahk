;{{{ SMALL_RECT 
/*
typedef struct _SMALL_RECT {
  SHORT Left;
  SHORT Top;
  SHORT Right;
  SHORT Bottom;
} SMALL_RECT;
*/
class SMALL_RECT {
	static Size := 8
	
	Left   := 0
	Top    := 0
	Right  := 0
	Bottom := 0
	
	;{{{ __New
	__New(ByRef Data = "") {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (Data <> "")
			This.Set(Data)
		
		_Log.Exit(This)
	}
	;}}}
	
	;{{{ Set
	Set(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (_Log.Logs("Input"))
			_Log.Input("Data", "`n" var_Hex_Dump(&Data, 0, SMALL_RECT.Size))
			
		This.Left   := NumGet(Data, Ofs:=0, "Short")
		This.Top    := NumGet(Data, Ofs+=2, "Short")
		This.Right  := NumGet(Data, Ofs+=2, "Short")
		This.Bottom := NumGet(Data, Ofs+=2, "Short"), Ofs+=2
		if (_Log.Logs("Finest")) {
			_Log.Finest("Left = ",   This.Left)
			_Log.Finest("Top = ",    This.Top)
			_Log.Finest("Right = ",  This.Right)
			_Log.Finest("Bottom = ", This.Bottom)
		}
		
		return _Log.Exit(Ofs)
	}
	
	Get(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		VarSetCapacity(Data, SMALL_RECT.Size, 0)
		NumPut(This.Left,   Data, Ofs:=0, "Short")
		NumPut(This.Top,    Data, Ofs+=2, "Short")
		NumPut(This.Right,  Data, Ofs+=2, "Short")
		NumPut(This.Bottom, Data, Ofs+=2, "Short")
		
		if (_Log.Logs("Output"))
			_Log.Output("Data", "`n" var_Hex_Dump(&Data, 0, SMALL_RECT.Size))
		
		return _Log.Exit(Data)
	}
;}}}

}
;}}}

