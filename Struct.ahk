/*
:encoding=UTF-8:
*/

;{{{ Struct class
class Struct {
	
	;{{{ StructGet
	StructGet(ByRef pSource, ByRef pOffset, ByRef pTarget) {
		_log := new Logger("struct.class." A_ThisFunc)
		
		if (_log.Logs("Input")) {
			_log.Input("&pSource", &pSource)
			if (_log.Logs())
				_log.All("pSource:`n" var_Hex_Dump(&pSource, pOffset, pTarget.Size))
			_log.Input("pOffset", pOffset)
			_log.Input("pTarget", pTarget)
		}
		
		iLength := pTarget.Size
		_log.Finer("iLength = " iLength)
		VarSetCapacity(_data, iLength)
		DllCall("RtlMoveMemory", "Ptr", &_data, "Ptr", &pSource+pOffset, "UInt", iLength)
		
		if (_log.Logs())
			_log.All("_data:`n" var_Hex_Dump(&_data, 0, iLength))
			
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
				_log.All("pSource:`n" var_Hex_Dump(&pSource, pOffset, sizeof(pDataType)))
			_log.Input("pOffset", pOffset)
			_log.Input("pTarget", pTarget)
			_log.Input("pKey", pKey)
			_log.Input("pDataType", pDataType)
		}
		
		_value := ""
		if ((_length := sizeof(pDataType)) > 0) {
			pTarget.Insert(pKey, _value := NumGet(pSource, pOffset, pDataType))
			pOffset += _length
		} else if (RegExMatch(pDataType, "iO)(?P<Wide>w)?\w+\[(?P<Size>\d+)\]", _data)) {
			if (_log.Logs(Logger.Finest)) {
				_log.Finest("_data.Wide = " _data.Wide)
				_log.Finest("_data.Size = " _data.Size)
				if (_log.Logs(Logger.All))
					_log.All("pSource:`n" var_Hex_Dump(&pSource, pOffset, (_data.Wide = "w" ? 2 : 1) * _data.Size))
			}
			_value := StrGet(&pSource+pOffset, _data.Size)
			pTarget.Insert(pKey, _value)
			pOffset += ((_data.Wide = "w" ? 2 : 1) * _data.Size)
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
				_log.All("pSource:`n" var_Hex_Dump(&pSource, 0, pSource.Size))
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
		} else
			throw _log.Exit(Exception("Invalid data type: " pDataType))
		
		return _log.Exit()
	}
	;}}}
}
;}}}

;{{{ sizeof
sizeof(pType) {
	if (IsObject(pType) && pType.Base.__Class = "Struct")
		return pType.Size
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

