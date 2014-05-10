/*
 * Generated Fri May 09 21:29:26 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".data"
	.global	x
	.align 4
x:	.word 10

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   y    without init, just add offset
! indodesID : y
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! Doing Assignment, getting the right side value
! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 4) & -8
