/*
 * Generated Sat May 10 16:26:48 PDT 2014
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
	ba	delctype0
	nop
! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! PostIncOp first operand:x to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	x, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]

decltype0: 
! local variable:   y    without init, just add offset
! indodesID : x
	set	x, %l0
	add	%g0, %l0, %l0
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
	SAVE.main = -(92 + 8) & -8
