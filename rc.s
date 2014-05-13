/*
 * Generated Mon May 12 22:02:30 PDT 2014
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
	set	10, %l1
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

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : i
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! equalOP first operand:i to %l1
	mov	%l0, %l1

	set	5, %l0
! EqualThanOP second operand:5 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	be	equalEqual3
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-16]
	ba	equalEqual3_done
	nop

equalEqual3:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-16]
equalEqual3_done:

! indodesID : EqualOp
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	else_stmt_4
	nop
! break stmt
	ba	whileStmt_1_end
	nop
	ba	end_if_stmt_5
	nop
else_stmt_4: 

end_if_stmt_5: 

! indodesID : GreaterThanOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! while loop ending condition check
	cmp	%l0, %g0
	bne	whileStmt_1
	nop
whileStmt_1_end: 
	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 16) & -8
