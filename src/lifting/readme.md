# SMC Bench

## Lifting

#### Requirements

This codes assume your os is Ubuntu 18.04 and you already have  python, clang-9, llvm-dis-9, llvm-as-9, mcsema-lift-9.0

#### config
open lifting.py and edit config variables accroding to your environment
```python
cfgTool = "mcsema-disass --disassembler /opt/ida-7.1/idat64" 
lifterTool = "mcsema-lift-9.0"
llvmDisTool = "llvm-dis"
compileTool = "clang-9"
lifterRuntime = "/usr/local/lib/libmcsema_rt64-9.0.a"
```

#### usage

```bash
python3 lifting.py --help
python3 lifting.py --compile <target>
python3 lifting.py --lift <target>
python3 lifting.py --ll <target>
python3 lifting.py --recompile <target>

#default setting
ARCH = "amd64"
COMPILE_TARGET = ["x86_64","unknown","linux","gnu"]
ENTRY_POINT = "main"
OS = "linux"
```

#### Limitation

This script can use more than python 3.6 version, and only linux with some other tools.
