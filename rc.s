/*
 * Generated Sun May 18 19:54:47 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".data"
	.align 4
value_one:	.single 0r1.0
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! Const local
	set	50, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : c
! end of DoDesID
! local variable:   a    without init, just add offset
! init variable: p
! Array name assign to pointer
	set	-204, %l0
	add	%fp,%l0, %l0
	mov	%l0, %l1
	set	-208, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! init variable: i
	set	-1, %l1
	set	-212, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_4: 
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PreIncOp first operand:i to %l1
	mov	%l0, %l1

	inc	%l1

! Store the pre inc value into local tmp
	st	%l1, [%fp-216]
	set	-212, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : c
! end of DoDesID
! indodesID : preIncOp
	set	-216, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:preIncOp to %l1
	mov	%l0, %l1

	set	50, %l0
! lessThanOP second operand:c to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan5
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-220]
	ba	lessThan5_done
	nop

lessThan5:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-220]
lessThan5_done:

! indodesID : LessThanOp
	set	-220, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_4_end
	nop
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-204, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-224]
! done with do array des
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Doing Assignment, getting the right side value
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-224, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-212, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-228, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-212, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! doing array dereference
! indodesID : postIncOp
	set	-228, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-208, %l0
	add	%fp, %l0, %l0
! pointer type array dereference
	ld	[%l0], %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-232]
! done with do array des
! indodesID : array_doDesignator2
	set	-232, %l0
	add	%fp, %l0, %l0
! ExprSTO: array_doDesignator2 hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_strFmt, %o0
	set	main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main0:	.asciz " "

	.section ".text"
	.align 4

! indodesID : LessThanOp
	set	-220, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_4
	nop
whileStmt_4_end: 
	set	_endl, %o0
	call	printf
	nop

	set	0, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 232) & -8
