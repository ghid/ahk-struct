#Include <modules\struct\COORD>
#Include <modules\struct\SMALL_RECT>

class CONSOLE_SCREEN_BUFFER_INFO extends Struct {

	static Size := 22

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

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	Set(ByRef pData) {
		try {
			this.StructGet(pData, _ofs:=0, this.dwSize)
			this.StructGet(pData, _ofs, 	 this.dwCursorPosition)
			this.MemberGet(pData, _ofs,	 this, "wAttributes", "UShort")
			this.StructGet(pData, _ofs,	 this.srWindow)
			this.StructGet(pData, _ofs,	 this.dwMaximumWindowSize)
		} catch exInvalidDataType
			throw exInvalidDataType
	}
	;}}}

	;{{{ Get
	Get(ByRef pData) {
		iLength := sizeof(CONSOLE_SCREEN_BUFFER_INFO)
		VarSetCapacity(pData, iLength, 0)
		try {
			this.StructSet(this.dwSize, 			 pData, _ofs:=0)
			this.StructSet(this.dwCursorPosition, 	 pData, _ofs)
			this.MemberSet(this.wAttributes, 		 pData, _ofs, "UShort")
			this.StructSet(this.srWindow, 			 pData, _ofs)
			this.StructSet(this.dwMaximumWindowSize, pData, _ofs)
		} catch exInvalidDataType
			throw exInvalidDataType
	}

	Has(Character_Attributes) {
		return This.wAttributes & Character_Attributes
	}

	BackgroundColor() {
		return This.wAttributes & 0xf0
	}

	ForegroundColor() {
		return This.wAttributes & 0x0f
	}
}
