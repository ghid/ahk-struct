/*
:encoding=UTF-8:
:subdir=struct:
*/

#Include <struct\COORD>
#Include <struct\SMALL_RECT>

;{{{ CONSOLE_SCREEN_BUFFER_INFO class
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
	
	static Size := 22
	
	; Character Attributes
	; see also http://msdn.microsoft.com/en-us/library/windows/desktop/ms682013%28v=vs.85%29.aspx
	static FOREGROUND_BLUE  			:= 0x0001
		 , FOREGROUND_GREEN 			:= 0x0002
		 , FOREGROUND_RED  			 	:= 0x0004
		 , BACKGROUND_BLUE  			:= 0x0010
		 , BACKGROUND_GREEN 			:= 0x0020
		 , BACKGROUND_RED				:= 0x0040
		 , FOREGROUND_INTENSITY			:= 0x0008
		 , BACKGROUND_INTENSITY			:= 0x0080
		 , COMMON_LVB_LEADING_BYTE		:= 0x0100
		 , COMMON_LVB_TRAILING_BYTE		:= 0x0200
		 , COMMON_LVB_GRID_HORIZONTAL	:= 0x0400
		 , COMMON_LVB_GRID_LVERTICAL	:= 0x0800
		 , COMMON_LVB_GRID_RVERTICAL	:= 0x1000
		 , COMMON_LVB_REVERSE_VIDEO		:= 0x4000
		 , COMMON_LVB_UNDERSCORE		:= 0x8000 
	
	dwSize				:= new COORD()
	dwCursorPosition	:= new COORD()
	wAttributes			:= 0
	srWindow			:= new SMALL_RECT()
	dwMaximumWindowSize	:= new COORD()
	
	;{{{ __New
	__New(ByRef pData = "") {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (pData <> "")
			this.Set(pData)
			
		return _log.Exit(this)
	}
	;}}}

	;{{{ Set
	Set(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&Data", &pData)
			if (_log.Logs()) 
				_Log.All("pData`n" LoggingHelper.HexDump(&pData, 0, sizeof(CONSOLE_SCREEN_BUFFER_INFO)))
		}
		
		try {
			this.StructGet(pData, _ofs:=0, this.dwSize)
			this.StructGet(pData, _ofs, 	 this.dwCursorPosition)
			this.MemberGet(pData, _ofs,	 this, "wAttributes", "UShort")
			this.StructGet(pData, _ofs,	 this.srWindow)
			this.StructGet(pData, _ofs,	 this.dwMaximumWindowSize)		
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		return _Log.Exit()
	}
	;}}}

	;{{{ Get
	Get(ByRef pData) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		iLength := sizeof(CONSOLE_SCREEN_BUFFER_INFO)
		_log.Finest("iLength = " iLength)
		VarSetCapacity(pData, iLength, 0)
		try {
			this.StructSet(this.dwSize, 			 pData, _ofs:=0)
			this.StructSet(this.dwCursorPosition, 	 pData, _ofs)
			this.MemberSet(this.wAttributes, 		 pData, _ofs, "UShort")
			this.StructSet(this.srWindow, 			 pData, _ofs)
			this.StructSet(this.dwMaximumWindowSize, pData, _ofs)
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		if (_log.Logs())
			_log.All("pData:`n" LogginHelper.HexDump(&pData, 0, iLength))
			
		return _Log.Exit()
	}
	;}}}

	;{{{ Has
	Has(Character_Attributes) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		_Log.Input("Character_Attributes", Character_Attributes)
		
		return _Log.Exit(This.wAttributes & Character_Attributes)
	}
	;}}}

	;{{{ BackgroundColor
	BackgroundColor() {
		_Log := new Logger("struct.class." A_ThisFunc)
		return _Log.Exit(This.wAttributes & 0xf0)
	}
	;}}}

	;{{{ ForegroundColor
	ForegroundColor() {
		_Log := new Logger("struct.class." A_ThisFunc)
		return _Log.Exit(This.wAttributes & 0x0f)
	}
	;}}}

}
;}}}

