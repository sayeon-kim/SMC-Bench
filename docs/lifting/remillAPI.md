```cpp
using Memory = std::map<uint64_t, uint8_t>;
Memory memory = UnhexlifyInputBytes(addr_mask);
SimpleTraceManager manager(memory);
remill::IntrinsicTable intrinsics(module);
remill::InstructionLifter inst_lifter(arch, intrinsics);
remill::TraceLifter trace_lifter(inst_lifter, manager);
```

lifting module
dest module