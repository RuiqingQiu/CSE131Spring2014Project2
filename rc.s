/*
 * Generated Wed May 21 13:49:23 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"
_indexOutOfBoundMsg:	.asciz "Index value of %d is outside legal range [0,%d).\n"
_nullPtrDereferenceMsg:	.asciz "Attempt to dereference NULL pointer.\n"

	.section ".data"
	.align 4
.value_one:	.single 0r1.0
.value_zero:	.single 0r0.0
.lowest_stack_pointer:	.word 0
	.section ".text"
	.align 4
	.global bad
bad:
	set	SAVE.bad, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	cmp	%sp, %l0
	bg	._DealloStack_bad0
	nop

! No update for stack pointer
	ba	._DealloStack_bad0_end
	nop

._DealloStack_bad0: 
! Store the current stack pointer address to global
	st	%sp, [%l0]

._DealloStack_bad0_end: 
! init variable: z
	set	10, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : z
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID

! Doing address of operation
	set	-4, %l0
	add	%fp, %l0, %l0
! Store the address onto tmp
	st	%l0, [%fp-8]
! indodesID : AddressOfOp
	set	-8, %l0
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
	SAVE.bad = -(92 + 8) & -8
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	cmp	%sp, %l0
	bg	._DealloStack_main3
	nop

! No update for stack pointer
	ba	._DealloStack_main3_end
	nop

._DealloStack_main3: 
! Store the current stack pointer address to global
	st	%sp, [%l0]

._DealloStack_main3_end: 


! making function call :bad
	call	bad
	nop
! Store return to a local tmp
	st	%o0, [%fp-4]


 ! Doing dereference operation
	set	-4, %l0
	add	%fp, %l0, %l0
! Load pointer to get its value, the address it's pointing to
	ld	[%l0], %l0
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_5
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_5
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_5: 
	set	_nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_5: 
	set	-4, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-8]
! End of DoDereference
! indodesID : pointer dereference
	set	-8, %l0
	add	%fp, %l0, %l0
! ExprSTO: pointer dereference hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 8) & -8
