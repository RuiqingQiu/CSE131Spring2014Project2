/*
 * Generated Wed May 14 13:22:26 PDT 2014
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
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   a    without init, just add offset
! doing array dereference
	set	2, %l0
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-44]
! done with do array des
! Doing Assignment, getting the right side value
	set	1, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-44, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]
! doing array dereference
	set	2, %l0
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-48]
! done with do array des
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
	SAVE.main = -(92 + 48) & -8
