#include <struct\struct>

class STARTUPINFO extends Struct {

	static size := Func("STARTUPINFO.SizeOf")

	cb				:= 0
	lpReserved		:= ""
	lpDesktop		:= ""
	lpTitle			:= ""
	dwX				:= 0
	dwY				:= 0
	dwXSize			:= 0
	dwYSize			:= 0
	dwXCountChars	:= 0
	dwYCountChars	:= 0
	dwFillAttribute	:= 0
	dwFlags			:= 0
	wShowWindow		:= 0
	cbReserved2		:= 0
	lpReserved2		:= 0
	hStdInput		:= 0
	hStdOutput		:= 0
	hStdError		:= 0

	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	SizeOf() {
		return (A_PtrSize == 4 ? 68 : 96)
	}

	Set(ByRef pData) {
		try {
			this.MemberGet(pData, _ofs:=0	, this, "cb"				, C.DWORD)
			this.MemberGet(pData, _ofs   	, this, "lpReserved"		, C.LPTSTR)
			this.MemberGet(pData, _ofs		, this, "lpDesktop"			, C.LPTSTR)
			this.MemberGet(pData, _ofs		, this, "lpTitle"			, C.LPTSTR)
			this.MemberGet(pData, _ofs		, this, "dwX"				, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwY"				, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwXSize"			, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwYSize"			, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwXCountChars"		, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwYCountChars"		, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwFillAttribute"	, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwFlags"			, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "wShowWindow"		, C.WORD)
			this.MemberGet(pData, _ofs		, this, "cbReserved2"		, C.WORD)
			this.MemberGet(pData, _ofs		, this, "hStdInput"			, C.HANDLE)
			this.MemberGet(pData, _ofs		, this, "hStdOutput"		, C.HANDLE)
			this.MemberGet(pData, _ofs		, this, "hStdError"			, C.HANDLE)
		} catch exInvalidDataType
			throw exInvalidDataType
	}

	Get(ByRef pData) {
		iLength := sizeof(STARTUPINFO)
		VarSetCapacity(pData, iLength, 0)
		try {
			this.MemberSet(this.cb				, pData, _ofs:=0	, C.DWORD)
			this.MemberSet(this.lpReserved		, pData, _ofs		, C.LPTSTR)
			this.MemberSet(this.lpDesktop		, pData, _ofs		, C.LPTSTR)
			this.MemberSet(this.lpTitle			, pData, _ofs		, C.LPTSTR)
			this.MemberSet(this.dwX				, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwY				, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwXSize			, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwYSize			, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwXCountChars	, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwYCountChars	, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwFillAttribute	, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwFlags			, pData, _ofs		, C.DWORD)
			this.MemberSet(this.wShowWindow		, pData, _ofs		, C.WORD)
			this.MemberSet(this.cbReserved2		, pData, _ofs		, C.WORD)
			this.MemberSet(this.hStdInput		, pData, _ofs		, C.HANDLE)
			this.MemberSet(this.hStdOutput		, pData, _ofs		, C.HANDLE)
			this.MemberSet(this.hStdError		, pData, _ofs		, C.HANDLE)
		} catch exInvalidDataType
			throw exInvalidDataType
		return _ofs + 1
	}
}
