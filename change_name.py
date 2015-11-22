import os

dirs = os.listdir('.')
for dirpath in dirs:
	if not os.path.isdir(dirpath) or '.' in dirpath:
		continue
	files = os.listdir(dirpath)
	for filename in files:
		if filename[0] == '.':
			continue
		entityname = filename.replace('.vhd', '')
		print entityname
		with open(dirpath + '/' + filename) as vhdfile:
			content = vhdfile.read().replace('controlUnit', entityname)
		with open(dirpath + '/' + filename, 'w') as vhdfile:
			vhdfile.write(content)