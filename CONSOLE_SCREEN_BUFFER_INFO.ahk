#Include E:\work\Struct\COORD.ahk
#Include E:\work\Struct\SMALL_RECT.ahk

;{{{ CONSOLE_SCREEN_BUFFER_INFO
/*
typedef struct _CONSOLE_SCREEN_BUFFER_INFO {
  COORD      dwSize;
  COORD      dwCursorPosition;
  WORD       wAttributes;
  SMALL_RECT srWindow;
  COORD      dwMaximumWindowSize;
} CONSOLE_SCREEN_BUFFER_INFO;
*/
class CONSOLE_SCREEN_BUFFER_INFO {
	static Size := 24
	
	Coord_Size                := new COORD()
	Coord_CursorPosition      := new COORD()
	Attributes                := 0
	Small_Rect_Window         := new SMALL_RECT()
	Coord_Maximum_Window_Size := new COORD()
	
	;{{{ __New
	__New(ByRef Data = "") {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (Data <> "")
			This.Set(Data)
			
		_Log.Exit(This)
	}
	;}}}

	Set(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (_Log.Logs("Input"))
			_Log.Input("Data", "`n" var_Hex_Dump(&Data, 0, CONSOLE_SCREEN_BUFFER_INFO.Size))
			
		VarSetCapacity(_Data, COORD.Size, 0)
		sys_MemMove(_Data, Data, 0, Ofs:=0, COORD.Size)
		This.Coord_Size.Set(_Data)
		
		sys_MemMove(_Data, Data, 0, Ofs+=COORD.Size, COORD.Size)
		This.Coord_CursorPosition.Set(_Data)
		
		This.Attributes := NumGet(Data, Ofs+=COORD.Size, "UInt")
		
		VarSetCapacity(_Data, SMALL_RECT.Size, 0)
		sys_MemMove(_Data, Data, 0, Ofs+=4, SMALL_RECT.Size)
		This.Small_Rect_Window.Set(_Data)
		
		VarSetCapacity(_Data, COORD.Size, 0)
		sys_MemMove(_Data, Data, 0, Ofs+=SMALL_RECT.Size, COORD.Size)
		This.Coord_Maximum_Window_Size.Set(_Data)
		
		Ofs+=COORD.Size
			
		return _Log.Exit(Ofs)
	}
	
	Get(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		VarSetCapacity(Data, 0, CONSOLE_SCREEN_BUFFER_INFO.Size)
		sys_MemMove(Data, This.Coord_Size.Get(_Data), Ofs:=0, 0, COORD.Size)
		sys_MemMove(Data, This.Coord_CursorPosition.Get(_Data), Ofs+=COORD.Size, 0, COORD.Size)
		NumPut(This.Attributes, Data, Ofs+=COORD.Size, "UShort")
		sys_MemMove(Data, This.Small_Rect_Window.Get(_Data), Ofs+=4, 0, SMALL_RECT.Size)
		sys_MemMove(Data, This.Coord_Maximum_Window_Size.Get(_Data), Ofs+=SMALL_RECT.Size, 0, COORD.Size)
		
		return _Log.Exit(Data)
	}
}
;}}}

