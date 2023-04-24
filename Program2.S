	.data					// data section
	.type	v, %object		//defining object v
	.size	v, 4			//size 4 (change sizes)

v:							// v array
	.xword	1, 2, 3, 0		//the elements - size 64 (testing)

	.text					//program section
	.globl main
	.arch armv8-a+fp+simd	//processor type
	.type main, %function	//main is a function

main:
	MOV X10, #0				//initial index base to 0
	MOV X12, #0				//initial final sum to 0

	ADR X11, v				//LOAD BASE ADDRESS OF V INTO X9
loop_1:
	LSL X9, X10, #3			//multiplying index (currently 0) by 8 (2^3) (shift over to the left)
	ADD X9, X11, X9			//x9 should be 0 so add base (x11) and get base address in x9 now
	LDUR X9, [X9, #0]		//loading value
	ADD X10, X10, #1		//incrementing index (in x10)

	CBZ X9, loop_2			//if X9 value is 0 go to loop 2, will be at the end.
	TST X9, #1				//testing the low-order bit against 1

	BNE loop_1				//if zero flag from operation is 0 go back

	ADD X12, X12, X9		//adding x9 into sum
	B	loop_1				//repeat the process

loop_2:
	B	loop_2				//end of loops
