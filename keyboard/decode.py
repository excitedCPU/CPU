# encoding=utf8 
import sys 
reload(sys) 
sys.setdefaultencoding('utf8')


with open('KNController.vhd') as vhd_file:
	content = str(vhd_file.read()).decode('gbk').encode('gbk')
	print content
