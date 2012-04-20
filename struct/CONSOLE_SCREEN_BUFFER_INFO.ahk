#Include <Struct>
#Include <struct\COORD>
#Include <struct\SMALL_RECT>

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
class CONSOLE_SCREEN_BUFFER_INFO extends Struct {
	static Size := 24
	
	; Character Attributes
	static FOREGROUND_BLUE  :=  0x1
	static FOREGROUND_GREEN :=  0x2
	static FOREGROUND_RED   :=  0x4
	static BACKGROUND_BLUE  := 0x10
	static BACKGROUND_GREEN := 0x20
	static BACKGROUND_RED   := 0x40
	
	static FOREGROUND_INTENSITY :=  0x8
	static BACKGROUND_INTENSITY := 0x80
	
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
			_Log.Input("Data", "...`n" var_Hex_Dump(&Data, 0, CONSOLE_SCREEN_BUFFER_INFO.Size))
			
		Len := Base.StructGet(This.Coord_Size, Data, Ofs:=0)
		Len := Base.StructGet(This.Coord_CursorPosition, Data, Ofs+=Len)		
		; This.Attributes := NumGet(Data, Ofs+=Len, "UInt")
		Len := Base.FieldGet(This.Attributes, Data, Ofs+=Len, "UInt")
		Len := Base.StructGet(This.Small_Rect_Window, Data, Ofs+=4)
		Len := Base.StructGet(This.Coord_Maximum_Window_Size, Data, Ofs+=Len)		
			
		return _Log.Exit(Ofs + Len)
	}
	
	Get(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		VarSetCapacity(Data, 0, CONSOLE_SCREEN_BUFFER_INFO.Size)
		sys_MemMove(Data, This.Coord_Size.Get(_Data), Ofs:=0, 0, COORD.Size)
		sys_MemMove(Data, This.Coord_CursorPosition.Get(_Data), Ofs+=COORD.Size, 0, COORD.Size)
		NumPut(This.Attributes, Data, Ofs+=COORD.Size, "UShort")
		sys_MemMove(Data, This.Small_Rect_Window.Get(_Data), Ofs+=4, 0, SMALL_RECT.Size)
		sys_MemMove(Data, This.Coord_Maximum_Window_Size.Get(_Data), Ofs+=SMALL_RECT.Size, 0, COORD.Size)
		Ofs+=COORD.Size
		
		return _Log.Exit(Ofs)
	}
	
	;{{{ Has
	Has(Character_Attributes) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		_Log.Input("Character_Attributes", Character_Attributes)
		
		return _Log.Exit(This.Attributes & Character_Attributes)
	}
	;}}}

	;{{{ Background_Color
	Background_Color() {
		_Log := new Logger("struct.class." A_ThisFunc)
		return _Log.Exit(This.Attributes & 0xf0)
	}
	;}}}

	;{{{ Foreground_Color
	Foreground_Color() {
		_Log := new Logger("struct.class." A_ThisFunc)
		return _Log.Exit(This.Attributes & 0x0f)
	}
	;}}}

}
;}}}

