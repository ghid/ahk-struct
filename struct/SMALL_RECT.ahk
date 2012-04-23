/*
:encoding=UTF-8:
:subdir=struct:
*/

;{{{ SMALL_RECT class
/*
typedef struct _SMALL_RECT {
  SHORT Left;
  SHORT Top;
  SHORT Right;
  SHORT Bottom;
} SMALL_RECT;
*/
class SMALL_RECT extends Struct {
	
	static Size := 8
	
	Left   := 0
	Top    := 0
	Right  := 0
	Bottom := 0
	
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
			_log.Input("&pData", &pData)
			if (_log.Logs())
				_log.Input("pData:`n" var_Hex_Dump(&pData, 0, sizeof(SMALL_RECT)))
		}
			
		this.MemberGet(pData, _ofs:=0, this, "Left",   "Short")
		this.MemberGet(pData, _ofs,    this, "Top",    "Short")
		this.MemberGet(pData, _ofs,    this, "Right",  "Short")
		this.MemberGet(pData, _ofs,    this, "Bottom", "Short")
		if (_log.Logs("Finest")) {
			_log.Finest("Left = ",   this.Left)
			_log.Finest("Top = ",    this.Top)
			_log.Finest("Right = ",  this.Right)
			_log.Finest("Bottom = ", this.Bottom)
		}
		
		return _Log.Exit()
	}
	;}}}
	
	;{{{ Get
	Get(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		iLength := sizeof(SMALL_RECT)
		if (_log.Logs("Finest")) {
			_log.Finest("iLength = " iLength)
			_log.Finest("Left = " this.Left)
			_log.Finest("Top = " this.Top)
			_log.Finest("Rigth = " this.Right)
			_log.Finest("Bottom = " this.Bottom)
		}
		VarSetCapacity(Data, iLength, 0)
		this.MemberSet(this.Left,   pData, _ofs:=0, "Short")
		this.MemberSet(this.Top,    pData, _ofs,    "Short")
		this.MemberSet(this.Right,  pData, _ofs,    "Short")
		this.MemberSet(this.Bottom, pData, _ofs,    "Short")
		
		if (_Log.Logs())
			_Log.All("Data", "`n" var_Hex_Dump(&pData, 0, iLength))
		
		return _Log.Exit()
	}
	;}}}
}
;}}}

