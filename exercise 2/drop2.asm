extern	  printf
extern 	  scanf
extern 	  fgets
extern 	  stdin
extern 	  strlen
extern 	  atof
extern 	  verifyFloat

global testmodule:

max_size equ 32

segment .data

align 16 			 ;make sure the next data decleration starts on a 16 byte boundary

welcome db `If errors are discovered please report them to Christian at christiansanchez1258@gmail.com for a rapid update. At Columbia, Inc,the customer comes first.\n`, 10, 0

ask db "Please enter your first and last name: ", 0

string_len_info db "The number of characters in your name is %2d", 10, 0

outputmessage db "Thank you its nice to meet you, ", 0

prompt db ". We understand that you plan to drop a marble from a high vantage point.", 10, 0

ask2 db "Please enter the height of the marble above the ground surface in meters: ", 0

give db "Here is your number: ", 0

failmessage db `\nAn error was detected the input data. Please make sure that you enter a float number (e.g. 43.12). Thank you.`, 10, 0

give2 db `\nA drop from a height of %lf, will take %lf seconds to drop.`,10 , 0

stringformat db "%s", 0

floatform db "%lf", 0

gravity: dq 0x402399999999999A

align 64			;make sure that the next decleration starts on a 64-byte boundary

segment .bss

user_name resb max_size
user_float resb max_size
seconds:  resq 1		;reserve one quadword for time

segment .text

testmodule:

push 	  rbp
mov 	  rbp, rsp
push 	  rbx
push 	  rcx
push 	  rdx
push 	  rdi
push 	  rsi
push 	  r8
push 	  r9
push 	  r10
push 	  r11
push	  r12
push 	  r13
push 	  r14
push 	  r15
pushf

mov qword rax, 0		;no data from SSE will be printed
mov 	  rdi, stringformat     ;"%s"
mov 	  rsi, welcome		;print out the welcome menu
call 	  printf

mov 	  qword rax, 0
mov 	  rdi, stringformat    
mov 	  rsi, ask		;"Please enter your name:"
call 	  printf

mov qword rax, 0
mov 	  rdi, user_name
mov 	  rsi, max_size
mov 	  rdx, [stdin]		;dereference pointer to keyboard
call	  fgets

;compute the length of the inputted string
mov qword rax, 0
mov 	  rdi, user_name
call 	  strlen
sub 	  rax, 1
mov	  r13, rax			;store the length somewhere safe
mov       byte [user_name+r13], 0	;change the usernames length to one less char to remove <enter> key


;output the users name length
mov qword rax, 0
mov 	  rdi, string_len_info
mov 	  rsi, r13
call 	  printf

;reply to user
mov       rax, 0
mov	  rdi, stringformat
mov	  rsi, outputmessage
call 	  printf

mov	  rax, 0
mov	  rdi, stringformat
mov	  rsi, user_name
call 	  printf

;prompt the second message to user
mov qword rax, 0
mov 	  rdi, stringformat
mov 	  rsi, prompt
call 	  printf

;We want to get our users float number and read it in as a string so we can validate it using an external function
mov qword rax, 0
mov 	  rdi, stringformat
mov 	  rsi, ask2
call 	  printf

mov qword rax, 0
mov 	  rdi, user_float
mov 	  rsi, max_size
mov 	  rdx, [stdin]
call 	  fgets

mov qword rax, 0
mov       rdi, user_float
call      strlen
sub       rax, 1
;mov    	  r13, rax
mov 	  byte [user_float+rax], 0

mov       rax, 0
mov 	  rdi, stringformat
mov	  rsi, give
call 	  printf


mov       rax, 0
mov	  rdi, stringformat
mov	  rsi, user_float
call 	  printf

;now lets verify if input is a real number
mov	  rax, 0
mov	  rdi, user_float		;pass in the user float to the argument of
call	  verifyFloat
mov	  r11, rax			;0 or 1 (true or false)

cmp 	  r11, 0			;now compare r11 which is the return of the function with 0(false)
je  	  tryAgain			;go to the tryAgain block

;now convert the string to float using the atof()
mov 	  rax, 1
mov 	  rdi, user_float
call 	  atof
movsd	  xmm15, xmm0			;now mov the number from atof to somewhere stable -> xmm9
jmp 	  continue			;go to the continue block

tryAgain:

mov	  rax, 0
mov 	  rdi, failmessage
call 	  printf
jmp 	  conclusion

;if the input was indeed a float then just continue regular program
continue:
;formula to use is t = sqrt(2h/9.8) where 9.8 is our gravity
;our float is in the xmm15 reg
mov 	  rax, 2
cvtsi2sd  xmm14, rax			;convert 2 into a float and place it into xmm14
movsd	  xmm12, xmm15			;perserve the height for later use
mulsd     xmm15, xmm14			;2*height
movsd	  xmm13, [gravity] 		;dereference the gravity hex and place it into xmm13
divsd	  xmm15, xmm13
sqrtsd	  xmm15, xmm15			;should get our seconds now for free fall

mov 	  rax, 2
movsd	  xmm0, xmm12
movsd     xmm1, xmm15
mov 	  rdi, give2
call	  printf

movsd 	  xmm0, xmm15
mov 	  rax, 0
jmp 	  conclusion

conclusion:

;============pop our GPR======================
popf
pop 	  r15
pop 	  r14
pop 	  r13
pop 	  r12
pop 	  r11
pop 	  r10
pop 	  r9
pop 	  r8
pop 	  rsi
pop 	  rdi
pop 	  rdx
pop 	  rcx
pop 	  rbx
pop 	  rbp
;Now the system stack is in the same state it was when this funtion began execution

ret 
