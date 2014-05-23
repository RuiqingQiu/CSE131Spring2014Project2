/*
 * Generated Thu May 22 22:38:58 PDT 2014
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
! init variable: a
	set	10, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -(92 + 4) & -8
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
	bg	._DealloStack_main2
	nop

! No update for stack pointer
	ba	._DealloStack_main2_end
	nop

._DealloStack_main2: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main2_end: 
! local variable:   a    without init, just add offset


! Making Function Ptr Call : bar
	set	bar, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_4
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_4
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_4: 
	set	_nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_4: 
	set	bar, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
! Moving the function call address to %l1
	mov	%l0, %l1
! moving all the arguments into %o registers
	add	%sp, -(.SAVE_bar_extra_argument_4) & -8, %sp
! indodesID : a
	set	-40, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! 0th argument of this function
	mov	%l0, %o0
	.SAVE_bar_extra_argument_4 = 0
	call	%l1
	nop
! Deallocate stack space
	sub	%sp, -(0)& -8, %sp
! Store return to a local tmp
	st	%o0, [%fp-44]

	set	0, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 44) & -8
