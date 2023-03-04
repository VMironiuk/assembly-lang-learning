; ---------------------------------------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit macOS only. Tested on 13.2.1
; To assemble and run:
;
;     nasm -f macho64 hello.asm && ld -macosx_version_min 10.12 -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o hello hello.o && ./hello
;----------------------------------------------------------------------------------------------------------------------

default rel                          ; use relative addressing
global _main                         ; must be declared global for linker to find it

section .text                        ; code section
_main:                               ; must be declared _main for linker to find it
    mov     rax, 0x2000004           ; system call for write
    mov     rdi, 1                   ; file descriptor 1 is stdout
    lea     rsi, [msg]               ; address of string to output (replace `mov rsi, msg` with this)
    mov     rdx, msg.len             ; number of bytes to write
    syscall                          ; invoke operating system to do the write
    mov     rax, 0x2000001           ; system call for exit
    mov     rdi, 0                   ; exit code 0
    syscall                          ; invoke operating system to exit

section .data                        ; data section
msg:    db      "Hello, world!", 10  ; 10 is the newline character
.len:   equ     $ - msg              ; length of string, for use by `mov rdx, msg.len`