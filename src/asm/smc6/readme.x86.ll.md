```asm
%7 = tail call zeroext i16 @__remill_read_memory_16(%struct.Memory* %2, i32 134512736) #3
```
%7 에서 _start분기의 주소(134512736)를 읽어와서,


```asm
    mov [_start], bl        
    mov [_start+1], bl     
    mov [re_start], bl    
    mov [re_start+1], bl
```

x86 코드의 해당되는 4번의 write를
아래와 같이 @__remill_write_memory_8 호출을 4번 수행하여 각각 복사하는 것을 확인 할 수 있습니다.

```asm
%8 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %2, i32 134512736, i8 zeroext -112) #3
  ; mov [_start], bl 
  %9 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %8, i32 134512737, i8 zeroext -112) #3
  ; mov [_start+1], bl 
  %10 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %9, i32 134512776, i8 zeroext -112) #3
  ; mov [re_start], bl 
  %11 = tail call %struct.Memory* @__remill_write_memory_8(%struct.Memory* %10, i32 134512777, i8 zeroext -112) #3
  ; mov [re_start+1], bl
```

