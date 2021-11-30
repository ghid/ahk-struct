class  LDAPAPIInfo {

	requires() {
		return [System]
	}

	static size := 24

	ldapai_info_version := 0
	ldapai_api_version:= 0
	ldapai_protocol_version := 0
	ldapai_extensions := []
	ldapai_vendor_name := ""
	ldapai_vendor_version := 0

	exts := 0

	__New(ByRef bytes) {
		LDAPAPIInfo.size := 16+(2*A_PtrSize)

		this.Set(bytes)

		return this
	}

	set(ByRef bytes) {
		this.ldapai_info_version := NumGet(bytes, 0, "uint")
		this.ldapai_api_version := NumGet(bytes, 4, "uint")
		this.ldapai_protocol_version := NumGet(bytes, 8, "uint")
		this.ldapai_extensions := System.PtrListToStrArray(NumGet(bytes, 12, "ptr"), false)
		this.ldapai_vendor_name := StrGet(NumGet(bytes, 16, "ptr"))
		this.ldapai_vendor_version := NumGet(bytes, 20, "uint")
	}

	get(ByRef bytes) {
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
	}
}
