/*
 * Generated Tue May 06 22:23:50 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! init variable: a
	set	1, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
	set	_intFmt, %o0
	ld	[%l0], %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop

	.section ".data"
	.align 4
main_f_2:	.single 0r1.1
	.section ".text"
	.align 4
! init variable: b
	set	main_f_2, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l1], %l1
	st	%l1, [%l0]

	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %f0
	call	printFloat
	nop
	set	_endl, %o0
	call	printf
	nop

! init variable: c
	set	1, %l1
	set	-12, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
	set	_endl, %o0
	call	printf
	nop

	ret
	restore
! from DoFuncDecl2
	SAVE.main = -(92 + 12) & -8
	.section ".rodata"

