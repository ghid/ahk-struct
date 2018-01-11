/*
typedef struct ldapmod {
  ULONG  mod_op;
  PWCHAR mod_type;
  union {
    PWCHAR        *modv_strvals;
    struct berval  **modv_bvals;
  } mod_vals;
} LDAPMod, *PLDAPMod;
*/

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
		_log := new Logger("struct.class." A_ThisFunc)

		if (_log.Logs(Logger.Finest)) {
			_log.Finest("pData", pData)
			_len := _log.Finest("_len", VarSetCapacity(pData))
			if (_log.Logs(Logger.All)) {
				_log.All("pData:`n" LoggingHelper.HexDump(&pData, 0, _len))
			}
		}

		if (pData <> "" || VarSetCapacity(pData))
			this.Set(pData)
		
		return _log.Exit(this)
	}

	Set(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs(Logger.Input)) {
			_log.Input("pData", pData)
			if (_log.Logs(Logger.All))
				_log.All("pData:`n" LoggingHelper.HexDump(pData, this.size))
		}

		OutputDebug % "+++ " NumGet(pData, 10, "Ptr").AsHex()
		OutputDebug % "+++" LoggingHelper.Dump(System.PtrListToStrArray(NumGet(pData, 10, "Ptr")))

		this.MemberGet(pData, _ofs:=0, this, "mod_op", "UInt")
		this.MemberGet(pData, _ofs,    this, "mod_type", "Str")
		this.MemberGet(pData, _ofs,    this, "p_mod_vals", "Ptr")
		this.mod_vals := System.PtrListToStrArray(this.p_mod_vals)
		if (_log.Logs(Logger.Finest)) {
			_log.Finest("this.mod_op", this.mod_op)
			_log.Finest("this.mod_type", this.mod_type)
			_log.Finest("this.mod_vals", this.mod_vals)
			if (_log.Logs(Logger.All))
				_log.All("this.mod_vals:`n" LoggingHelper.Dump(this.mod_vals))
		}
		if (_log.Logs(Logger.All)) {
			_log.All("pData:`n" LoggingHelper.HexDump(&pData, 0, sizeof(LDAPMod) + 1 + (StrLen(this.mod_type) * (A_IsUnicode ? 2 : 1))))
		}
		
		return _log.Exit()
	}

	Get(ByRef pData) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs(Logger.Finest)) {
			_log.Finest("this.mod_op", this.mod_op)
			_log.Finest("this.mod_type", this.mod_type)
			_log.Finest("this.mod_vals", this.mod_vals)
			if (_log.Logs(Logger.All))
				_log.All("this.mod_vals:`n" LoggingHelper.Dump(this.mod_vals))
		}
		iLength := sizeof(LDAPMod) + ((StrLen(this.mod_type) + 1) * (A_IsUnicode ? 2 : 1))
		this.size := VarSetCapacity(pData, iLength, 0)
		this.MemberSet(this.mod_op, pData, _ofs:=0, "UInt")
		this.MemberSet(this.mod_type, pData, _ofs, "Str")
		System.StrArrayToPtrList(this.mod_vals, p_mod_vals)
		this.MemberSet(&p_mod_vals, pData, _ofs, "Ptr")
		if (_log.Logs(Logger.All)) {
			_log.All("pData`n" LoggingHelper.HexDump(&pData, 0, iLength))
		}

		return _log.Exit(iLength)
	}
}

; vim: ts=4:sts=4:sw=4:tw=0:noet
