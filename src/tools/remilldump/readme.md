---
Author: Yu JaeIL
Date: 2020-09-18
---

## EZ Way. Just use python script.
```bash
target=smc5.x86
python3 remilldump.py ${target}.o --os linux --arch x86 --output ${target}.ll
```

## Step By Step to get remill lift from target

### Step0. Compile a nasm file
```bash
target=smc5.x86
nasm -felf32 ${target}.s && ld -m elf_i386 --omagic ${target}.o -o ${target}
```

### Step1. Get instruction bytes range from ".text" Section.
```bash
bytes_off=$(readelf -S ${target} | grep "\W\.text" | awk '{print $6"\t"$7}' | awk '{print $1}' | sed 's/^0*//')
bytes_size=$(readelf -S ${target} | grep "\W\.text" | awk '{print $7"\t"$7}' | awk '{print $2}' | sed 's/^0*//')

bytes_off=$(printf  0x$bytes_off)
bytes_size=$(printf 0x$bytes_size)
```

### Step2. Get Bytes from target.
```bash
bytes=$(xxd -p -s ${bytes_off} -l ${bytes_size} ${target})
bytes=$(echo $bytes | sed 's/ //g')
```

### Step3. Use remill-lift
```bash
remill-lift-9.0 --arch x86 --bytes ${bytes_end} --ir_out /dev/stdout
```

## Refer
https://github.com/lifting-bits/remill/blob/master/tools/lift/Lift.cpp#L79

remill-lift just define address ordering as left to right.

## Check
```bash
readelf -S ${target}
objdump -D ${target}
xxd -p -s ${bytes_off} -l ${bytes_size} ${target}
echo $bytes_off
echo $bytes_size
```

# Description

This tool use python3, (remill-lift)[https://github.com/lifting-bits/remill/tree/master/tools/lift], readelf, awk, xxd, grep at linux 

# Usage
```bash
nasm -felf32 test.x86.s -o test.x86.o
python3 remilldump.py test.x86.o --arch x86 --os linux --output test.x86.ll
```

# Config
you can use different remill-lift version, when that, you need to edit your remill-lift path in remilldump.py.
```python
remill_lift = "your remill-lift path."
```

