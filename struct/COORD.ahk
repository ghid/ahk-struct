/*
:encoding=UTF-8:
:subdir=struct:
*/

;{{{ COORD class
/*
typedef struct _COORD {
  SHORT X;
  SHORT Y;
} COORD, *PCOORD;
*/
class COORD  extends Struct {
	
	static Size := 4
	
	X := 0
	Y := 0
	
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
				_log.All("pData:`n" LoggingHelper.HexDump(&pData, 0, sizeof(COORD)))
		}
			
		this.MemberGet(pData, _ofs:=0, this, "X", "Short")
		this.MemberGet(pData, _ofs,    this, "Y", "Short")
		if (_log.Logs("Finest")) {
			_log.Finest("X = " this.X)
			_log.Finest("Y = " this.Y)
		}

		return _log.Exit()
	}
	;}}}

	;{{{ Get
	Get(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		iLength := sizeof(COORD)
		if (_log.Logs("Finest")) {
			_log.Finest("iLength = " iLength)
			_log.Finest("X = " this.X)
			_log.Finest("Y = " this.Y)
		}
		VarSetCapacity(pData, iLength, 0)
		this.MemberSet(this.X, pData, _ofs:=0, "Short")
		this.MemberSet(this.Y, pData, _ofs,    "Short")
		
		if (_log.Logs())
			_log.All("Data:`n" LoggingHelper.HexDump(&pData, 0, iLength))
		
		return _Log.Exit()
	}
	;}}}
}
;}}}

