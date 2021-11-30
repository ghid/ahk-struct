class COORD  extends Struct {

	static Size := 4

	X := 0
	Y := 0

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	Set(ByRef pData) {
		this.MemberGet(pData, _ofs:=0, this, "X", "Short")
		this.MemberGet(pData, _ofs,    this, "Y", "Short")
	}

	Get(ByRef pData) {
		iLength := sizeof(COORD)
		VarSetCapacity(pData, iLength, 0)
		this.MemberSet(this.X, pData, _ofs:=0, "Short")
		this.MemberSet(this.Y, pData, _ofs,    "Short")
	}
}
