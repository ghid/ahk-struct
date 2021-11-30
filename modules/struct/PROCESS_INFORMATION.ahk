#include <struct\struct>

class PROCESS_INFORMATION extends Struct {

	static size = Func("PROCESS_INFORMATION.SizeOf")

	hProcess := 0
	hThread := 0
	dwProcessId := 0
	dwThreadId := 0

	;{{{ __New
	__New(ByRef pData = "") {
		if (pData <> "")
			this.Set(pData)

		return this
	}

	SizeOf() {
		return (A_PtrSize == 4 ? 16 : 24)
	}

	Set(ByRef pData) {
		try {
			this.MemberGet(pData, _ofs:=0	, this, "hProcess"		, C.HANDLE)
			this.MemberGet(pData, _ofs		, this, "hThread"		, C.HANDLE)
			this.MemberGet(pData, _ofs		, this, "dwProcessId"	, C.DWORD)
			this.MemberGet(pData, _ofs		, this, "dwThreadId"	, C.DWORD)
		} catch exInvalidDataType
			throw exInvalidDataType
	}

	Get(ByRef pData) {
		iLength := sizeof(PROCESS_INFORMATION)
		VarSetCapacity(pData, iLength, 0)
		try {
			this.MemberSet(this.hProcess	, pData, _ofs:=0	, C.HANDLE)
			this.MemberSet(this.hThread		, pData, _ofs		, C.HANDLE)
			this.MemberSet(this.dwProcessId	, pData, _ofs		, C.DWORD)
			this.MemberSet(this.dwThreadId	, pData, _ofs		, C.DWORD)
		} catch exInvalidDataType
			throw exInvalidDataType

		return _ofs + 1
	}
}
