# 목차

#### Overview
#### Code review
#### Options
#### item3
#### item4

# Overview

Test-Env : Ubuntu 18.04

Draft : 2020.06.11

작성자 : dbwodlf3@naver.com

mcsema-lift 툴을 사용하는데 필요한 많은 정보들이 해당파일내에 주석으로 표시되어 있기에 확인해볼 필요가 있다.

# Code review

gflags를 사용하여 CLI 를 제공한다.

glog를 사용하여 디버깅한다.
```
```

# Options

## add_breakpoints
#### example
```
mcsema-lift-9.0 --add_breakpoints ~~
```

모든 lifting된 instruction에 대해서 breakpoint를 inject 한다.

## add_reg_tracer
#### example
```
mcsema-lift-9.0 --add_reg_tracer
```

## disable_optimizer
#### example
```
mcsema-lift-9.0 --disable_optimizer
```

## keep_memops
#### example
```
```

## explicit_args
#### example

## abi_libraries
#### example

## pc_annotation
####

## legacy_mode
####

## list-supported
#### example

## exception_personality_func
#### example

## --version
#### example
