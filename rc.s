/*
 * Generated Thu May 22 20:59:00 PDT 2014
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
	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -92 & -8
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
	bg	._DealloStack_main1
	nop

! No update for stack pointer
	ba	._DealloStack_main1_end
	nop

._DealloStack_main1: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main1_end: 
! local variable:   a    without init, just add offset


! making function call :foo
! moving all the arguments into %o registers
	add	%sp, -(.SAVE_foo_extra_argument_3) & -8, %sp
! argument pass by reference, get the address
	set	-40, %l0
	add	%fp, %l0, %l0
! 0th argument of this function
	mov	%l0, %o0
	.SAVE_foo_extra_argument_3 = 0
	call	foo
	nop
! Deallocate stack space
	sub	%sp, -(0)& -8, %sp
! Store return to a local tmp
	st	%o0, [%fp-44]

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 44) & -8
