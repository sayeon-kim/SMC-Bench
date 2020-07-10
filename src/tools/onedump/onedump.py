import os
import sys
import subprocess

if "--help" in sys.argv[1:]:
	print("onedump.")
	print("\tThis Program lifts just one instruction to bytes")
	print("Usage.")
	print('\tpython3 onedump.py --arch x86 --inst "mov eax, 1"')
	exit()

if "--inst" in sys.argv[1:]:
	target = sys.argv[sys.argv.index("--inst")+1]
else:
	raise Exception('Write Instruction. like python3 onedump.py --arch amd64 --inst "mov eax, 1"')

if "--arch" in sys.argv[1:]:
	target_arch = sys.argv[sys.argv.index("--arch")+1]
else:
	raise Exception("Select arch. amd64 or x86")
if target_arch == "amd64":
	target_arch = "-felf64"
elif target_arch == "x86":
	target_arch = "-felf32"

def getTarget():
	print(target)

"""
make file
"""
temp_file_name = ".onedump.temp.s"
temp_object_file_name = ".onedump.temp.o"
temp_file_w = open(temp_file_name, "w")
temp_file_wt = open(temp_file_name, "wt")

subprocess.call(["echo", "section .text"], stdout=temp_file_wt) # echo "section .text" > .onedump.temp.txt
subprocess.call(["echo", "_start:"], stdout=temp_file_wt) # echo "section .text" >> .onedump.temp.txt
subprocess.call(["echo", target], stdout=temp_file_wt)

temp_file_w.close()
temp_file_wt.close()

subprocess.call(["nasm", target_arch, temp_file_name, "-o", temp_object_file_name]) # echo "section .text" > .onedump.temp.txt


"""
readelf -S .onedump.temp.o | awk
"""

o3 = subprocess.Popen(['objdump', '-d', temp_object_file_name], stdout=subprocess.PIPE)
o4 = subprocess.Popen(['tail', '-n', '+8'], stdin=o3.stdout, stdout=subprocess.PIPE)
o3.stdout.close()
text_bytes, err = o4.communicate()

subprocess.call(['rm', temp_file_name, temp_object_file_name])

print(text_bytes.decode('utf-8'))