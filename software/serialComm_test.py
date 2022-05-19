import serial
import os

class mySer():

	baudrate = 9600
	parity = 'N'
	bytesize = 8
	stopbits = 1
	timeout = None
	cwd = os.getcwd()

	def __init__(self):
		pass

	def gen_mem_file(self, mem_size, mem_file_name='mem_file.txt'):
		
		mem_file = mySer.cwd+'/'+mem_file_name
		f = open(mem_file, 'w')
		for i in range(0, mem_size):
			get_bin = lambda x : format(x, 'b').zfill(mySer.bytesize)
			b = get_bin(i)
			f.write(b)
			f.write('\n')
		f.close()

	def open_serial_port(self, port):
		self.ser = serial.Serial(port=port, baudrate=mySer.baudrate, parity=mySer.parity, stopbits=mySer.stopbits, bytesize=mySer.bytesize, timeout=mySer.timeout)


	def transmit_serial(self, data):
		self.ser.write(str.encode(data))

	def receive_serial(self, bytes):
		self.rx_data = self.ser.read(bytes)
		return self.rx_data 

def dec_2_bin(num):
	# if num >= 1:
	# 	bin_val = dec_2_bin(num // 2)
	# 	return (num % 2)
	decimal = int(num)
	binary = 0
	cntr = 0
	tmp = decimal

	while(tmp > 0):
		binary = ((tmp%2)*(10**cntr)) + binary
		tmp = int(tmp/2)
		cntr += 1

	return binary

def process_rx_in(file_loc):
	i = 0
	j = 0
	f = open(file_loc, 'r')
	my_file_lines = f.read()
	my_file_lines = my_file_lines.split('\n')
	# print(my_file_lines)
	while (i <= 55):

		if (j == 0):
			val = dec_2_bin(my_file_lines[i])
			j += 1
			i += 1
		elif (j <= 7):
			val += dec_2_bin(my_file_lines[i])
			j += 1
			i += 1
		else:
			j = 0
			i = i
			print(val)

	# 	val = []
	# 	j = 0
	# 	while(j <= 7):
	# 		val += my_file_lines[i+j]
	# 		j += 1
	# 	i += 1
	# 	print(val)

	return 0



if __name__== "__main__":
	mem_size=5
	s_site_id = 'Slave Site'
	m_site_id = 'Master Site'
	id_lst = [s_site_id+' Time Stamp T2S\t: ', m_site_id+' Time Stamp T1M\t: ', s_site_id+' Time Stamp T3S\t: ', m_site_id+' Time Stamp T4M\t: ', 'Delta Cmputed (Offset)\t\t: ', 'None\t\t\t\t\t\t: ']
	s = mySer()
	s.open_serial_port('/dev/ttyUSB0')
	r = s.receive_serial((mem_size*64))
	##print(r)

	i = 0
	path = os.getcwd()
	f = open(path+'/rx_in.txt', 'w')
	while(i <= (mem_size * 64)):
		# f.write(str(bin(r[i]))
		# write_string = str(id_lst[i]) + str(r[i])
		# f.write(write_string)
		f.write(str(r[i]))
		f.write("\n")
		i += 1
	f.close()
	# process_rx_in(path+'/rx_in.txt')