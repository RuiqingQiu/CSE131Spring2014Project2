/*
 * Generated Sun May 11 16:48:26 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".text"
	.align 4
value_one:	.single 0r1.0
	.section ".data"
	.global	x
	.align 4
x:	.single 0r1.1

	.section ".data"
	.global	y
	.align 4
y:	.single 0r2.2

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! indodesID : y
	set	y, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

! Doing Assignment, getting the right side value
	set	3, %l0
! prompt int to float
	st	%l0, [%fp-4]
	ld	[%fp-4], %f0
	fitos	 %f0, %f0
	set	y, %l0
	add	%g0, %l0, %l0
	st	%f0, [%l0]

! indodesID : y
	set	y, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

	call	printFloat
	nop
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 4) & -8
