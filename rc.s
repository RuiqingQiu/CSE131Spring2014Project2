/*
 * Generated Tue May 13 00:22:57 PDT 2014
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
! init variable: i
	set	55, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_1: 
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! PostDecOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	dec	%l1

	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : postDecOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! GreaterThanOP first operand:postDecOp to %l1
	mov	%l0, %l1

	set	0, %l0
! GreaterThanOP second operand:0 to %l2
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

! indodesID : GreaterThanOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, %g0
	be	whileStmt_1_end
	nop
! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! modOP first operand:i to %o0
	mov	%l0, %o0

	set	2, %l0! modOP second operand:2 to %o1
	mov	%l0, %o1

! modOP second operand:2 to %o1
	mov	%l0, %o1

	call	.rem
	nop
	st	%o0, [%fp-16]
! indodesID : ModOp
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! equalOP first operand:ModOp to %l1
	mov	%l0, %l1

	set	0, %l0
! EqualThanOP second operand:0 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	be	equalEqual3
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-20]
	ba	equalEqual3_done
	nop

equalEqual3:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-20]
equalEqual3_done:

! indodesID : EqualOp
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	else_stmt_4
	nop
! continue stmt
	ba	whileStmt_1
	nop
	ba	end_if_stmt_5
	nop
else_stmt_4: 

end_if_stmt_5: 

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
! indodesID : GreaterThanOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! while loop ending always go back
	ba	whileStmt_1
	nop
whileStmt_1_end: 
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 20) & -8
