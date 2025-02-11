[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax          ; Clear AX register
    mov ds, ax          ; Set data segment to 0
    mov es, ax          ; Set extra segment to 0
    mov ss, ax          ; Set stack segment to 0
    mov sp, 0x7C00      ; Initialize stack pointer

PrintMessage:
    mov si, Message     ; Load address of the message into SI

print_loop:
    lodsb               ; Load next character into AL
    or al, al           ; Check if end of string (null terminator)
    jz END              ; If null terminator, jump to END
    mov ah, 0x0E        ; BIOS teletype function to print character
    mov bh, 0           ; Set page number to 0
    int 0x10            ; Call BIOS interrupt to print character
    jmp print_loop      ; Repeat until end of string

END:
    hlt                 ; Halt the CPU
    jmp END             ; Infinite loop to prevent execution beyond bootloader

Message: db "Hello, world!", 0  ; Message string with null terminator

times 510-($-$$) db 0   ; Fill remaining space to make it exactly 512 bytes
dw 0xAA55               ; Boot signature (BIOS requires this)
