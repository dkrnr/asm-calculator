;reserve space for numbers
section .bss
	num1 resb 32
	num2 resb 32

section .data
	;prompts
	prompt1 db "Enter num1: "
	prompt2 db "Enter num2: "
	exitmsg db "The Answer is: "
	
	;prompt mem length
	prompt1_len equ prompt2 - prompt1
	prompt2_len equ exitmsg - prompt2
	exitmsg_len equ $ - exitmsg
		
	;result memory
	result db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10   ; 16 bytes + newline

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
	mov rdx, 32
	syscall

	xor r12, r12 ; where ill hold the final calculation

	;convert ASCII input of num1 to number
	mov r9, num1
	dec rax; remove newline from lengh
	mov r8, rax ; hold the lengh
	xor r10, r10

.to_int:
	movzx rax, byte [r9]	
	sub rax, 48
	imul r10,10
	add r10, rax

	inc r9
	dec r8
	jnz .to_int

	mov r12, r10

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

	;convert ASCII input of num2 to number
	mov r9, num2
	dec rax; remove newline from lengh
	mov r8, rax ; hold the lengh
	xor r10, r10

.to_int2:
	movzx rax, byte [r9]	
	sub rax, 48
	imul r10,10
	add r10, rax

	inc r9
	dec r8
	jnz .to_int2

	add r12, r10 ; add the numbers
	
	mov rax, r12
	mov rsi, result
	add rsi, 14
	xor r9,r9

.to_str:
	xor rdx, rdx
	mov rbx, 10
	div rbx
	add rdx, 48
	mov [rsi], dl
	dec rsi
	inc r9
	test rax, rax
	jnz .to_str

	inc rsi	

	mov rbx, rsi
	add rbx, r9
	mov [rbx], 10
	inc r9

	;output answer
	mov rax, 1
	mov rdi, 1
	mov rdx, r9
	syscall
	
	;exit
	mov rax, 60
	mov rdi, 0
	syscall
