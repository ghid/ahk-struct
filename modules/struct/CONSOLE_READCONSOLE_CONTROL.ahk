class CONSOLE_READCONSOLE_CONTROL extends Struct {

	size := 32

	nLength := 0
	nInitialChars := 0
	dwCtrlWakeupMask := 0
	dwControlKeyState := 0

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)
		this.nLength := sizeof(CONSOLE_READCONSOLE_CONTROL)

		return this
	}

	Set(ByRef pData) {
		this.MemberGet(pData, _ofs:=0, this, "nLength",           "UInt")
		this.MemberGet(pData, _ofs,    this, "nInitialChars",     "UInt")
		this.MemberGet(pData, _ofs,    this, "dwCtrlWakeupMask",  "UInt")
		this.MemberGet(pData, _ofs,    this, "dwControlKeyState", "UInt")
	}

	Get(ByRef pData) {
		nLength := sizeof(CONSOLE_READCONSOLE_CONTROL)
		VarSetCapacity(pData, nLength, 0)
		this.MemberSet(this.nLength,           pData, _ofs:=0, "UInt")
		this.MemberSet(this.nInitialChars,     pData, _ofs,    "UInt")
		this.MemberSet(this.dwCtrlWakeupMask,  pData, _ofs,    "UInt")
		this.MemberSet(this.dwControlKeyState, pData, _ofs,    "UInt")
	}
}
