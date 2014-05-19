/*
 * Generated Mon May 19 16:46:19 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"
_indexOutOfBoundMsg:	.asciz "Index value of %d is outside legal range [0, %d).\n"

	.section ".data"
	.align 4
value_one:	.single 0r1.0
	.section ".bss"
	.global	a
	.align 4
a:	.skip 40

	.section ".text"
	.align 4
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! init variable: y
	set	11, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : y
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! get the index value into %l0
! indodesID : y
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_a_1
	nop
! No error
	ba	.array_bound_check_a_1_end
	nop
! Index Out Of Bound
.array_bound_check_a_1: 
	set	_indexOutOfBoundMsg, %o0
	set	%l1, %o1
	set	10, %o2
	call	printf
	nop
! Calling Exit 1
	set	1, %o0
	call	exit
	nop
.array_bound_check_a_1_end: 
! indodesID : y
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	a, %l0
	add	%g0, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-8]
! done with do array des
! init variable: x
! init is an expression
! indodesID : array_doDesignator2
	set	-8, %l0
	add	%fp, %l0, %l0
! ExprSTO: array_doDesignator2 hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	mov	%l0, %l1
	set	-12, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 12) & -8
