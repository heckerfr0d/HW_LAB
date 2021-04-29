
#NASM-MIPS Translations

Note: Stolen from [here](https://gist.github.com/t-mullen/02969915753a8684ed6f). Credits [@t-mullen](https://gist.github.com/t-mullen)
This is a WIP. Please notify me of any mistakes or possible improvements.  
I have ignored any 64-bit differences due to Moore seeming to be a 32-bit system.

#Contents

[Registers](#registers)  
[Basic Instructions](#basic-instructions)  
[Data Instructions](#data-instructions)  
[Bitwise Instructions](#bitwise-instructions)  
[Logic Instructions](#logic-instructions)  
[Appendix](#appendix)  

#Registers

|Purpose of Register                                                              | MIPS         | NASM          |
|:--------------------------------------------------------------------------------|:------------:|:-------------:|
|Stack Pointer | $sp | esp |
|Stack Frame Pointer / Base Pointer | $fp | ebp |
|Return Value | $v0-$v1 | eax |
|Return Value (floating point)| $f0 | st0 |
|Arguments | $a0-$a3 | NONE - In stack |
|Free (32-bit integer) | $t0-$t9, $s0-$s8 | eax, ecx, ebx, edx, esi, edi(ebx if not in a shared library)|
|Free (16-bit integer) | NONE | ax,  bx, cd, dx|
|Free (8-bit integer)  | NONE | ah, al, bh, bl, ch, cl, dh, dl |
|Free (floating point)| $f0-$f31 | st0,st1,...,st? |
|Return Address| $ra | NONE - In stack |
|Product and Remainder | $LO, $HI | eax, edx |
|Quotient and High 32 Bits | $LO, $HI | eax, edx |





#Basic Instructions

Arbitrarily chosen names are shown in _italics_.  
There are several more pseduoinstructions that are combinations of the ones shown here.  

|Description                                                                      | MIPS         | NASM          |
|:--------------------------------------------------------------------------------|:------------:|:-------------:|
|Load immediate value into register. | li _$t0, 4_ | mov _eax,4_|
|Move value of one register into another.| move _$t0, $t1_ | mov _eax,ecx_ |
|Add 2 registers. | add _$t0, $t1, $t2_ | add _eax,ebx_ (Sum saved in first register)|
|Add register and immediate. | addi _$t0, $t1, 4_ | add _eax,4_ (Sum saved in first register)|
|Subtract 2 registers. | sub _$t0, $t1, $t2_ | sub _eax,ebx_ (Difference  saved in first register)|
|Subtract register and immediate. | subi _$t0, $t1, 4_ | sub _eax,4_ (Difference  saved in first register)|
|Multiply. | mult _$t1, $t2_ (Result in $HI and $LO)| mul _ebx_ (Multiply __eax__ by _ebx_ and put product into __eax__.)|
|Multiply by an immediate. | multi _$t1, 3_ (Result in $HI and $LO)| imul _ebx, 3_ (Multiply _ebx_ by _3_ and put product into _ebx_.)|
|Divide. | div _$t1, $t2_ (Result in $HI and $LO)| div _ebx_ (Divide __eax__ by _ebx_ and put quotient into __eax__.)|
|Divide by an immediate. | divi _$t1, 3_ (Result in $HI and $LO)| idiv _ebx, 3_ (Divide _ebx_ by _3_ and put quotient into _ebx_.)|
|Add 1 to a register. | addi _$t1_, _$t1_, 1 | inc _eax_ |
|Subtract 1 from a register. | subi _$t1_, _$t1_, 1 | dec _eax_ |
|Call a function. | jalr _address of function_| call _name of function_ |
|Import an external function. | .global _name of function_ | extern _name of function_ |
|Return | jr $ra| ret (Returns to the last jump instruction called.)|

#Data Instructions

|Description                                                                      | MIPS         | NASM          |
|:--------------------------------------------------------------------------------|:------------:|:-------------:|
|Push a value into the stack. | subi $sp, $sp, 4; sw _$t0_, ($sp) |push eax|
|Pop a value from the stack. | lw _$t0_, ($sp); addi $sp, $sp, 4| pop eax |
|Declare initialized variable. (Word)| _variableName_: .word _3_ | _variableName_: dw _3_ |
|Declare uninitialized variable. (Word)| NONE - Must initialize. | _variableName_: resd _1_ (_1_ is # of words) |
|Declare initialized variable. (Byte)| _variableName_: .byte _3_ | _variableName_: db _3_ |
|Declare uninitialized variable. (Byte)| NONE - Must initialize. | _variableName_: resb _1_ (_1_ is # of bytes) |
|Declare initialized variable. (Array)| NONE - Initialize after. | _variableName_: db _3_ |
|Declare uninitialized variable. (Array)| _variableName_: .space 10 (Array of _10_ words)| _variableName_: resq _10_  (Array of _10_ reals)|

#Bitwise Instructions

|Description                                                                      | MIPS         | NASM          |
|:--------------------------------------------------------------------------------|:------------:|:-------------:|
|Shift logical left << | sll _$t0_, _$t0_, _4_ | shl _eax, 4_|
|Shift logical right >> | srl _$t0_, _$t0_, _4_ | shr _eax, 4_|
|Bitwise NOT | not _$t0_, _$t0_ | not _eax_|
|Bitwise AND| not _$t0_, _$t0_, _$t1_ | not _eax_, _ebx_|
|Bitwise OR| xor _$t0_, _$t0_, _$t1_ | xor _eax_, _ebx_|
|Bitwise XOR| or _$t0_, _$t0_, _$t1_ | or _eax_, _ebx_|

#Logic Instructions

##MIPS

|Instruction|Description|
|:---------:|:----------|
|b _label_| Unconditional branch.|
|beq __$t0, $t1__, _label_| Branch if $t0 = $t1|
|bgez __$t0__, _label_| Branch if $t0 >= 0|
|bgezal __$t0__, _label_| Branch if $t0 >= 0 and set $ra|
|bgtz __$t0__, _label_| Branch if $t0 > 0|
|bgtz __$t0__, _label_| Branch if $t0 < 0|
|bgtzal __$t0__, _label_| Branch if $t0 < 0 and set $ra|
|bne __$t0, $t1__, _label_| Branch if $t0 != $t1|
|j _address_| Jump to address.|
|jr _$t0_| Jump to address stored in register.|
|jal _address_| Jump to address and set $ra.|
|jalr _$t0_| Jump to address stored in register and set $ra.|
| _labelname_: |Define a label.|

##NASM

|Instruction|Description|
|:---------:|:----------|
|cmp _eax, ebx_| Set comparison flags for two values.|
|jl _label_| Jump to label if _eax_ < _ebx_|
|jle _label_| Jump to label if _eax_ <= _ebx_|
|je _label_| Jump to label if _eax_ = _ebx_|
|jge _label_| Jump to label if _eax_ >= _ebx_|
|jg _label_| Jump to label if _eax_ > _ebx_|
|jne _label_| Jump to label if _eax_ != _ebx_|
| _labelname_: |Define a label.|



#Appendix

##A - Getting the program counter in MIPS.

```
  bgezal $zero, getpc
getpc:  
  move $v0, $ra  
  j $ra
```

##B - NASM setup instructions.

| Instruction | Definition |
|:------:| :------|
| pusha | Push all registers.|
| popa | Pop all registers.|
| enter | Create the stack frame. (Gives you a place to push)|
| leave | Destroy the stack frame. (Frees up the memory taken by enter)|

##C - NASM Calling Procedure

###Caller

```
push ARGUMENT#N  ;Push arguments
;...
push ARGUMENT#3
push ARGUMENT#2
push ARGUMENT#1
call FUNCTION         ;Call function
add esp, 4*N          ;Essentially pops arguments.
```  

##Callee

```
enter 0,0 ;Create stack frame

mov ARGUMENT#1, dword [ebp+8]       ;Load arguments.
mov ARGUMENT#2, dword [ebp+12]
mov ARGUMENT#3, dword [ebp+16]
;...
mov ARGUMENT#N, dword [ebp+4+N*4]

;YOUR FUNCTION CODE HERE!

leave   ;Destroy stack frame
ret     ;Return to caller
```  


#Sources

http://www.nasm.us/doc/nasmdoc3.html  
https://www.csee.umbc.edu/courses/undergraduate/CMSC313/fall04/burt_katz/lectures/  
http://www.eecg.toronto.edu/~amza/www.mindsec.com/files/x86regs.html  
https://msdn.microsoft.com/en-us/library/ms253512(VS.80).aspx  
http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html  
https://www.cs.uaf.edu/2006/fall/cs301/support/x86/  
http://home.myfairpoint.net/fbkotler/nasmdocc.html  
https://en.wikibooks.org/wiki/X86_Assembly/Other_Instructions  
http://www.nasm.us/doc/nasmdoc9.html  
https://en.wikipedia.org/wiki/MIPS_instruction_set#Pseudo_instructions