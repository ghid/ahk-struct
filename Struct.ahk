class Struct {
	
	;{{{ StructGet
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
	;}}}

	FieldGet(ByRef Target_Field, ByRef Source, Source_Ofs, Data_Type) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (_Log.Logs("Input")) {
			_Log.Input("&Source", "&" &Source)
			if (_Log.Logs())
				_Log.All("`n" var_Hex_Dump(&Source, Source_Ofs, Len))
			_Log.Input("Source_Ofs", Source_Ofs)
			_Log.Input("Data_Type", Data_Type)
		}
		
		if Data_Type = Ptr
			Len := A_PtrSize
		else if Data_Type in Int64,Double
			Len := 8
		else if Data_Type in Int,UInt,Float
			Len := 4
		else if Data_Type in Short,UShort
			Len := 2
		else if Data_Type in Char,UChar
			Len := 1
		_Log.Finest("Len = " Len)

		Target_Field := NumGet(Source, Source_Ofs, Data_Type)
		
		_Log.Output("Target_Field", Target_Field)
		
		return _Log.Exit(Len)
	}
}
