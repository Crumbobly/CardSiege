class_name FilesParser

static func enlistFiles(path: String, exclude: String = ".import") -> Array[String]:
	var dir: DirAccess = DirAccess.open(path)
	var fList: Array[String] = []
	var fileName: String
	
	if dir:
		dir.list_dir_begin()
		fileName = dir.get_next()
		
		while fileName != "":
			if !dir.current_is_dir() and !fileName.ends_with(exclude): 
				fList.append(path + fileName)
			fileName = dir.get_next()
	
	return fList
	

static func loadFiles(path: String) -> Array[Resource]:
	var files: Array[String] = enlistFiles(path)
	var preloadedFiles: Array[Resource] = []
	
	for file in files:
		preloadedFiles.append(load(file))
	
	return preloadedFiles
