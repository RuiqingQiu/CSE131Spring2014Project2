/*
 * Generated Sun May 11 19:13:41 PDT 2014
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
	.global	k
	.align 4
k:	.word 100

	.section ".text"
	.align 4
	.global fobi
fobi:
	set	SAVE.fobi, %g1
	save	%sp, %g1, %sp
! local variable:   k    without init, just add offset
! indodesID : k
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : k
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! GreaterThanOP first operand:k to %l1
	mov	%l0, %l1

	set	100, %l0! GreaterThanOP second operand:100 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bg	greaterThan1
	nop

! greatThanOp set false
	set	0, %l0
	st	%l0, [%fp-8]
	ba	greaterThan1_done
	nop

greaterThan1:	
! greatThanOp set true
	set	1, %l0
	st	%l0, [%fp-8]
greaterThan1_done:

! indodesID : GreaterThanOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	else_stmt_2
	nop
	set	0, %l0
return const! return stmt
	mov	%l0, %i0
	ba	end_if_stmt_4
	nop
else_stmt_2: 

end_if_stmt_4: 

! indodesID : k
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! indodesID : k
	set	k, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! Doing Assignment, getting the right side value
! indodesID : k
	set	k, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
! indodesID : k = k
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
! indodesID : k
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	call	fobi
	nop
! Store return to a local tmp
	st	%o0, [%fp-12]

! indodesID : k
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! adding first operand:k to %l1
	mov	%l0, %l1

! indodesID : FuncCall
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! adding second operand:FuncCall to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-16]
! indodesID : AddOp
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! return stmt
	mov	%l0, %i0
	ret
	restore

! from DoFuncDecl2
	SAVE.fobi = -(92 + 16) & -8
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
	call	fobi
	nop
! Store return to a local tmp
	st	%o0, [%fp-4]

! indodesID : FuncCall
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

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 4) & -8
