import os
import subprocess
import sys

"""
Config
"""
remill_lift = "remill-lift-9.0"

"""
readelf -S {target}| grep "\W\.text" | awk '{print $0}'
"""
target = sys.argv[1]
if "--arch" in sys.argv[1:]:
	target_arch = sys.argv[sys.argv.index("--arch")+1]
else:
	raise Exception("Select arch. amd64 or x86")

if "--os" in sys.argv[1:]:
	target_os = sys.argv[sys.argv.index("--os")+1]
else:
	raise Exception("Select OS. linux or x86")

if "--output" in sys.argv[1:]:
	output_file = sys.argv[sys.argv.index("--output")+1]
else:
	raise Exception("Select output. filename")


o0 = subprocess.Popen(['readelf', '-S', target, '--wide'], stdout=subprocess.PIPE)
o1 = subprocess.Popen(['grep', '\W\.text'], stdin=o0.stdout, stdout=subprocess.PIPE)
o0.stdout.close()
#
#
# i writed hardcoding. it can be problem in future (but now is okay. anyway it works!)

o2 = subprocess.Popen(['awk', '{print $5"."$6"."$7}'], stdin=o1.stdout, stdout=subprocess.PIPE)
o1.stdout.close()
output, err = o2.communicate()
o2.stdout.close()
output_val = output.decode("utf-8").replace('\n','').split(".")

# These number is 0x..
text_start = "0x" + str(output_val[0]).lstrip('0')
text_off = "0x" + str(output_val[1]).lstrip('0')
text_size = "0x" + str(output_val[2]).lstrip('0')

print(text_off)

# hex_text_start = hex(text_start)
# hex_text_off = hex(text_off)
# hex_text_size = hex(text_size)
# hex_text_end = hex(text_end)

o3 = subprocess.Popen(['xxd', '-p', '-s', text_off, '-l', text_size, target], stdout=subprocess.PIPE)
text_bytes, err = o3.communicate()
text_bytes = text_bytes.decode("utf-8").replace('\n','')
o3.stdout.close()

print(text_bytes)

o4 = subprocess.Popen([remill_lift, "--os", target_os, "--arch", target_arch,"--bytes", text_bytes, "--ir_out", output_file], stdout=subprocess.PIPE)
o4.stdout.close()
