class SMALL_RECT extends Struct {

	static Size := 8

	Left   := 0
	Top    := 0
	Right  := 0
	Bottom := 0

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	Set(ByRef pData) {
		this.MemberGet(pData, _ofs:=0, this, "Left",   "Short")
		this.MemberGet(pData, _ofs,    this, "Top",    "Short")
		this.MemberGet(pData, _ofs,    this, "Right",  "Short")
		this.MemberGet(pData, _ofs,    this, "Bottom", "Short")
	}


	Get(ByRef pData) {
		iLength := sizeof(SMALL_RECT)
		VarSetCapacity(Data, iLength, 0)
		this.MemberSet(this.Left,   pData, _ofs:=0, "Short")
		this.MemberSet(this.Top,    pData, _ofs,    "Short")
		this.MemberSet(this.Right,  pData, _ofs,    "Short")
		this.MemberSet(this.Bottom, pData, _ofs,    "Short")
	}
}

