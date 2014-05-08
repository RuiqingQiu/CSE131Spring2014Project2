/*
 * Generated Wed May 07 20:08:58 PDT 2014
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

! init variable: b
	set	2, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! adding first operand:a to %l1
	mov	%l0, %l1

! indodesID
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! adding second operand:b to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-12]
! init is an expression
! init variable: c
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-16, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop

! indodesID
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! adding first operand:c to %l1
	mov	%l0, %l1

	set	55, %l0! adding second operand:55 to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-20]
! init is an expression
! init variable: z
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-24, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID
	set	-24, %l0
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
	SAVE.main = -(92 + 24) & -8
