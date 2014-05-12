/*
 * Generated Sun May 11 18:48:30 PDT 2014
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
x:	.word 1

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! init variable: x
	set	0, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	setFalse1
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done1
	nop
setFalse1:
	set	_boolF, %o0
	call	printf
	nop
done1:
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 4) & -8
