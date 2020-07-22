#!/usr/bin/env python
# -*- coding: utf-8 -*- 

import os
import sys

# Config
cfgTool = "mcsema-disass --disassembler /opt/ida-7.1/idat64" 
lifterTool = "mcsema-lift-9.0"
llvmDisTool = "llvm-dis"
compileTool = "clang-9"
lifterRuntimeAMD64 = "/usr/local/lib/libmcsema_rt64-9.0.a"
lifterRuntimeX86 = "/usr/local/lib/libmcsema_rt32-9.0.a"
linkerTool = "ld"

ARCH = "amd64"
COMPILE_TARGET = ["x86_64","unknown","linux","gnu"]
ENTRY_POINT = "main"
OS = "linux"

FULL_PATH = ""
TARGET_FILE_PATH = ""
TARGET_FILE = ""
TARGET_DEST = ""

OBJ_FILE = ""
BINARY_FILE = ""
BINARY_FILE_NEW = ""

CFG_FILE = ""
LOG_FILE = ""
BC_FILE = ""
LL_FILE = ""

def help():
	""" print usage """
	
	print("Usage")
	print("")
	print("    python3 lifting.py --compile <path-to-target> --arch <x86|amd64>")
	print("    python3 lifting.py --recompile <path-to-target> --arch <x86|amd64>")
	print("    python3 lifting.py --lift <path-to-target> --arch <x86|amd64>")
	print("    python3 lifting.py --ll <path-to-target>")
	print("")
	print("Example")
	print("")
	print("    python3 lifting.py --compile ./helloWorld/helloWorld.c --arch x86")
	print("    python3 lifting.py --lift ./helloWorld/helloWorld.x86.out --arch x86")
	print("    python3 lifting.py --ll ./helloWorld/helloWorld.x86.bc")
	print("    python3 lifting.py --recompile ./helloWorld/helloWorld.x86.bc --arch x86")
	print("")
	print("    python3 lifting.py --compile ./helloWorld/helloWorld.c --arch amd64")
	print("    python3 lifting.py --lift ./helloWorld/helloWorld.amd64.out --arch amd64")
	print("    python3 lifting.py --ll ./helloWorld/helloWorld.amd64.bc")
	print("    python3 lifting.py --recompile ./helloWorld/helloWorld.amd64.bc --arch amd64")
	return 0

def getTargetFilePath(inputString):
	return os.path.dirname(inputString)

def getTargetFile(inputString):
	fileName = os.path.basename(inputString)
	if ''.join(fileName.split(".")[:-1]) == "":
		return fileName
	else:
		return '.'.join(fileName.split(".")[:-1])

def makeABILibrary():
	# "clang-9 -S -emit-llvm "
	pass

def updateTarget(inputString):
	global FULL_PATH, TARGET_FILE_PATH, TARGET_FILE, OBJ_FILE, BINARY_FILE, CFG_FILE, BC_FILE, LOG_FILE, TARGET_DEST, LL_FILE, BINARY_FILE_NEW
	FULL_PATH = inputString
	
	TARGET_FILE_PATH = getTargetFilePath(FULL_PATH)
	TARGET_FILE = getTargetFile(FULL_PATH)
	TARGET_DEST = TARGET_FILE_PATH

	if ARCH == "x86":
		BINARY_FILE_NEW = os.path.join(TARGET_DEST, TARGET_FILE+".new.out")
		BINARY_FILE = os.path.join(TARGET_DEST, TARGET_FILE+".x86.out")
		OBJ_FILE = os.path.join(TARGET_DEST, TARGET_FILE+".x86.o")
	elif ARCH == "amd64":
		BINARY_FILE_NEW = os.path.join(TARGET_DEST, TARGET_FILE+".new.out")
		BINARY_FILE = os.path.join(TARGET_DEST, TARGET_FILE+".amd64.out")
		OBJ_FILE = os.path.join(TARGET_DEST, TARGET_FILE+".amd64.o")

	CFG_FILE = os.path.join(TARGET_DEST, TARGET_FILE + ".cfg")
	BC_FILE = os.path.join(TARGET_DEST, TARGET_FILE + ".bc")
	LOG_FILE = os.path.join(TARGET_DEST, TARGET_FILE + ".log")
	LL_FILE = os.path.join(TARGET_DEST, TARGET_FILE + ".ll")

def main():
	global ARCH, ENTRY_POINT, OS, COMPILE_TARGET

	#Validation
	## to do something.

	# print help
	ARG_LEN = len(sys.argv)-1
	if ARG_LEN < 1:
		help()
		return 1
	for i in sys.argv[1:]:
		if i == "--help":
			help()
			return 1
	# config
	if "--arch" in sys.argv[1:]:
		ARCH = sys.argv[sys.argv.index("--arch")+1]
		if ARCH == "amd64":
			ARCH_TEMP = "x86_64"
		elif ARCH == "x86":
			ARCH_TEMP = "i386"
		COMPILE_TARGET[0] = f"{ARCH_TEMP}"

	if "--os" in sys.argv[1:]:
		OS = sys.argv[sys.argv.index("--os")+1]
		if OS == "win32":
			print(f"Not yet, this script don't suuport {OS}")
		elif OS == "win64":
			print(f"Not yet, this script don't suuport {OS}")
		COMPILE_TARGET[2] = OS
		

	# run
	if "--compile" in sys.argv[1:]:
		updateTarget(sys.argv[sys.argv.index("--compile")+1])
		os.system(f"mkdir -p {TARGET_DEST}")
		os.system(f"{compileTool} -c {FULL_PATH} -o {OBJ_FILE} -target {'-'.join(COMPILE_TARGET)} && {compileTool} {OBJ_FILE} -o {BINARY_FILE} -target {'-'.join(COMPILE_TARGET)}")
	
	if "--recompile" in sys.argv[1:]:
		updateTarget(sys.argv[sys.argv.index("--recompile")+1])
		os.system(f"mkdir -p {TARGET_DEST}")
		if ARCH == "amd64":

			os.system(f"{compileTool} {FULL_PATH} {lifterRuntimeAMD64} -o {BINARY_FILE_NEW} -target {'-'.join(COMPILE_TARGET)}")
		elif ARCH == "x86":
			os.system(f"{compileTool} {FULL_PATH} {lifterRuntimeX86} -o {BINARY_FILE_NEW} -target {'-'.join(COMPILE_TARGET)}")

	if "--lift" in sys.argv[1:]:
		updateTarget(sys.argv[sys.argv.index("--lift")+1])
		os.system(f"mkdir -p {TARGET_DEST}")
		os.system(f"{cfgTool} --os {OS} --arch {ARCH} --entrypoint {ENTRY_POINT} --binary {FULL_PATH} --output {CFG_FILE} --log_file {LOG_FILE}")
		os.system(f"{lifterTool} --os {OS} --arch {ARCH} --cfg {CFG_FILE} --output {BC_FILE}")

	if "--ll" in sys.argv[1:]:
		updateTarget(sys.argv[sys.argv.index("--ll")+1])
		os.system(f"mkdir -p {TARGET_DEST}")
		os.system(f"{llvmDisTool} {FULL_PATH} -o {LL_FILE}")

	return 0

if __name__ == "__main__":
	main()

# clang-9 -rdynamic -o# -g a.c -o a
# mcsema-disass --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary a.out --output a.cfg --log_file a.log
# mcsema-lift-9.0 --os linux --arch amd64 --cfg a.cfg --output a.bc
# llvm-dis a.bc -o a.ll
# clang-9 -o a.new a.bc /usr/local/lib/libmcsema_rt64-9.0.a