;reserve space for numbers
section .bss
	num1 resb 32 ; 32 bits space coz 8 wasnt enough for big numbers
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
	result db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   ; 16 bytes

section .text
	global _start

to_int:
	movzx rax, byte [r9] ; get byte r9 is pointing to
	sub rax, 48 ; ascii to number
	imul r10,10 ; r10 = r10 * 10
	add r10, rax ; r10 = r10 + current digit

	inc r9 ; set the pointer front by one, so the next digit is selected
	dec r8 ; decreasse the loop counter
	jnz to_int ; jumpt to the start if r8 isnt 0
	ret ; return to label call location

to_str:
	xor rdx, rdx ; zero out to hold remainder of division (digit being coverted this round)
	mov rbx, 10 ; prepare do divide by 10
	div rbx ; what happens is rax/rbx, then trunc goes to rax while remainder goes to rdx
	add rdx, 48 ; connvert selected nuber to ascii
	mov [rsi], dl ; add ascii to the result mem space (where its currently pointing to)
	dec rsi ; point to next result byte (using dec, not inc coz adding characters from back)
	inc r9 ; inc r9 to keep track of character length
	test rax, rax ; see if rax is 0
	jnz to_str ; jump to start if rax (previously checked) isnt zero

	inc rsi ; rsi over dec by one coz of loop, inc to get character at the end	

	mov rbx, rsi ; preparing to add newline
	add rbx, r9 ; point to the end of the result ascii
	mov [rbx], 10 ; add the newline
	inc r9 ; inc r9 to show the added newline
	ret ; return to label call location

out_label:
	mov rax, 1
	mov rdi, 1
	syscall
	ret

in_label:
	mov rax, 0
	mov rdi, 0
	syscall
	ret

_start:

; Get first number(ASCII) And convert it to a number

	;Send prompt for first number
	mov rsi, prompt1
	mov rdx, prompt1_len
	call out_label ; repeating file have been called by a label

	;Get input for num1
	mov rsi, num1
	mov rdx, 32
	call in_label ; repeating file have been called by a label

	xor r12, r12 ; where we will hold the final calculation

	; Prepare for num1 for ASCII to number conversion
	mov r9, num1 ; r9 = number to turn
	dec rax; remove newline from length then,
	mov r8, rax ; hold the length
	xor r10, r10 ; initialize r10 as accumulator

	call to_int ; do ascii to int conversion process for num1

	mov r12, r10 ; since we will be using r10 for the num2 coversion, transfer num1 to r12

; Get first second(ASCII) And convert it to a number

	;Send prompt for second number
	mov rsi, prompt2
	mov rdx, prompt2_len
	call out_label

	;Get input for num2
	mov rsi, num2
	mov rdx, 32
	call in_label

	; Prepare for num2 for ASCII to number conversion 
	mov r9, num2
	dec rax; remove newline from lengh
	mov r8, rax ; hold the lengh
	xor r10, r10

	call to_int ; do ascii to int conversion process for num2

; Main Calculation

	add r12, r10 ; add the numbers (actual calculation)

; Convert result back to ASCII and output it
	
	; prepare data for to_str label
	mov rax, r12 ; the number to be converted to ASCII
	mov rsi, result ; the result mem space to hold the resulting ascii
	add rsi, 14 ; start from the end of result mem, will be adding characters from the back
	xor r9,r9 ; zero out r9, remove garbage

	call to_str ; do result number to string conversion (and newline addition at end)

	mov r12, rsi ; keep result in rsi (to show exit msg first)

	;exitmsg
	mov rsi, exitmsg
	mov rdx, exitmsg_len
	call out_label
	
	;output answer
	mov rsi, r12
	mov rdx, r9
	call out_label

	;exit
	mov rax, 60
	mov rdi, 0
	syscall
