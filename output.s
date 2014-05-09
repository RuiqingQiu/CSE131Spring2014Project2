/*
 * Generated Thu May 08 22:29:31 PDT 2014
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
	set	2, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! init variable: y
	set	3, %l1
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

! GreaterThanOP first operand:x to %l1
	mov	%l0, %l1

! indodesID
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! GreaterThanOP first operand:y to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bg	greaterThan2
	nop

! greatThanOp set false
	set	0, %l0
	st	%l0, [%fp-12]
	ba	greaterThan2_done
	nop

greaterThan2:	
! greatThanOp set true
	set	1, %l0
	st	%l0, [%fp-12]
greaterThan2_done:

! indodesID
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	if_stmt_3
	nop
	set	_strFmt, %o0
	set	main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main0:	.asciz "hello"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	if_stmt_3
	nop
if_stmt_3: 

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 12) & -8
