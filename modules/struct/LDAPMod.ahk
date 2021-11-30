class LDAPMod extends Struct {

	static ADD := 0x00
		 , DELETE := 0x01
		 , REPLACE := 0x02
		 , BVALUES := 0x80

	static size := 4 + A_PtrSize

	mod_op := 0
	mod_type := ""
	mod_vals := 0
	p_mod_vals := 0

	__New(ByRef pData = "") {
		if (pData <> "" || VarSetCapacity(pData))
			this.Set(pData)

		return this
	}

	Set(ByRef pData) {
		OutputDebug % "+++ " NumGet(pData, 10, "Ptr").AsHex()
		OutputDebug % "+++" LoggingHelper.Dump(System.PtrListToStrArray(NumGet(pData, 10, "Ptr")))

		this.MemberGet(pData, _ofs:=0, this, "mod_op", "UInt")
		this.MemberGet(pData, _ofs,    this, "mod_type", "Str")
		this.MemberGet(pData, _ofs,    this, "p_mod_vals", "Ptr")
		this.mod_vals := System.PtrListToStrArray(this.p_mod_vals)
	}

	Get(ByRef pData) {
		iLength := sizeof(LDAPMod) + ((StrLen(this.mod_type) + 1) * (A_IsUnicode ? 2 : 1))
		this.size := VarSetCapacity(pData, iLength, 0)
		this.MemberSet(this.mod_op, pData, _ofs:=0, "UInt")
		this.MemberSet(this.mod_type, pData, _ofs, "Str")
		System.StrArrayToPtrList(this.mod_vals, p_mod_vals)
		this.MemberSet(&p_mod_vals, pData, _ofs, "Ptr")

		return iLength
	}
}
; vim: ts=4:sts=4:sw=4:tw=0:noet
