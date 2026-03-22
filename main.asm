default rel  ; Use RIP-relative addressing by default

;reserve space for numbers
section .bss
	num1 resb 8
	num2 resb 8

section .data
	;prompts
	prompt1 db "Enter num1: "
	prompt2 db "Enter num2: "
	
	;prompt mem length
	prompt1_len equ prompt2 - prompt1
	prompt2_len equ $ - prompt2
		
	;result memory
	result db 0,10

section .text
	global _start

_start:
	;Send prompt for first number
	mov rax, 1
	mov rsi, prompt1
	mov rdi, 1
	mov rdx, prompt1_len
	syscall

	;Get input for num1
	mov rax, 0
	mov rsi, num1
	mov rdi, 0
	mov rdx, 8
	syscall

	;Send prompt for second number
	mov rax, 1
	mov rsi, prompt2
	mov rdi, 1
	mov rdx, prompt2_len
	syscall

	;Get input for num2
	mov rax, 0
	mov rsi, num2
	mov rdi, 0
	mov rdx, 8
	syscall

	;convert ASCII input of num1 to number
	movzx rax, byte [num1]
	sub rax, 48

	;convert ASCII input of num2 to number
	movzx rbx, byte [num2]
	sub rbx, 48

	;calculate
	add rax, rbx

	;convert result number ti ASCII, then set to result mem space
	add rax, 48
	mov [result], rax

	;output answer
	mov rax, 1
	mov rsi, result
	mov rdi, 1
	mov rdx, 2
	syscall
	
	;exit
	mov rax, 60
	mov rdx, 0
	syscall
	
