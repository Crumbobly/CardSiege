extends LineEdit

@export var regex_pattern: String = r"^[a-zA-Z0-9]+$"  

func validate() -> bool:
	var regex = RegEx.new()
	regex.compile(regex_pattern)
	
	return regex.search(text) != null or text != ""
