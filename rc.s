/*
 * Generated Mon May 12 21:12:57 PDT 2014
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
	.section ".data"
	.global	success
	.align 4
success:	.word 1

	.section ".text"
	.align 4
	.global fail
fail:
	set	SAVE.fail, %g1
	save	%sp, %g1, %sp
	set	_strFmt, %o0
	set	fail0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
fail0:	.asciz "failure"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

! indodesID : success
	set	success, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! Doing Assignment, getting the right side value
	set	0, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	success, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]
	set	1, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.fail = -92 & -8
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

! init variable: x
	set	0, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : a
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : a
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! OrOp first operand:a to %l1
	mov	%l0, %l1

! Comparing %l1 with %g0
	cmp	%l0, %g0
	bne	OrOp_True4
	nop
! making function call :fail
	call	fail
	nop
! Store return to a local tmp
	st	%o0, [%fp-12]

! indodesID : FuncCall
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! OrOp second operand:a to %l1
	mov	%l0, %l2

! Comparing %l2 with %g0
	cmp	%l0, %g0
	bne	OrOp_True4
	nop
! it enter here if both side are false
	set	0, %l0
	st	%l0, [%fp-16]
	ba	OrOp_End5
	nop
OrOp_True4: 
	set	1, %l0
	st	%l0, [%fp-16]
OrOp_End5: 
! init variable: b
! init is an expression
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-20, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID : success
	set	success, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! indodesID : success
	set	success, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	else_stmt_7
	nop
	set	_strFmt, %o0
	set	main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main1:	.asciz "success"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	end_if_stmt_8
	nop
else_stmt_7: 

end_if_stmt_8: 

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 20) & -8
