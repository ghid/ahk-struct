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

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	Set(ByRef pData) {
		this.MemberGet(pData, _ofs:=0, this, "wYear",         "Short")
		this.MemberGet(pData, _ofs,    this, "wMonth",        "Short")
		this.MemberGet(pData, _ofs,    this, "wDayOfWeek",    "Short")
		this.MemberGet(pData, _ofs,    this, "wDay",          "Short")
		this.MemberGet(pData, _ofs,    this, "wHour",         "Short")
		this.MemberGet(pData, _ofs,    this, "wMinute",       "Short")
		this.MemberGet(pData, _ofs,    this, "wSecond",       "Short")
		this.MemberGet(pData, _ofs,    this, "wMilliseconds", "Short")
	}

	Get(ByRef pData) {
		iLength := sizeof(COORD)
		VarSetCapacity(pData, iLength, 0)
		this.MemberSet(this.wYear,         pData, _ofs:=0, "Short")
		this.MemberSet(this.wMonth,        pData, _ofs,    "Short")
		this.MemberSet(this.wDayOfWeek,    pData, _ofs,    "Short")
		this.MemberSet(this.wDay,          pData, _ofs,    "Short")
		this.MemberSet(this.wHour,         pData, _ofs,    "Short")
		this.MemberSet(this.wMinute,       pData, _ofs,    "Short")
		this.MemberSet(this.wSecond,       pData, _ofs,    "Short")
		this.MemberSet(this.wMilliseconds, pData, _ofs,    "Short")
	}
}
