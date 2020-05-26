# 목차 

#### Overview

#### CmakeLists

#### Build

#### Conclusion

# Overview

Test-Env : Ubuntu 18.04 on Docker

Draft : 2020.05.22

작성자 : dbwodlf3@naver.com


# CmakeLists

#### Overview

SOURCE_ROOT/CmakeLists.txt 아래의 내용을 참고했다.

해당 파일을 따라가며 어떤 Target 파일이 생성되는지 파악한다.



#### Dependency

```cmake
##################
### Dependency ###
##################

# ~some codes~ #

# llvm
find_package(LLVM REQUIRED CONFIG HINTS ${FINDPACKAGE_LLVM_HINTS})

# xed
find_package(XED REQUIRED)
list(APPEND PROJECT_LIBRARIES ${XED_LIBRARIES})
list(APPEND PROJECT_INCLUDEDIRECTORIES ${XED_INCLUDE_DIRS})

# google log module
find_package(glog REQUIRED)
list(APPEND PROJECT_LIBRARIES glog::glog)

# gflags
find_package(gflags REQUIRED)
list(APPEND PROJECT_LIBRARIES gflags)

# ~other codes~ #
```


- gflags => CLI 인터페이스를 위한 기능
- glog => Logging 을 위한 기능.
- xed => 바이너리 시멘틱 해석을 위해서.
- LLVM => LLVM IR 생성을 위해서.



#### Target

```cmake
##############
### Target ###
##############

add_library(${PROJECT_NAME} STATIC
  remill/Arch/AArch64/Arch.cpp
  remill/Arch/AArch64/Decode.cpp
  remill/Arch/AArch64/Extract.cpp
  remill/Arch/X86/Arch.cpp

  remill/Arch/Arch.cpp
  remill/Arch/Instruction.cpp
  remill/Arch/Name.cpp

  remill/BC/Annotate.cpp
  remill/BC/DeadStoreEliminator.cpp
  remill/BC/IntrinsicTable.cpp
  remill/BC/Lifter.cpp
  remill/BC/Optimizer.cpp
  remill/BC/Util.cpp

  remill/OS/Compat.cpp
  remill/OS/FileSystem.cpp
  remill/OS/OS.cpp
)
```

아래의 파일들을 링킹하여 최종적으로 ${PROJECT_NAME} => remill 라이브러리를 STATIC으로 만든다.

리눅스에서의 최종 산출물은 libremill.a 이다.



#### Addtional targets

```cmake
#######################
### Target settings ###
#######################

set(REMILL_LLVM_VERSION "${LLVM_MAJOR_VERSION}.${LLVM_MINOR_VERSION}")
set(REMILL_BUILD_SEMANTICS_DIR_X86 "${CMAKE_CURRENT_BINARY_DIR}/remill/Arch/X86/Runtime/")
set(REMILL_BUILD_SEMANTICS_DIR_AARCH64 "${CMAKE_CURRENT_BINARY_DIR}/remill/Arch/AArch64/Runtime/")
```

```cmake
#############################
### InstallExternalTarget ###
#############################
function(InstallExternalTarget target_name target_path install_directory installed_file_name)
#
# some codes
#
endfunction()

# set clang
# set llvm-link

set(INSTALLED_CLANG_NAME "remill-clang-${REMILL_LLVM_VERSION}${executable_extension}")
set(INSTALLED_LLVMLINK_NAME "remill-llvm-link-${REMILL_LLVM_VERSION}${executable_extension}")
```

remill 은 특정 버전의 clang과 llvm에 의존성을 가지고 있어서 최신버전의 clang이나 llvm에 변경사항이 있으면 호환이 되지 않을 수도 있으므로 remill에서는 호환성이 유지되는 clang과 llvm-link를 remill 이라는 prefix를 달아서 설치 해 준다.

- remill-clang-9.0
- remill-llvm-link-9.0

```cmake
#################
### runtimes  ###
#################

# Add a dummy 'semantics' target to satisfy the protobuf generator
# remillConfig.cmake.in
add_custom_target(semantics)

# runtimes
add_subdirectory(remill/Arch/X86/Runtime)
add_subdirectory(remill/Arch/AArch64/Runtime)
```

