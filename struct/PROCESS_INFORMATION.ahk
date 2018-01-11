/*
:encoding=UTF-8:
:subdir=struct:
*/

#include <logging>
#include <struct>

/*
typedef struct _PROCESS_INFORMATION {
  HANDLE hProcess;
  HANDLE hThread;
  DWORD  dwProcessId;
  DWORD  dwThreadId;
} PROCESS_INFORMATION, *LPPROCESS_INFORMATION;
*/

class PROCESS_INFORMATION extends Struct {

	static size = Func("PROCESS_INFORMATION.SizeOf")
	
	hProcess := 0
	hThread := 0
	dwProcessId := 0
	dwThreadId := 0

	;{{{ __New
	__New(ByRef pData = "") {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (pData <> "")
			this.Set(pData)
			
		return _log.Exit(this)
	}
	;}}}
	
	;{{{ SizeOf
	SizeOf() {
		return (A_PtrSize == 4 ? 16 : 24)
	}
	;}}}

	;{{{ Set
	Set(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs(Logger.Input)) {
			_log.Input("&Data", &pData)
			if (_log.Logs()) 
				_Log.All("pData`n" LoggingHelper.HexDump(&pData, 0, sizeof(PROCESS_INFORMATION)))
		}
		
		try {
			this.MemberGet(pData, _ofs:=0	, this, "hProcess"		, C.HANDLE)
			this.MemberGet(pData, _ofs		, this, "hThread"		, C.HANDLE)
			this.MemberGet(pData, _ofs		, this, "dwProcessId"	, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwThreadId"	, C.DWORD)
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		return _Log.Exit()
	}
	;}}}

	;{{{ Get
	Get(ByRef pData) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		iLength := sizeof(PROCESS_INFORMATION)
		_log.Finest("iLength = " iLength)
		VarSetCapacity(pData, iLength, 0)
		try {
			this.MemberSet(this.hProcess	, pData, _ofs:=0	, C.HANDLE)
			this.MemberSet(this.hThread		, pData, _ofs		, C.HANDLE)
			this.MemberSet(this.dwProcessId	, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwThreadId	, pData, _ofs		, C.DWORD)
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		if (_log.Logs())
			_log.All("pData:`n" LoggingHelper.HexDump(&pData, 0, iLength))
			
		return _Log.Exit(_ofs + 1)
	}
	;}}}
}
