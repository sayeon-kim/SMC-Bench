

# 목차

#### Overview

#### Lift.cpp

#### Conclusion

# Overview

Test-Env : Ubuntu 18.04 on Docker

Draft: 2020.05.24

작성자: dbwodlf3@naver.com

# Lift.cpp

#### Usage

```bash
remill-lift-6.0 --arch amd64 --ir_out /dev/stdout --bytes c704ba01000000
```
추가 옵션들
- --bc_out : LLVM bitcode 를 저장. (파일 경로)
- --address : 가상 메모리가 맵핑될 어드레스 (정수값, default: 0)
- --entry_address : 디코딩, 리프팅 후에 실행될 어드레스. 지정하지 않으면 address 값을 디폴트로 한다.
- --os : os 지정. (아직 이 프로그램에서는 dummy 옵션.)
- --arch : 아키텍쳐 지정. x86 x86_avx amd64 amd64_avx aarch64



#### Functions

```c++
// Lift.cpp
using Memory = std::map<uint64_t, uint8_t>;
static Memory UnhexlifyInputBytes(uint64_t addr_mask){...}
class SimpleTraceManager : public remill:TraceManager {...}
class void MuteStateEscape(llvm::Module *module, const char *func_name){...}

int main(int argc, char *argv[]){...}
```



#### Memory

```c++
// main
llvm::LLVMContext context;
auto arch = remill::GetTargetArch(context);
const uint64_t addr_maks = ~0ULL >> (64UL - arch->address_size);
```



#### Init 0

```c++
//main
std::unique_ptr<llvm::Module> module(remill::LoadArchSemantics(arch));
```

##### module

module 이라는 이름으로, LLVM 의 module 객체를 만든다. 이 때에 만들어지는 module은 remill을 통해서 만들어지는 arch bitcode file을 기반으로 한다. 즉. runtime bitcode file을 LLVM module 객체로 불러온다.

LoadArchSemantics에서 FindSemanticsBitcodeFile, LoadModuleFromFile  함수들은을 Helper Function으로 사용하는데, 이들은 모두 remill/BC/Util.cpp 에 implementation 되어있다.

##### IntrinsicTable, InstructionLifter, TraceLifter

remill/BC/Lifter.h 에 모두 선언되어 있다.

#### conclusion 

module 객체를 runtime bc파일로부터 만든다.



#### Init 1

```c++
const auto state_ptr_type = remill::StatePointerType(module.get());
const auto mem_ptr_type = remill::MemoryPointerType(module.get());
```

#### StatePointerType, mem_ptr_type

```c++
// remill/BC/Util.h

// Returns the type of a state pointer.
llvm::PointerType *StatePointerType(llvm::Module *module) {
  return llvm::dyn_cast<llvm::PointerType>(
      LiftedFunctionType(module)->getParamType(kStatePointerArgNum));
}

// Returns the type of a state pointer.
llvm::PointerType *MemoryPointerType(llvm::Module *module) {
  return llvm::dyn_cast<llvm::PointerType>(
      LiftedFunctionType(module)->getParamType(kMemoryPointerArgNum));
}

llvm::FunctionType *LiftedFunctionType(llvm::Module *module){
    return BasicBlockFunction(module)->getFunctionType();
}

llvm::Function *BasicBlockFunction(llvm::Module *module){
    auto bb = module->getFunction("__remill_basic_block");
    CHECK(nullptr != bb); //glogs
    return bb;
}

// remill/BC/ABI.h
enum : size_t{
    kStatePointerArguNum = 0,
    kPCArguNum = 1,
    kMemoryPointerArgNum = 2,
    kNumBlockArgs = 3
}
```

1. "__remill_basic_block" 이라는 이름의 Function을 Module에서 찾아 반환한다.(BasicBlockFunction)
2. "__remill_basic_block" 이라는 이름의 Function의 타입을 반환한다.(LiftedFunctionType)
3. "__remill_basic_block" 이라는 이름의 Function의 Parameter Type을 반환한다.

#### __remill_basic_block

```c++
// Arch/Arch/~/Runtime/BasicBlock.cpp
Memory *__remill_basic_block(State &state, addr_t curr_pc, Memory *memory)
```

#### Conclusion

__remill_basic_block 함수의 State, Memory 파라미터의 llvm::PointerType 을 얻는다.



#### Init 2

```c++
Memory memory = UnhexlifyInputBytes(addr_mask);
SimpleTraceManager manager(memory);
remill::IntrinsicTable intrinsics(module);
remill::InstructionLifter inst_lifter(arch, intrinsics);
remill::TraceLifter trace_lifter(inst_lifter, manager);
```

- UnhexlifyInputBytes(addr_mask); 에서 addr_mask 는 address가 range를 넘었는지 안넘었는지 체크해주기 위한 mask일 뿐이다.

명령어를 실행하면서, --bytes 플래그로 값을 집어넣는다. 해당 값은 16진수 문자열이므로 프로그래밍내에서 숫자데이터로 바뀔 필요가 있다. 해당 데이터를 Memory 객체로 캐스팅하여 memory로 받는다.



#### 참고 

Init 2 같은 경우는 직관적으로 또, 소스코드상으로만 이해하는데 어려움이 있을 수 있다.

github 저장소에서, remill Intrinsics와 Design and Architecture of Remill, Remill Operators를 읽어볼 필요가 있다.

#### Intrinsic

Remill에서는 특정한 Intrinsic의 경우들에는 Remill 자체에서 구현한 Intrinsic을 사용한다. Memory에 대한 접근 같은 경우가 특히나 그렇다. IntrinsicTable intrinsics(module) 명령어로 해당 module의 intrinsics를 가지고 객체를 만든다.

#### InstructionLifter

Instruction을 LLVM IR Block으로 만들어주는 클래스. Instruction을 Function으로 만들어 준다.

#### TraceLifter



#### TraceManager

```c++
class SimpleTraceManager : public remill::TraceManager{
 public:
  virtual ~SimpleTraceManager(void) = default;

  explicit SimpleTraceManager(Memory &memory_)
      : memory(memory_) {}
}
```

```cpp
 protected:
  void SetLiftedTraceDefinition(uint64_t addr, llvm::Function *lifted_func) override{...}
  llvm::Function *GetLiftedTraceDeclaration(uint64_t addr) override{...}
  llvm::Function *GetLiftedTraceDefinition(uint64_t addr) override{...}
  bool TryReadExecutableByte(uint64_t addr, uint8_t *byte) override{...}
 public:
  Memory &memory;
  std::unordered_map<uint64_t, llvm::Function *> traces;
```

TraceManager를 만든다.


# Conclusion