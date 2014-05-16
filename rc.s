/*
 * Generated Thu May 15 19:25:10 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".data"
	.align 4
value_one:	.single 0r1.0
	.section ".text"
	.align 4
	.global sum
sum:
	set	SAVE.sum, %g1
	save	%sp, %g1, %sp


! storing 0th element onto stack
	set	68, %l0
	add	%fp, %l0, %l0
	st	%i0, [%l0]
! doing array dereference
	set	1, %l0
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	68, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-4]
! done with do array des
! indodesID : array_doDesignator2
	set	-4, %l0
	add	%fp, %l0, %l0
! ExprSTO: array_doDesignator2 hold address, one more load
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
	SAVE.sum = -(92 + 4) & -8
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   a    without init, just add offset


! making function call :sum
! moving all the arguments into %o registers
! argument pass by reference, get the address
	set	-40, %l0
	add	%fp, %l0, %l0
! 0th argument of this function
	mov	%l0, %o0
	call	sum
	nop
! Store return to a local tmp
	st	%o0, [%fp-44]

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 44) & -8
