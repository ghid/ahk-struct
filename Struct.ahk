class Struct {
	
	StructGet(ByRef Target_Struct, ByRef Source, Source_Ofs) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (_Log.Logs("Input")) {
			_Log.Input("&Source", "&" &Source)
			if (_Log.Logs())
				_Log.All("`n" var_Hex_Dump(&Source, Source_Ofs, Len))
			_Log.Input("Source_Ofs", Source_Ofs)
		}
		
		Len := Target_Struct.Size
		_Log.Finer("Len = " Len)
		VarSetCapacity(Data, Len)
		DllCall("RtlMoveMemory", "Ptr", &Data, "Ptr", &Source+Source_Ofs, "UInt", Len)
		
		if (_Log.Logs())
			_Log.All("Data:`n" var_Hex_Dump(&Data, 0, Len))
			
		Target_Struct.Set(Data)
		
		return _Log.Exit(Len)
	}
	
}