- add_custom_target(semantics) => 이 부분은 dummy. 아무것도 수행하지 않음.

- add_subdirectory(remill/Arch/X86/Runtime) => X86에 대한 Runtime의 bc 파일을 생성한다.

- add_subdirectory(remill/Arch/AArch64/Runtime) => AArch64에 대한 Runtime의 bc 파일을 생성한다.

```bash
################################
### cat install_manifest.txt ###
################################

cat install_manifest.txt
#~ some outputs ~#
/usr/local/share/remill/9.0/semantics/x86.bc
/usr/local/share/remill/9.0/semantics/x86_avx.bc
/usr/local/share/remill/9.0/semantics/x86_avx512.bc
/usr/local/share/remill/9.0/semantics/amd64.bc
/usr/local/share/remill/9.0/semantics/amd64_avx.bc
/usr/local/share/remill/9.0/semantics/amd64_avx512.bc
/usr/local/share/remill/9.0/semantics/aarch64.bc

# add_subdirectory(remill/Arch/X86/Runtime)
# add_subdirectory(remill/AArch64/Runtime)
# make install 명령어를 실행하면 위와 같은 경로로 설치된다. Ubuntu 18.04 버전을 기준으로 작성되었다.
```

make install 명령어 이후, install_manifest.txt 파일의 내용을 읽으면 위와같다.



## Summary

CMakeLists 를 통해서 최종적으로 빌드되는 파일은 다음과 같다.

- libremill.a
- x86.bc
- x86_avx.bc
- x86_avx512.bc
- amd64.bc
- amd64_avx.bc
- amd64_avx512.bc
- aarch64.bc

make install 을 통해서, targets, cmake files and header files 이 지정된 Directory에 설치된다.

---



# Build

#### Overview

pre-compiled 된 binary 파일을 제공하지는 않는다.
환경에 맞게끔 compile한 이후로 사용해야 한다.
https://github.com/lifting-bits/remill 
github repository 에서 소스코드를 다운로드 받을 수 있다.
release 된 version은 2.0.0 으로 2017년의 것이다.



베이스가 되는 빌드툴은 CMake이고, BuildScript를 통해서 손쉬운 빌드를 제공한다.
remill/scripts/build.sh 스크립트를 통해서 설치할 수 있다. 그럼에도 최소한의 Dependencies는 만족시켜야 한다. Repository에서 apt-get install 명령어를 통해서 설치하는 방법을 알려준다.



이 글을 작성하는 현 시점에, Linux와 MacOS의 환경에서만 가정이 되어있으므로, Windows 에서 설치하기 위해서는 별도의 작업이 필요한 것으로 보인다.



#### build.sh

remill/scripts/build.sh 에서 파일을 찾아볼 수 있다.

build는 총 3 페이즈로 이루어진다.

```bash
#####################
### function main ###
#####################

function main
{
#~ some codes ~#

  mkdir -p "${BUILD_DIR}"
  cd "${BUILD_DIR}" || exit 1
  
  if ! (DownloadLibraries && Configure && Build); then
    echo "[x] Build aborted."
  fi
  
  return $?
}
```

- DownloadLibraries => github의 repository 에서 pre-compiled 된 압축파일을 다운로드한 후 압축 해제한다.  
- Configure => 다운로드된 cmake를 통해서, 해당 repository의 라이브러리들을 사용해 remill의 make 파일을 생성한다.
- Build => make 명령어를 실행한다.

일련의 과정을 거친 후에. make 명령어까지 실행된 폴더로 들어가 make install 명령어를 실행하면 지정된 장소에 성공적으로 파일들이 설치되는걸 확인할 수 있다.



## Summary

의존성이 강하고 쉽게 해결하기가 힘든 것들에 대해서는 pre-compile 된 파일을 제공함으로서 해결한다.

해당 repository의 주소는 이곳이다. https://github.com/trailofbits/cxx-common

---



# Conclusion

libremill.a과 X86 and AArch64 bc Runtime 타겟파일이 생성된다.