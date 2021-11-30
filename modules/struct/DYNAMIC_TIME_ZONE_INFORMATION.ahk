#Include <modules\struct\SYSTEMTIME>

class DYNAMIC_TIME_ZONE_INFORMATION extends Struct {

	static size := 301

	bias := 0
	standardName := ""
	standardDate := new SYSTEMTIME()
	standardBias := 0
	daylightName := ""
	daylightDate := new SYSTEMTIME()
	daylightBias := 0
	timeZoneKeyName := ""
	dynamicDayLightTimeDisabled := false

	__New(ByRef data="") {
		if (data != "") {
			this.set(data)
		}
		return this
	}

	set(ByRef data) {
		try {
			this.memberGet(data, _ofs:=0, this, "bias",         "Int")
			this.memberGet(data, _ofs,    this, "standardName", "wchar[32]")
			this.structGet(data, _ofs,	   this.standardDate)
			this.memberGet(data, _ofs,    this, "standardBias", "Int")
			this.memberGet(data, _ofs,    this, "daylightName", "wchar[32]")
			this.structGet(data, _ofs,    this.daylightDate)
			this.memberGet(data, _ofs,    this, "daylightBias", "Int")
			this.memberGet(data, _ofs,    this
					, "timeZoneKeyName", "wchar[128]")
			this.memberGet(data, _ofs,    this
					, "dynamicDayLightTimeDisabled", "UChar")
		} catch exInvalidDataType {
			throw exInvalidDataType
		}
	}

	get(ByRef data) {
		iLength := sizeof(DYNAMIC_TIME_ZONE_INFORMATION)
		VarSetCapacity(data, iLength, 0)
		try {
			this.memberSet(this.bias,         data, _ofs:=0, "Int")
			this.memberSet(this.standardName, data, _ofs,    "wchar[32]")
			this.structSet(this.standardDate, data, _ofs)
			this.memberSet(this.standardBias, data, _ofs,    "Int")
			this.memberSet(this.daylightName, data, _ofs,    "wchar[32]")
			this.structSet(this.daylightDate, data, _ofs)
			this.memberSet(this.daylightBias, data, _ofs,    "Int")
			this.memberSet(this.timeZoneKeyName, data, _ofs, "wchar[128]")
			this.memberSet(this.dynamicDayLightTimeDisabled
					, data, _ofs, "UChar")
		} catch exInvalidDataType {
			throw exInvalidDataType
		}
	}
}
