/*
 * Generated Fri May 09 13:00:52 PDT 2014
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
! init variable: x
	set	0, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! PreIncOp first operand:x to %l1
	mov	%l0, %l1

	inc	%l1

	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! PreIncOp first operand:x to %l1
	mov	%l0, %l1

	inc	%l1

	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID
	set	--4, %l0
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
