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
	static FOREGROUND_BLUE  		:= 0x01
	static FOREGROUND_GREEN 		:= 0x02
	static FOREGROUND_RED   		:= 0x04
	static BACKGROUND_BLUE  		:= 0x10
	static BACKGROUND_GREEN 		:= 0x20
	static BACKGROUND_RED		:= 0x40
	static FOREGROUND_INTENSITY	:= 0x08
	static BACKGROUND_INTENSITY	:= 0x80
	
	dwSize				:= new COORD()
	dwCursorPosition		:= new COORD()
	wAttributes			:= 0
	srWindow				:= new SMALL_RECT()
	dwMaximumWindowSize	:= new COORD()
	
	;{{{ __New
	__New(ByRef pData = "") {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (pData <> "")
			this.Set(pData)
			
		_log.Exit(this)
	}
	;}}}

	;{{{ Set
	Set(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&Data", &pData)
			if (_log.Logs()) 
				_Log.All("pData`n" var_Hex_Dump(&pData, 0, sizeof(CONSOLE_SCREEN_BUFFER_INFO)))
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
			this.StructSet(this.dwSize, 				pData, _ofs:=0)
			this.StructSet(this.dwCursorPosition, 	pData, _ofs)
			this.MemberSet(this.wAttributes, 		pData, _ofs, "UShort")
			this.StructSet(this.srWindow, 			pData, _ofs)
			this.StructSet(this.dwMaximumWindowSize, pData, _ofs)
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		if (_log.Logs())
			_log.All("pData:`n" var_Hex_Dump(&pData, 0, iLength))
			
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

	;{{{ Background_Color
	Background_Color() {
		_Log := new Logger("struct.class." A_ThisFunc)
		return _Log.Exit(This.wAttributes & 0xf0)
	}
	;}}}

	;{{{ Foreground_Color
	Foreground_Color() {
		_Log := new Logger("struct.class." A_ThisFunc)
		return _Log.Exit(This.wAttributes & 0x0f)
	}
	;}}}

}
;}}}

