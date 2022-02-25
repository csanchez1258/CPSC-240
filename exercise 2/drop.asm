extern printf
extern atol
extern stol
extern scanf
extern stdin
extern fgets
extern strlen

INPUT_LEN equ 256

global testmodule

segment .data

welcome db `\nIf errors are discovered please report them to Christian at christiansanchez@gmail.com for a rapid update. At Columbia, Inc., the customer comes first!`, 10, 0

ask db "Please enter your first and last name: ", 0

stroutput  db `Thank you %s. We appreciate your business.`, 10, 0

strinput db "%s", 0

debug db "This is the string length: %u", 10, 0

ask2 db "Please enter your job title (Nurse, Programmer, Teacher, Carpenter, Mechanic, Bus Driver, Barista, Hair Dresser, Acrobat, Senator, Sales Clerk, etc): ", 0

segment .bss

length: resb INPUT_LEN

segment .text
testmodule:

;lets start to push the GPR's

push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;welcome the user
mov rax, 0
mov rdi, welcome
call printf

mov rax, 0
mov rdi, ask
call printf

;now get the users full name
mov rax, 0
mov rdi, length
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets
mov rax, 0
mov rdi, length
call strlen
sub rax, 1
mov byte[length+rax], 0


mov rax, 0
mov rdi, stroutput
call printf

;remove the <enter> key from the input
;mov rax, 0
;mov rdi, stroutput
;call strlen
;mov r15, rax

;mov rax, 0
;mov rdi, debug
;call printf
;DEBUG

;mov rax, 0
;mov rdi, stroutput
;mov rsi, strinput
;call printf


;mov rax, 0
;mov rdi, ask2
;call printf

;now get the users occupation
;mov qword rax, 0
;mov rdi, strinput
;mov rsi, 1024
;mov rdx, [stdin]
;call fgets




;print out their occupation
;mov rax, 0
;mov rdi, stroutput
;mov rsi, strinput
;call printf
;pop rax


conclusion:
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp
ret
