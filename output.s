/*
 * Generated Wed May 07 19:06:44 PDT 2014
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

	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! adding first operand:a to %l1
	mov	%l0, %l1

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

	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! convert to positive and store
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	mov	%l0, %o0
	set	-1, %o1
	call	.mul
	nop
	st	%o0, [%fp-20]
! adding first operand:c to %l1
	mov	%l0, %l1

	set	55, %l0! adding second operand:55 to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-24]
! init is an expression
! init variable: z
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-28, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

	set	-28, %l0
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
	SAVE.main = -(92 + 28) & -8
