/*
 * Generated Sat May 24 21:51:37 PDT 2014
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
.lowest_stack_pointer:	.word 0xFFFFFFFF
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
	bgu	._DealloStack_foo0
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

! doing struct field & put into %l2
	set	68, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	0, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-4]
! Doing Assignment, getting the right side value
	set	1, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-4, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]

! doing struct field & put into %l2
	set	68, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-12]
! Doing Assignment, getting the right side value
	.section ".data"
	.align 4
dodes_dot_assign_right_f_return_2:	.single 0r1.0
	.section ".text"
	.align 4
	set	dodes_dot_assign_right_f_return_2, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-12, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]

! doing struct field & put into %l2
	set	68, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-20]
! Doing Assignment, getting the right side value
	set	1, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-20, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]
	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -(92 + 24) & -8
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
	bgu	._DealloStack_main4
	nop

! No update for stack pointer
	ba	._DealloStack_main4_end
	nop

._DealloStack_main4: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main4_end: 
! local variable:   s    without init, just add offset


! making function call :foo
! moving all the arguments into %o registers
	add	%sp, -(.SAVE_foo_extra_argument_6) & -8, %sp
! argument struct pass by value, make copy
	set	-12, %l0
	add	%fp, %l0, %l0
	mov	%l0, %o1

	set	-24, %l0
	add	%fp, %l0, %o0
	set	12, %o2
	call	memmove
	nop
! 0th argument of this function
	mov	%l0, %o0
	.SAVE_foo_extra_argument_6 = 0
	call	foo
	nop
! Deallocate stack space
	sub	%sp, -(0)& -8, %sp
! Store return to a local tmp
	st	%o0, [%fp-28]


! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	0, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-32]
! indodesID : dodes_dot
	set	-32, %l0
	add	%fp, %l0, %l0
! ExprSTO: dodes_dot hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_strFmt, %o0
	set	._str_fmt_main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main0:	.asciz " "

	.section ".text"
	.align 4


! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-36]
! indodesID : dodes_dot
	set	-36, %l0
	add	%fp, %l0, %l0
! ExprSTO: dodes_dot hold address, one more load
	ld	[%l0], %l0
! load float to %f0
	ld	[%l0], %f0
	ld	[%l0], %l0

! end of DoDesID
	call	printFloat
	nop
	set	_strFmt, %o0
	set	._str_fmt_main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main1:	.asciz " "

	.section ".text"
	.align 4


! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-40]
! indodesID : dodes_dot
	set	-40, %l0
	add	%fp, %l0, %l0
! ExprSTO: dodes_dot hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	setFalse7
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done7
	nop
setFalse7:
	set	_boolF, %o0
	call	printf
	nop
done7:
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 40) & -8
