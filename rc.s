/*
 * Generated Sat May 10 17:08:32 PDT 2014
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
! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

! indodesID : y
	set	y, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

	fitos	%f0, %f1
! indodesID : y
	set	y, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

	mov	%l0, %f0
	fitos	%f0, %f2
! adding %f1 & %f2 to %f0
	fadds	%f1, %f2, %f0
	st	%f0, [%fp-4]
! indodesID : AddOp
	set	-4, %l0
	add	%fp, %l0, %l0
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
