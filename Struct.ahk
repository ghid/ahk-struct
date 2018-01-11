/*
:encoding=UTF-8:
*/

;{{{ Struct class
class Struct {

	__New(ByRef pData) {
		_log := new Logger("class." A_ThisFunc)
		
		if (_log.Logs(Logger.Input)) {
			_log.Input("pData", pData)
		}
		
		return _log.Exit(this)
	}
	
	;{{{ StructGet
	StructGet(ByRef pSource, ByRef pOffset, ByRef pTarget) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&pSource", &pSource)
			if (_log.Logs())
				_log.All("pSource:`n" LoggingHelper.HexDump(&pSource, pOffset, pTarget.Size))
			_log.Input("pOffset", pOffset)
			_log.Input("pTarget", pTarget)
		}
		
		iLength := pTarget.Size
		_log.Finer("iLength = " iLength)
		VarSetCapacity(_data, iLength)
		DllCall("RtlMoveMemory", "Ptr", &_data, "Ptr", &pSource+pOffset, "UInt", iLength)
		
		if (_log.Logs())
			_log.All("_data:`n" LoggingHelper.HexDump(&_data, 0, iLength))
			
		pTarget.Set(_data)
		pOffset += iLength
		
		return _log.Exit()
	}
	;}}}
	
	;{{{ MemberGet
	MemberGet(ByRef pSource, ByRef pOffset, ByRef pTarget, pKey, pDataType) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&pSource", &pSource)
			if (_log.Logs("All") && sizeof(pDataType) > 0)
				_log.All("pSource:`n" LoggingHelper.HexDump(&pSource, pOffset, sizeof(pDataType)))
			_log.Input("pOffset", pOffset)
			_log.Input("pTarget", pTarget)
			_log.Input("pKey", pKey)
			_log.Input("pDataType", pDataType)
		}
		
		_value := ""
		if ((_length := sizeof(pDataType)) > 0) {
			pTarget.Insert(pKey, _value := NumGet(pSource, pOffset, pDataType))
			if (_log.Logs(Logger.Finest)) {
				_log.Finest(pKey " = " _value)
				_log.Finest("_length", _length)
			}
			pOffset += _length
		} else if (RegExMatch(pDataType, "iO)(?P<Wide>w)?\w+\[(?P<Size>\d+)\]", _data)) {
			if (_log.Logs(Logger.Finest)) {
				_log.Finest("_data.Wide = " _data.Wide)
				_log.Finest("_data.Size = " _data.Size)
				if (_log.Logs(Logger.All))
					_log.All("pSource:`n" LoggingHelper.HexDump(&pSource, pOffset, (_data.Wide = "w" ? 2 : 1) * _data.Size))
			}
			_value := StrGet(&pSource+pOffset, _data.Size)
			pTarget.Insert(pKey, _value)
			if (_log.Logs(Logger.Finest))
				_log.Finest(pKey " = " _value)
			pOffset += ((_data.Wide = "w" ? 2 : 1) * _data.Size)
		} else if (pDataType = "Str") {
			_value := StrGet(&pSource+pOffset)
			pTarget.Insert(pKey, _value)
			pOffset += (StrLen(_value) + 1) * (A_IsUnicode ? 2 : 1)
		} else
			throw _log.Exit(Exception("Invalid data type: " pDataType))
			
		if (_log.Logs(Logger.Finest))
			_log.Finest("_value = " _value)
		
		return _log.Exit()
	}
	;}}}
	
	;{{{ StructSet
	StructSet(ByRef pSource, ByRef pTarget, ByRef pOffset) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&pSource", &pSource)
			if (_log.Logs())
				_log.All("pSource:`n" LoggingHelper.HexDump(&pSource, 0, pSource.Size))
			_log.Input("pTarget", pTarget)
			_log.Input("pOffset", pOffset)
		}

		pSource.Get(_data)
		
		iLength := pSource.Size
		_targetAddr := &pTarget+pOffset
		DllCall("RtlMoveMemory", "Ptr", _targetAddr, "Ptr", &_data, "UInt", iLength)

		pOffset += iLength		
		
		return _log.Exit()
	}
	;}}}
	
	;{{{ MemberSet
	MemberSet(pSource, ByRef pTarget, ByRef pOffset, pDataType) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("pSource", pSource)
			_log.Input("pTarget", pTarget)
			_log.Input("pOffset", pOffset)
			_log.Input("pDataType", pDataType)
		}
		
		if ((iLength := sizeof(pDataType)) > 0) {
			NumPut(pSource, pTarget, pOffset, pDataType)
			pOffset += iLength
		} else if (RegExMatch(pDataType, "iO)(?P<Wide>w)?\w+\[(?P<Size>\d+)\]", _data)) {
			if (_log.Logs(Logger.Finest)) {
				_log.Finest("_data.Wide = " _data.Wide)
				_log.Finest("_data.Size = " _data.Size)
			}
			StrPut(pSource, &pTarget+pOffset, _data.Size)
			pOffset += ((_data.Wide = "w" ? 2 : 1) * _data.Size)
		} else if (pDataType = "Str") {
			_strLen := (StrLen(pSource) + 1) * (A_IsUnicode ? 2 : 1)
			pSource .= Chr(0)
			if (_log.Logs(Logger.Finest)) {
				_log.Finest("_data.Length = " _strLen)
			}
			StrPut(pSource, &pTarget+pOffset, _strLen)
			pOffset += _strLen
		} else
			throw _log.Exit(Exception("Invalid data type for: " pDataType))
		
		return _log.Exit()
	}
	;}}}
}
;}}}

;{{{ sizeof
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
;}}}

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
