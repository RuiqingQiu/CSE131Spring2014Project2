/*
 * Generated Thu May 22 21:32:33 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"
_indexOutOfBoundMsg:	.asciz "Index value of %d is outside legal range [0,%d).\n"
_nullPtrDereferenceMsg:	.asciz "Attempt to dereference NULL pointer.\n"
.deallocatedStackMsg:	.asciz "Attempt to dereference a pointer into deallocated stack space.\n"

	.section ".data"
	.align 4
.value_one:	.single 0r1.0
.value_zero:	.single 0r0.0
.lowest_stack_pointer:	.word 0
	.section ".text"
	.align 4
	.global foo
foo:
	set	SAVE.foo, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, %sp
	bg	._DealloStack_foo0
	nop

! No update for stack pointer
	ba	._DealloStack_foo0_end
	nop

._DealloStack_foo0: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_foo0_end: 


! storing 0th element onto stack
	set	68, %l0
	add	%fp, %l0, %l0
	st	%i0, [%l0]
! init variable: i
	set	0, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_2: 
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:i to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan3
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-8]
	ba	lessThan3_done
	nop

lessThan3:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-8]
lessThan3_done:

! indodesID : LessThanOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_2_end
	nop
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-12, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! doing array dereference
! get the index value into %l0
! indodesID : postIncOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_4
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_4
	nop

	ba	.array_bound_check_4_end
	nop

! Index Out Of Bound
.array_bound_check_4: 
	set	_indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_4_end: 
! indodesID : postIncOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	68, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-16]
! done with do array des
! indodesID : array_doDesignator2
	set	-16, %l0
	add	%fp, %l0, %l0
! ExprSTO: array_doDesignator2 hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_strFmt, %o0
	set	._str_fmt_foo0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_foo0:	.asciz "\t"

	.section ".text"
	.align 4

! indodesID : LessThanOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_2
	nop
whileStmt_2_end: 
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Doing Assignment, getting the right side value
	set	0, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
! Do While Label
whileStmt_6: 
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:i to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan7
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-24]
	ba	lessThan7_done
	nop

lessThan7:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-24]
lessThan7_done:

! indodesID : LessThanOp
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_6_end
	nop
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! get the index value into %l0
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_8
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_8
	nop

	ba	.array_bound_check_8_end
	nop

! Index Out Of Bound
.array_bound_check_8: 
	set	_indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_8_end: 
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	68, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-28]
! done with do array des
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	300, %l0
! minusOP first operand:300 to %l1
	mov	%l0, %l1

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! minusOP second operand:i to %l2
	mov	%l0, %l2

	sub	%l1, %l2, %l0
	st	%l0, [%fp-32]
! Doing Assignment, getting the right side value
! indodesID : MinusOp
	set	-32, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-28, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-40, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : LessThanOp
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_6
	nop
whileStmt_6_end: 
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -(92 + 40) & -8
	.section ".data"
	.global	bar
	.align 4
bar:	.word foo

	.section ".text"
	.align 4
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, %sp
	bg	._DealloStack_main11
	nop

! No update for stack pointer
	ba	._DealloStack_main11_end
	nop

._DealloStack_main11: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main11_end: 
! local variable:   a    without init, just add offset


! Making Function Ptr Call : bar
	set	bar, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_13
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_13
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_13: 
	set	_nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_13: 
	set	bar, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
! Moving the function call address to %l1
	mov	%l0, %l1
! moving all the arguments into %o registers
	add	%sp, -(.SAVE_bar_extra_argument_13) & -8, %sp
! indodesID : a
	set	-40, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! 0th argument of this function
	mov	%l0, %o0
	.SAVE_bar_extra_argument_13 = 0
	call	%l1
	nop
! Deallocate stack space
	sub	%sp, -(0)& -8, %sp
! Store return to a local tmp
	st	%o0, [%fp-44]

! init variable: i
	set	0, %l1
	set	-48, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_15: 
! indodesID : i
	set	-48, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-48, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:i to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan16
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-52]
	ba	lessThan16_done
	nop

lessThan16:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-52]
lessThan16_done:

! indodesID : LessThanOp
	set	-52, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_15_end
	nop
! indodesID : i
	set	-48, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-48, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-56, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-48, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! doing array dereference
! get the index value into %l0
! indodesID : postIncOp
	set	-56, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_17
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_17
	nop

	ba	.array_bound_check_17_end
	nop

! Index Out Of Bound
.array_bound_check_17: 
	set	_indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_17_end: 
! indodesID : postIncOp
	set	-56, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-60]
! done with do array des
! indodesID : array_doDesignator2
	set	-60, %l0
	add	%fp, %l0, %l0
! ExprSTO: array_doDesignator2 hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_strFmt, %o0
	set	._str_fmt_main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main1:	.asciz "\t"

	.section ".text"
	.align 4

! indodesID : LessThanOp
	set	-52, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_15
	nop
whileStmt_15_end: 
	set	_endl, %o0
	call	printf
	nop

	set	0, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 60) & -8
