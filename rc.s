/*
 * Generated Sun May 25 13:54:48 PDT 2014
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
! local variable:   b    without init, just add offset

! Return struct by value, memmove to the %fp+64
	set	-4,%l0
	add	%fp ,%l0, %l0
	mov	%l0, %o1

	add	%fp, 64, %l0
	ld	[%l0], %o0
	set	4, %o2
	call	memmove
	nop
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
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, %sp
	bgu	._DealloStack_main3
	nop

! No update for stack pointer
	ba	._DealloStack_main3_end
	nop

._DealloStack_main3: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main3_end: 
! Return struct by value allocate space on tmp and store the address to %sp+64
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l0, [%sp+64]


! making function call :foo
	call	foo
	nop
! Store return to a local tmp
! Return struct by value do nothing
! init variable: c
! init is an expression
! indodesID : FuncCall
	set	64, %l0
	add	%sp, %l0, %l0
! ExprSTO: FuncCall hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
! getting the address of the right side struct
	set	64, %l0
	add	%sp, %l0, %l0
	ld	[%l0], %l0
	mov	%l0, %o1
! getting the address of the left side struct
	set	-8, %l0
	add	%fp, %l0, %l0
	mov	%l0, %o0
	set	4, %o2
! making memmove function call
	call	memmove
	nop
	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 8) & -8
