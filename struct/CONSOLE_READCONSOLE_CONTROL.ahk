/*
:encoding=UTF-8:
:subdir=struct:
*/

/*
typedef struct _CONSOLE_READCONSOLE_CONTROL {
  ULONG nLength;
  ULONG nInitialChars;
  ULONG dwCtrlWakeupMask;
  ULONG dwControlKeyState;
} CONSOLE_READCONSOLE_CONTROL, *PCONSOLE_READCONSOLE_CONTROL;
*/
class CONSOLE_READCONSOLE_CONTROL extends Struct {

	size := 32
	
	nLength := 0
	nInitialChars := 0
	dwCtrlWakeupMask := 0
	dwControlKeyState := 0
	
	;{{{ __New
	__New(ByRef pData = "") {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (pData <> "")
			this.Set(pData)
		this.nLength := sizeof(CONSOLE_READCONSOLE_CONTROL)

		_log.Exit(this)
	}
	;}}}
	
	;{{{ Set
	Set(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&pData", &pData)
			if (_log.Logs())
				_log.All("pData:`n" LoggingHelper.HexDump(&pData, 0, sizeof(CONSOLE_READCONSOLE_CONTROL)))
		}
			
		this.MemberGet(pData, _ofs:=0, this, "nLength",           "UInt")
		this.MemberGet(pData, _ofs,    this, "nInitialChars",     "UInt")
		this.MemberGet(pData, _ofs,    this, "dwCtrlWakeupMask",  "UInt")
		this.MemberGet(pData, _ofs,    this, "dwControlKeyState", "UInt")
		if (_log.Logs(Logger.Finest)) {
			_log.Finest("nLength = " nLength)
			_log.Finest("nInitialChars = " nInitialChars)
			_log.Finest("dwCtrlWakeupMask = " dwCtrlWakeupMask)
			_log.Finest("dwControlKeyState = " dwControlKeyState)
		}

		return _log.Exit()
	}
	;}}}

	;{{{ Get
	Get(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		nLength := sizeof(CONSOLE_READCONSOLE_CONTROL)
		if (_log.Logs(Logger.Finest)) {
			_log.Finest("nLength = " this.nLength)
			_log.Finest("nInitialChars = " this.nInitialChars)
			_log.Finest("dwCtrlWakeupMask = " this.dwCtrlWakeupMask)
			_log.Finest("dwControlKeyState = " this.dwControlKeyState)
		}
		VarSetCapacity(pData, nLength, 0)
		this.MemberSet(this.nLength,           pData, _ofs:=0, "UInt")
		this.MemberSet(this.nInitialChars,     pData, _ofs,    "UInt")
		this.MemberSet(this.dwCtrlWakeupMask,  pData, _ofs,    "UInt")
		this.MemberSet(this.dwControlKeyState, pData, _ofs,    "UInt")
		
		if (_log.Logs())
			_log.All("Data:`n" LoggingHelper.HexDump(&pData, 0, nLength))
		
		return _Log.Exit()
	}
	;}}}
	
}
