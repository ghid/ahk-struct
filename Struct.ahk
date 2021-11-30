class Struct {

	__New(ByRef pData) {
		return this
	}

	StructGet(ByRef pSource, ByRef pOffset, ByRef pTarget) {
		iLength := pTarget.Size
		VarSetCapacity(_data, iLength)
		DllCall("RtlMoveMemory", "Ptr", &_data, "Ptr", &pSource+pOffset, "UInt", iLength)

		pTarget.Set(_data)
		pOffset += iLength
	}

	MemberGet(ByRef pSource, ByRef pOffset, ByRef pTarget, pKey, pDataType) {
		_value := ""
		if ((_length := sizeof(pDataType)) > 0) {
			pTarget.Insert(pKey, _value := NumGet(pSource, pOffset, pDataType))
			pOffset += _length
		} else if (RegExMatch(pDataType, "iO)(?P<Wide>w)?\w+\[(?P<Size>\d+)\]", _data)) {
			_value := StrGet(&pSource+pOffset, _data.Size)
			pTarget.Insert(pKey, _value)
			pOffset += ((_data.Wide = "w" ? 2 : 1) * _data.Size)
		} else if (pDataType = "Str") {
			_value := StrGet(&pSource+pOffset)
			pTarget.Insert(pKey, _value)
			pOffset += (StrLen(_value) + 1) * (A_IsUnicode ? 2 : 1)
		} else
			throw Exception("Invalid data type: " pDataType)
	}

	StructSet(ByRef pSource, ByRef pTarget, ByRef pOffset) {
		pSource.Get(_data)

		iLength := pSource.Size
		_targetAddr := &pTarget+pOffset
		DllCall("RtlMoveMemory", "Ptr", _targetAddr, "Ptr", &_data, "UInt", iLength)

		pOffset += iLength
	}

	MemberSet(pSource, ByRef pTarget, ByRef pOffset, pDataType) {
		if ((iLength := sizeof(pDataType)) > 0) {
			NumPut(pSource, pTarget, pOffset, pDataType)
			pOffset += iLength
		} else if (RegExMatch(pDataType, "iO)(?P<Wide>w)?\w+\[(?P<Size>\d+)\]", _data)) {
			StrPut(pSource, &pTarget+pOffset, _data.Size)
			pOffset += ((_data.Wide = "w" ? 2 : 1) * _data.Size)
		} else if (pDataType = "Str") {
			_strLen := (StrLen(pSource) + 1) * (A_IsUnicode ? 2 : 1)
			pSource .= Chr(0)
			StrPut(pSource, &pTarget+pOffset, _strLen)
			pOffset += _strLen
		} else
			throw Exception("Invalid data type for: " pDataType)
	}
}

sizeof(pType) {
	if (IsObject(pType) && pType.Base.__Class = "Struct")
		if (pType.Size <> -1)
			return pType.Size
		else
			return pType.SizeOf()
	else if pType = Ptr
		return A_PtrSize
	else if pType in Int64,Double
		return 8
	else if pType in Int,UInt,Float
		return 4
	else if pType in Short,UShort
		return 2
	else if pType in Char,UChar
		return 1

	return 0
}

class C {
	static DWORD	:= "UInt"
		 , HANDLE	:= "Ptr"
		 , LPBYTE	:= "Ptr"
		 , LPTSTR	:= "Str"
		 , WORD	    := "UShort"
		 , ULONG	:= "UInt"
		 , PWCHAR   := "StrW"
}
; vim: ts=4:sts=4:sw=4:tw=0:noet
