/*
:encoding=UTF-8:
:subdir=struct:
*/

;{{{ class SYSTEMTIME
/*
typedef struct _SYSTEMTIME {
  WORD wYear;
  WORD wMonth;
  WORD wDayOfWeek;
  WORD wDay;
  WORD wHour;
  WORD wMinute;
  WORD wSecond;
  WORD wMilliseconds;
} SYSTEMTIME, *PSYSTEMTIME;
*/
class SYSTEMTIME extends Struct {
	static size := 16
	
	wYear := 0
	wMonth := 0
	wDayOfWeek := 0
	wDay := 0
	wHour := 0
	wMinute := 0
	wSecond := 0
	wMilliseconds := 0
	
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
				_log.All("pData:`n" var_Hex_Dump(&pData, 0, sizeof(SYSTEMTIME)))
		}
			
		this.MemberGet(pData, _ofs:=0, this, "wYear",         "Short")
		this.MemberGet(pData, _ofs,    this, "wMonth",        "Short")
		this.MemberGet(pData, _ofs,    this, "wDayOfWeek",    "Short")
		this.MemberGet(pData, _ofs,    this, "wDay",          "Short")
		this.MemberGet(pData, _ofs,    this, "wHour",         "Short")
		this.MemberGet(pData, _ofs,    this, "wMinute",       "Short")
		this.MemberGet(pData, _ofs,    this, "wSecond",       "Short")
		this.MemberGet(pData, _ofs,    this, "wMilliseconds", "Short")
		if (_log.Logs("Finest")) {
			_log.Finest("wYear = " wYear)
			_log.Finest("wMonth = " wMonth)
			_log.Finest("wDayOfWeek = " wDayOfWeek)
			_log.Finest("wDay = " wDay)
			_log.Finest("wHour = " wHour)
			_log.Finest("wMinute = " wMinute)
			_log.Finest("wSecond = " wSecond)
			_log.Finest("wMilliseconds = " wMilliseconds)
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
			_log.Finest("wYear = " wYear)
			_log.Finest("wMonth = " wMonth)
			_log.Finest("wDayOfWeek = " wDayOfWeek)
			_log.Finest("wDay = " wDay)
			_log.Finest("wHour = " wHour)
			_log.Finest("wMinute = " wMinute)
			_log.Finest("wSecond = " wSecond)
			_log.Finest("wMilliseconds = " wMilliseconds)
		}
		VarSetCapacity(pData, iLength, 0)
		this.MemberSet(this.wYear,         pData, _ofs:=0, "Short")
		this.MemberSet(this.wMonth,        pData, _ofs,    "Short")
		this.MemberSet(this.wDayOfWeek,    pData, _ofs,    "Short")
		this.MemberSet(this.wDay,          pData, _ofs,    "Short")
		this.MemberSet(this.wHour,         pData, _ofs,    "Short")
		this.MemberSet(this.wMinute,       pData, _ofs,    "Short")
		this.MemberSet(this.wSecond,       pData, _ofs,    "Short")
		this.MemberSet(this.wMilliseconds, pData, _ofs,    "Short")
		
		if (_log.Logs())
			_log.All("Data:`n" var_Hex_Dump(&pData, 0, iLength))
		
		return _Log.Exit()
	}
	;}}}
}
;}}}

