#!/usr/bin/env python
# -*- coding: utf-8 -*- 

# todo
## [ ] if file exists then skip phase. save time.
## [ ] make abi_libraries option.

"""do lifting

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
	print("    python lifting.py <path-to-source>")
	print("")
	print("Example")
	print("")
	print("    python lifting.py ./helloWorld/helloWorld.c")
	return 0

def makeABILibrary():
	# "clang-9 -S -emit-llvm "
	pass

def main():
	# Validation
	ARG_LEN = len(sys.argv)-1
	if ARG_LEN > 1  or ARG_LEN < 1:
		help()
		return 1

	# run

	## Exe BUILD VARIABLES
	SOURCE_FILE_PATH = sys.argv[-1]
	SOURCE_FILE = os.path.basename(SOURCE_FILE_PATH)
	TARGET_DEST = os.path.join(os.path.dirname(SOURCE_FILE_PATH), ".dest")
	OBJ_FILE = os.path.join(TARGET_DEST, SOURCE_FILE[:-2]+".o")
	BINARY_FILE = os.path.join(TARGET_DEST, SOURCE_FILE[:-2])

	## Make CFG VARIABLES
	CFG_FILE = os.path.join(TARGET_DEST, ''.join(SOURCE_FILE.split(".")[:-1]) + ".cfg")
	BC_FILE = os.path.join(TARGET_DEST, ''.join(SOURCE_FILE.split(".")[:-1]) + ".bc")
	LOG_FILE = os.path.join(TARGET_DEST, ''.join(SOURCE_FILE.split(".")[:-1]) + ".log")

	## LIFTING VARIABLES
	DISASSEMBLER = "/opt/ida-7.1/idat64"
	ARCH = "amd64"
	ENTRYPOINT = "main"
	ABI_FILE = os.path.abspath(os.path.join(os.path.dirname(SOURCE_FILE_PATH), ''.join(SOURCE_FILE.split(".")[:-1]) + ".abi.bc"))

	## Todo
	# LL_FILE = os.path.join(TARGET_DEST, ''.join(SOURCE_FILE.split(".")[:-1]) + ".ll")


	os.system("mkdir -p {}".format(TARGET_DEST))
	os.system("clang-9 {} -o {}".format(SOURCE_FILE_PATH, BINARY_FILE)) # make binary
	os.system("mcsema-disass --disassembler {} --os linux --arch {} --binary {} --output {} --entrypoint {} --log_file {}".format(DISASSEMBLER, ARCH, BINARY_FILE, CFG_FILE, ENTRYPOINT, LOG_FILE)) # make cfg
	os.system("mcsema-lift-9.0 --os linux --arch {} --cfg {} --output {} --abi_libraries {}".format(ARCH, CFG_FILE, BC_FILE, ABI_FILE)) # lift
	print("mcsema-lift-9.0 --os linux --arch {} --cfg {} --output {} --abi_libraries {}".format(ARCH, CFG_FILE, BC_FILE, ABI_FILE))
	return 0

if __name__ == "__main__":
	main()