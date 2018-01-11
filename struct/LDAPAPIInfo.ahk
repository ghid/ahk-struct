#include <system>

/*
	typedef struct ldapapiinfo {
	  int  ldapai_info_version;
	  int  ldapai_api_version;
	  int  ldapai_protocol_version;
	  char **ldapai_extensions;
	  char *ldapai_vendor_name;
	  int  ldapai_vendor_version;
	} LDAPAPIInfo
*/

class  LDAPAPIInfo {

	static size := 24

	ldapai_info_version := 0
	ldapai_api_version:= 0
	ldapai_protocol_version := 0
	ldapai_extensions := []
	ldapai_vendor_name := ""
	ldapai_vendor_version := 0

	exts := 0

	__New(ByRef bytes) {
		_log := new Logger("class." A_ThisFunc)

		LDAPAPIInfo.size := 16+(2*A_PtrSize)

		this.Set(bytes)

		return _log.Exit(this)
	}

	set(ByRef bytes) {
		_log := new Logger("struct." A_ThisFunc)
		
		if (_log.Logs(Logger.All)) {
			_log.All("bytes:" LoggingHelper.HexDump(&bytes, 0, LDAPAPIInfo.size))
		}

		this.ldapai_info_version := NumGet(bytes, 0, "uint")
		this.ldapai_api_version := NumGet(bytes, 4, "uint")
		this.ldapai_protocol_version := NumGet(bytes, 8, "uint")
		this.ldapai_extensions := System.PtrListToStrArray(NumGet(bytes, 12, "ptr"), false)
		this.ldapai_vendor_name := StrGet(NumGet(bytes, 16, "ptr"))
		this.ldapai_vendor_version := NumGet(bytes, 20, "uint")

		if (_log.Logs(Logger.Finest)) {
			_log.Finest("this.ldapai_info_version", this.ldapai_info_version)
			_log.Finest("this.ldapai_api_version", this.ldapai_api_version)
			_log.Finest("this.ldapai_protocol_version", this.ldapai_protocol_version)
			_log.Finest("this.ldapai_extensions:" LoggingHelper.Dump(this.ldapai_extensions))
			_log.Finest("this.ldapai_vendor_name", this.ldapai_vendor_name)
			_log.Finest("this.ldapai_vendor_version", this.ldapai_vendor_version)
		}

		return _log.Exit()
	}

	get(ByRef bytes) {
		_log := new Logger("struct." A_ThisFunc)

		if (_log.Logs(Logger.Finest)) {
			_log.Finest("this.ldapai_info_version", this.ldapai_info_version)
			_log.Finest("this.ldapai_api_version", this.ldapai_api_version)
			_log.Finest("this.ldapai_protocol_version", this.ldapai_protocol_version)
			_log.Finest("this.ldapai_extensions:" LoggingHelper.Dump(this.ldapai_extensions))
			_log.Finest("this.ldapai_vendor_name", this.ldapai_vendor_name)
			_log.Finest("this.ldapai_vendor_version", this.ldapai_vendor_version)
		}

		VarSetCapacity(bytes, LDAPAPIInfo.size, 0)
		NumPut(this.ldapai_info_version, bytes, 0, "uint")
		NumPut(this.ldapai_api_version, bytes, 4, "uint")
		NumPut(this.ldapai_protocol_version, bytes, 8, "uint")
		p := 0
		System.StrArrayToPtrList(this.ldapai_extensions, p)
		this.exts := p
		NumPut(this.GetAddress("exts"), bytes, 12, "ptr")
		NumPut(this.GetAddress("ldapai_vendor_name"), bytes, 16, "ptr")
		NumPut(this.ldapai_vendor_version, bytes, 20, "uint")

		if (_log.Logs(Logger.All)) {
			_log.All("bytes:" LoggingHelper.HexDump(&bytes, 0, LDAPAPIInfo.size))
		}

		return _log.Exit()
	}
}

