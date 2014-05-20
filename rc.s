/*
 * Generated Tue May 20 10:51:26 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"
_indexOutOfBoundMsg:	.asciz "Index value of %d is outside legal range [0,%d).\n"
_nullPtrDereferenceMsg:	.asciz "Attempt to dereference NULL pointer.\n"

	.section ".data"
	.align 4
value_one:	.single 0r1.0
	.section ".bss"
	.global	fp7
	.align 4
fp7:	.skip 4

	.section ".text"
	.align 4
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
	.section ".bss"
	.align 4
.internalStatic_fp80:	.skip 4

	.section ".text"
	.align 4
	.section ".text"
	.align 4
! local variable:   fp9    without init, just add offset
! indodesID : fp7
	set	fp7, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	fmovs	%f0, %f1
	fmovs	%f0, %f2
! cmp %f1 & %f2
	fcmps	%f1, %f2
	nop
	fbe	equalEqual3
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-8]
	ba	equalEqual3_done
	nop

equalEqual3:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-8]
equalEqual3_done:

! indodesID : EqualOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! NotOp first operand:EqualOp to %l1
	mov	%l0, %l1

	cmp	%l1, %g0
	be	NotOpSetZero4
	nop
! the value is true, need to set to false
	mov	%g0, %l1
	set	-16, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	ba	endOfNotOp4
	nop
! the value is false, need to set to true
NotOpSetZero4: 
	set	1, %l1
	set	-16, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

endOfNotOp4: 
! indodesID : NotOp
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	else_stmt_5
	nop
	set	_strFmt, %o0
	set	._str_fmt_main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main0:	.asciz "failure7"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	end_if_stmt_6
	nop
else_stmt_5: 

end_if_stmt_6: 

! indodesID : fp8
	set	.internalStatic_fp80, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	fmovs	%f0, %f1
	fmovs	%f0, %f2
! cmp %f1 & %f2
	fcmps	%f1, %f2
	nop
	fbne	notEqualTo7
	nop

! notEqualOp set false
	set	0, %l0
	st	%l0, [%fp-20]
	ba	notEqualTo7_done
	nop

notEqualTo7:	
! notEqualOp set true
	set	1, %l0
	st	%l0, [%fp-20]
notEqualTo7_done:

! indodesID : NotEqualOp
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	else_stmt_8
	nop
	set	_strFmt, %o0
	set	._str_fmt_main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main1:	.asciz "failure8"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	end_if_stmt_9
	nop
else_stmt_8: 

end_if_stmt_9: 

	set	0, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 20) & -8
