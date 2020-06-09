# 목차

#### Overview

#### CmakeLists

#### Build

#### Usage

#### Conclusion

# Overview

Test-Env : Ubuntu 18.04 on Docker

Draft : 2020.05.25

작성자 : dbwodlf3@naver.com



# CmakeLIsts

```CMake
add_executable(${MCSEMA_LIFT}
  ${PROJECT_PROTOBUFSOURCEFILES}

  mcsema/Arch/ABI.cpp
  mcsema/Arch/Arch.cpp

  mcsema/CFG/CFG.cpp

  mcsema/BC/Callback.cpp
  mcsema/BC/External.cpp
  mcsema/BC/Function.cpp
  mcsema/BC/Instruction.cpp
  mcsema/BC/Legacy.cpp
  mcsema/BC/Lift.cpp
  mcsema/BC/Optimize.cpp
  mcsema/BC/Segment.cpp
  mcsema/BC/Util.cpp

  tools/mcsema_lift/Lift.cpp
)
```

tools/mcsema_lift/lift.cpp 가 driver 역할을 한다.

#### mcsema-lift

CFG 파일을 가지고, remill과 mcsema를 이용해서 실제로 byte code를 lifting 한다.

Cpp로 작성되어있다.

#### mcsema-disass

CFG 파일을 만드는 부분이다. Python 스크립트 코드로 작성되어 있고, setuptools 을 사용해서 바이너리 파일로 컴파일된다. 빌드는 CmakeLists에서 add_custom_command 명령어를 통해서 필요한 python 패키지를 설치하고, 빌드한다.

바이너리 파일에서 cfg 파일을 만들어내는 프로그램에 의존적이다. 사실상 third party library 모양새다. binary ninja, ida7, Dyninst 세프로그램의 API를 사용하여 각각 구현되었다.

빌드시 옵션을 통해서 어떤 프로그램을 쓸건지 지정할 수 있다. 디폴트는 ida7 이고, mcsema도 main-stream 으로 개발하고 있는 것은 ida7이다.(ida7이 업데이트가 제일 빠르다.)

# Build 

mcsema의 빌드는 remill에 의존적이다. mcsema의 부분적인 코드들은 remill의 스크립트와 CmakeLists.txt에 의존적이다. (Ubuntu 18.04 에서 설치하는걸 추천한다. 이전의 버전에는 추가적인 작업들이 필요로한다...)

```cmake
# remill/tools/CMakeLists.txt

# mcsema needs to be manually cloned into this repo.
if(EXISTS ${CMAKE_SOURCE_DIR}/tools/mcsema)
  add_subdirectory(mcsema)
endif()
```

```bash
#~ 필요한 의존성 설치~#
#~ ~#

#ida pro를 사용할 시.
sudo dpkg --add-architecture i386
sudo apt-get install zip zlib1g-dev:i386

#remill과 mcsema를 저장소로부터 다운로드 받는다.
git clone --depth 1 https://github.com/lifting-bits/mcsema.git
git clone https://github.com/lifting-bits/remill.git

#remill도 계속해서 업데이트 되므로 불안정할 수 있다. 따라서 특정 버전의 remill 버전이 필요하다.
#그래서 위에서 모든 버전을 clone 한다.
export REMILL_VERSION=`cat ./mcsema/.remill_commit_id`

#remill을 기반으로, tools로서 mcsema를 Build 하기 위해서.
mv ./mcsema .remill/tools

#build.sh에서 스크립트가 좀. pwd에 의존적으로 작성되어 있어서 pwd를 remill 폴더로 이동해준다.
#깔끔하게 하기 위해서.
cd remill

#remill의 tools 폴더에 mcsema를 집어넣고, remill을 빌드하면 mcsema도 tools로 자동 빌드된다.
#이 때에, mcsema를 빌드할 옵션을 넣을 수 있다.
#default로 하면, 그냥 default로 설치된다. llvm-disass 의 기본값은 ida7 pro다.
.scripts/build.sh

#install 하기 위해서, make의 install 명령어를 사용한다.
cd remill-build
make install
```

# Usage

```bash
mcsema-disass --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --output hello.cfg --binary hello --entrypoint main --log_file hello.log
```

```cpp
mcsema-lift-9.0 --os linux --arch amd64 --cfg hello.cfg --output hello.bc
```





버그투성이...