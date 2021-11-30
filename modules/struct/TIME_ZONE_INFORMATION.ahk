#Include <modules\struct\SYSTEMTIME>

class TIME_ZONE_INFORMATION extends Struct {

	static size := 172

	Bias := 0
	StandardName := ""
	StandardDate := new SYSTEMTIME()
	StandardBias := 0
	DaylightName := ""
	DaylightDate := new SYSTEMTIME()
	DaylightBias := 0

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	Set(ByRef pData) {
		try {
			this.MemberGet(pData, _ofs:=0, this, "Bias",         "Int")
			this.MemberGet(pData, _ofs,    this, "StandardName", "wchar[32]")
			this.StructGet(pData, _ofs,	   this.StandardDate)
			this.MemberGet(pData, _ofs,    this, "StandardBias", "Int")
			this.MemberGet(pData, _ofs,    this, "DaylightName", "wchar[32]")
			this.StructGet(pData, _ofs,    this.DaylightDate)
			this.MemberGet(pData, _ofs,    this, "DaylightBias", "Int")
		} catch exInvalidDataType
			throw exInvalidDataType
	}

	Get(ByRef pData) {
		iLength := sizeof(TIME_ZONE_INFORMATION)
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
			throw exInvalidDataType
	}
}
