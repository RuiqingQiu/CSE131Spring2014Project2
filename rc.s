/*
 * Generated Mon May 12 18:20:34 PDT 2014
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
	mov	%g0, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	ba	endOfNotOp1
	nop
! the value is false, need to set to true
NotOpSetZero1: 
	set	1, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

endOfNotOp1: 
! init variable: y
! init is an expression
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-12, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID : x
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : y
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : x
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! AndOp first operand:x to %l1
	mov	%l0, %l1

! Comparing %l1 with %g0
	cmp	%l0, %g0
	be	AndOp_False3
	nop
! indodesID : y
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! AndOp second operand:x to %l1
	mov	%l0, %l2

! Comparing %l2 with %g0
	cmp	%l0, %g0
	be	AndOp_False3
	nop
! it enter here if both side are true
	set	1, %l0
	st	%l0, [%fp-16]
	ba	AddOp_End3
	nop
AndOp_False3: 
	set	%g0, %l0
	st	%l0, [%fp-16]
AddOp_End3: 
! init variable: z
! init is an expression
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-20, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 20) & -8
