/*
 * Generated Sun May 11 19:30:52 PDT 2014
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
! init variable: x
	set	1, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : x
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : x
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! NotOp first operand:x to %l1
	mov	%l0, %l1

	cmp	%l1, %g0
	be	NotOpSetZero1
	nop
! the value is true, need to set to false
	set	%g0, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	ba	endOfNotOp1
	nop
! the value is false, need to set to true
NotOpSetZero: 1
	set	%1, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

endOfNotOp: 
! init variable: y
! init is an expression
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-12, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID : y
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	setFalse3
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done3
	nop
setFalse3:
	set	_boolF, %o0
	call	printf
	nop
done3:
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 12) & -8
