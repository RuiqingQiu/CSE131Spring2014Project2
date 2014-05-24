/*
 * Generated Sat May 24 14:32:30 PDT 2014
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
! indodesID : a
	set	68, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! convert to negative and store
! indodesID : a
	set	68, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	mov	%l0, %o0
	set	-1, %o1
	call	.mul
	nop
	st	%o0, [%fp-4]
	ld	[%fp-4], %l0

! indodesID : a
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -(92 + 4) & -8
	.section ".text"
	.align 4
	.global foo.overloaded_2
foo.overloaded_2:
	set	SAVE.foo.overloaded_2, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, %sp
	bgu	._DealloStack_foo.overloaded_23
	nop

! No update for stack pointer
	ba	._DealloStack_foo.overloaded_23_end
	nop

._DealloStack_foo.overloaded_23: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_foo.overloaded_23_end: 
! indodesID : a
	set	null, %l0
	add	null, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : b
	set	null, %l0
	add	null, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : a
	set	null, %l0
	add	null, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! minusOP first operand:a to %l1
	mov	%l0, %l1

! indodesID : b
	set	null, %l0
	add	null, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! minusOP second operand:b to %l2
	mov	%l0, %l2

	sub	%l1, %l2, %l0
	st	%l0, [%fp-4]
! indodesID : MinusOp
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.foo.overloaded_2 = -(92 + 4) & -8
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
	bgu	._DealloStack_main6
	nop

! No update for stack pointer
	ba	._DealloStack_main6_end
	nop

._DealloStack_main6: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main6_end: 


! making function call :foo
! moving all the arguments into %o registers
	add	%sp, -(.SAVE_foo_extra_argument_7) & -8, %sp
	set	10, %l0
! 0th argument of this function
	mov	%l0, %o0
	.SAVE_foo_extra_argument_7 = 0
	call	foo
	nop
! Deallocate stack space
	sub	%sp, -(0)& -8, %sp
! Store return to a local tmp
	st	%o0, [%fp-4]

! indodesID : FuncCall
	set	-4, %l0
	add	%fp, %l0, %l0
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



! making function call :foo.overloaded_2
! moving all the arguments into %o registers
	add	%sp, -(.SAVE_foo.overloaded_2_extra_argument_8) & -8, %sp
	set	10, %l0
! 0th argument of this function
	mov	%l0, %o0
	set	15, %l0
! 1th argument of this function
	mov	%l0, %o1
	.SAVE_foo.overloaded_2_extra_argument_8 = 0
	call	foo.overloaded_2
	nop
! Deallocate stack space
	sub	%sp, -(0)& -8, %sp
! Store return to a local tmp
	st	%o0, [%fp-8]

! indodesID : FuncCall
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
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
	SAVE.main = -(92 + 8) & -8
