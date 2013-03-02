/*
:encoding=UTF-8:
:subdir=struct:
*/

#Include <struct\SYSTEMTIME>

;{{{ class TIME_ZONE_INFORMATION
/*
typedef struct _TIME_ZONE_INFORMATION {
  LONG       Bias;
  WCHAR      StandardName[32];
  SYSTEMTIME StandardDate;
  LONG       StandardBias;
  WCHAR      DaylightName[32];
  SYSTEMTIME DaylightDate;
  LONG       DaylightBias;
} TIME_ZONE_INFORMATION, *PTIME_ZONE_INFORMATION;
*/
class TIME_ZONE_INFORMATION extends Struct {
	
	static size := 172
	
	Bias := 0
	StandardName := ""
	StandardDate := new SYSTEMTIME()
	StandardBias := 0
	DaylightName := ""
	DaylightDate := new SYSTEMTIME()
	DaylightBias := 0
	
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
				_Log.All("pData`n" LoggingHelper.HexDump(&pData, 0, sizeof(TIME_ZONE_INFORMATION)))
		}
		
		try {
			this.MemberGet(pData, _ofs:=0, this, "Bias",         "Int")
			this.MemberGet(pData, _ofs,    this, "StandardName", "wchar[32]")
			this.StructGet(pData, _ofs,	   this.StandardDate)
			this.MemberGet(pData, _ofs,    this, "StandardBias", "Int")
			this.MemberGet(pData, _ofs,    this, "DaylightName", "wchar[32]")
			this.StructGet(pData, _ofs,    this.DaylightDate)
			this.MemberGet(pData, _ofs,    this, "DaylightBias", "Int")
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		return _Log.Exit()
	}
	;}}}
	
	;{{{ Get
	Get(ByRef pData) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		iLength := sizeof(TIME_ZONE_INFORMATION)
		_log.Finest("iLength = " iLength)
		VarSetCapacity(pData, iLength, 0)
		try {
			this.MemberSet(this.Bias,         pData, _ofs:=0, "Int")
			this.MemberSet(this.StandardName, pData, _ofs,    "wchar[32]")
			this.StructSet(this.StandardDate, pData, _ofs)
			this.MemberSet(this.StandardBias, pData, _ofs,    "Int")
			this.MemberSet(this.DaylightName, pData, _ofs,    "wchar[32]")
			this.StructSet(this.DaylightDate, pData, _ofs)
			this.MemberSet(this.DaylightBias, pData, _ofs,    "Int")
		} catch exInvalidDataType
			throw _log.Exit(exInvalidDataType)
			
		if (_log.Logs())
			_log.All("pData:`n" LoggingHelper.HexDump(&pData, 0, iLength))
			
		return _Log.Exit()
	}
	;}}}
}
;}}}

