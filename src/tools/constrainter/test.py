#!/usr/bin/python3

import os, argparse
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument("testWay",help="0: compile & test Pass\n1: compile\n2:test Pass")

args = parser.parse_args()

# Configure Variable
dir_path = os.path.dirname(os.path.abspath(__file__))

# Compile
def compile():
	p1 = subprocess.Popen(["cmake", ".", "-B./dest"], stdout=subprocess.PIPE)
	text_bytes, err = p1.communicate()
	print(text_bytes.decode('utf-8'))

	p2 = subprocess.Popen(["cmake", "--build", "./dest"], stdout=subprocess.PIPE)
	text_bytes, err = p2.communicate()
	print(text_bytes.decode('utf-8'))

def test():
	p1 = subprocess.Popen()

if args.testWay == "0":
	compile()
if args.testWay == "1":
	compile()
if args.testWay == "2":
	test()