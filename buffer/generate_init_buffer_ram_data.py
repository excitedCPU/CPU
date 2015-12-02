def char_to_bin(ch):
	bin_str = bin(ord(ch))[2:]
	return '0'*(7-len(bin_str)) + bin_str

def str_to_bin(string):
	ans = ''
	for ch in string:
		ans += char_to_bin(ch)
	return ans

print str_to_bin('6766')

with open('buffer_data.coe', 'w') as coe_file:
	coe_file.write('memory_initialization_radix=2;\nmemory_initialization_vector=\n')
	for looper in range(32):
		coe_file.write(str_to_bin(' ')*36 + '0000,\n')