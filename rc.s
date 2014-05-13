/*
 * Generated Mon May 12 18:43:38 PDT 2014
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
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   intVar    without init, just add offset
! indodesID : intVar
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! Doing CIN statement
	set	-4, %l0
	add	%fp, %l0, %l0
	call	inputInt
	nop
	st	%o0, [%l0]
! indodesID : intVar
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

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
	SAVE.main = -(92 + 4) & -8
