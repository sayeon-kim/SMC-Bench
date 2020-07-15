```bash
unreachable.x86.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:   55                      push   %rbp
   1:   48 89 e5                mov    %rsp,%rbp
   4:   48 83 ec 10             sub    $0x10,%rsp
   8:   c7 45 fc 00 00 00 00    movl   $0x0,-0x4(%rbp)
   f:   e9 04 00 00 00          jmpq   18 <end>

0000000000000014 <deadblock>:
  14:   90                      nop
  15:   90                      nop
  16:   90                      nop
  17:   90                      nop

0000000000000018 <end>:
  18:   48 bf 00 00 00 00 00    movabs $0x0,%rdi
  1f:   00 00 00 
  22:   b0 00                   mov    $0x0,%al
  24:   e8 00 00 00 00          callq  29 <end+0x11>
  29:   31 c9                   xor    %ecx,%ecx
  2b:   89 45 f8                mov    %eax,-0x8(%rbp)
  2e:   89 c8                   mov    %ecx,%eax
  30:   48 83 c4 10             add    $0x10,%rsp
  34:   5d                      pop    %rbp
  35:   c3                      retq 
```