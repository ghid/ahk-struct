;{{{ Coord
/*
typedef struct _COORD {
  SHORT X;
  SHORT Y;
} COORD, *PCOORD;
*/
class COORD {
	static Size := 4
	X := 0
	Y := 0
	
	;{{{ __New
	__New(ByRef Data = "") {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (Data)
			This.Set(Data)

		_Log.Exit(This)
	}
	;}}}
	
	;{{{ Set
	Set(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		if (_Log.Logs())
			_Log.All("Data:`n" var_Hex_Dump(&Data, 0, COORD.Size))
			
		This.X := NumGet(Data, Ofs:=0, "Short")
		This.Y := NumGet(Data, Ofs+=2, "Short")
		if (_Log.Logs("Finest")) {
			_Log.Finest("X = " This.X)
			_Log.Finest("Y = " This.Y)
		}

		return _Log.Exit()
	}
	;}}}

	;{{{ Get
	Get(ByRef Data) {
		_Log := new Logger("struct.class." A_ThisFunc)
		
		VarSetCapacity(Data, 4, 0)
		NumPut(This.X, Data, Ofs:=0, "Short")
		NumPut(This.Y, Data, Ofs+=2, "Short")
		
		if (_Log.Logs())
			_Log.All("Data:`n" var_Hex_Dump(&Data, 0, COORD.Size))
		
		return _Log.Exit(COORD.Size)
	}
	;}}}
}
;}}}

