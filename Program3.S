	//CSCE 2610 - Jimena Romo C
	/* Implementing the Ackermann Recursive Function */


	.data					// data section

	.text					//program section

	.globl main
	.globl A			//ackermann function
	.arch armv8-a+fp+simd	//processor type
	.type main, %function	//main is a function
	.type A, %function		//A is a function

main:
	MOV X0, #2
	MOV X1, #2
	BL	A

	b exit

A:
	SUB SP,SP,#16 // space for 2 registers on stack
	STUR X30, [SP, #8] // Store ret address on stack
	STUR X0, [SP, #0] // store m for future calls

	CBZ X0, base_case // if m == 0

	CBZ X1, n_zero // if n == 0

	BL else // else
base_case:
	ADD X0, X1, #1 // X0 = n + 1
	BR X30	//return address
n_zero:
	SUB X0, X0, #1 //m - 1
	mov X1, #1 // n = 1

	BL A // A(m-1,1)
	BL done
else:
	ADD X2, X0, XZR // saving m for new call
	SUB X1, X1, #1 // X1 = n - 1

	BL A // X0 = A(m, n-1)

	ADD X1, X0, XZR // n = A(m,n-1)
	SUB X0, X2, #1 // X0 = m - 1

	BL A // A(m-1,A(m,(n-1)))
	BL done

done:
	LDUR X2, [SP, #0] // restore m
	LDUR X30, [SP, #8] // restore return addr
	ADD SP, SP, #16 // Pop

	BR X30 // Return

exit:



