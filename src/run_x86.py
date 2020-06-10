#!/usr/bin/env python
# -*- coding: utf-8 -*- 

"""run x86

this code.

"""

import os
import sys

def debugingPrint(*args):
	for i in args:
		print(i)

def help():
	""" print usage """
	
	print("Usage")
	print("")
	print("    python run_x86.py <path-to-source>")
	print("")
	print("Example")
	print("")
	print("    python run_x86.py ./smc1/smc1.x86.s")
	return 0

def main():
	# Validation
	ARG_LEN = len(sys.argv)-1
	if ARG_LEN > 1  or ARG_LEN < 1:
		help()
		return 1

	# run
	ASM_FILE_PATH = sys.argv[-1]
	ASM_FILE = os.path.basename(ASM_FILE_PATH)
	ASM_DEST = os.path.join(os.path.dirname(ASM_FILE_PATH), ".dest")
	ASM_OBJ = os.path.join(ASM_DEST, ASM_FILE[:-2]+".o")
	ASM_EXE = os.path.join(ASM_DEST, ASM_FILE[:-2])

	os.system("mkdir -p {}".format(ASM_DEST))
	os.system("nasm -felf32 {} -o {}".format(ASM_FILE_PATH, ASM_OBJ))
	os.system("ld -m elf_i386 --omagic {} -o {}".format(ASM_OBJ, ASM_EXE))
	os.system("{}".format(ASM_EXE))

	return 0

if __name__ == "__main__":
	main()