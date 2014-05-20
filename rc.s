/*
 * Generated Mon May 19 22:47:29 PDT 2014
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
	.section ".text"
	.align 4
	.global foo
foo:
	set	SAVE.foo, %g1
	save	%sp, %g1, %sp
	.section ".bss"
	.align 4
.internalStatic_i0:	.skip 4

	.section ".text"
	.align 4
	.section ".text"
	.align 4
! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! equalOP first operand:i to %l1
	mov	%l0, %l1

	set	0, %l0
! EqualThanOP second operand:0 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	be	equalEqual2
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-4]
	ba	equalEqual2_done
	nop

equalEqual2:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-4]
equalEqual2_done:

! indodesID : EqualOp
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	else_stmt_3
	nop
	set	_strFmt, %o0
	set	._str_fmt_foo0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_foo0:	.asciz "fe"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	end_if_stmt_4
	nop
else_stmt_3: 

end_if_stmt_4: 

! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! equalOP first operand:i to %l1
	mov	%l0, %l1

	set	1, %l0
! EqualThanOP second operand:1 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	be	equalEqual5
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-8]
	ba	equalEqual5_done
	nop

equalEqual5:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-8]
equalEqual5_done:

! indodesID : EqualOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	else_stmt_6
	nop
	set	_strFmt, %o0
	set	._str_fmt_foo1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_foo1:	.asciz "fi"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	end_if_stmt_7
	nop
else_stmt_6: 

end_if_stmt_7: 

! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! equalOP first operand:i to %l1
	mov	%l0, %l1

	set	2, %l0
! EqualThanOP second operand:2 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	be	equalEqual8
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-12]
	ba	equalEqual8_done
	nop

equalEqual8:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-12]
equalEqual8_done:

! indodesID : EqualOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	else_stmt_9
	nop
	set	_strFmt, %o0
	set	._str_fmt_foo2, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_foo2:	.asciz "fo"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ba	end_if_stmt_10
	nop
else_stmt_9: 

end_if_stmt_10: 

! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! equalOP first operand:i to %l1
	mov	%l0, %l1

	set	3, %l0
! EqualThanOP second operand:3 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	be	equalEqual11
	nop

! equalOp set false
	set	0, %l0
	st	%l0, [%fp-16]
	ba	equalEqual11_done
	nop

equalEqual11:	
! equalOp set true
	set	1, %l0
	st	%l0, [%fp-16]
equalEqual11_done:

! indodesID : EqualOp
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, 0
	be	else_stmt_12
	nop
	set	_strFmt, %o0
	set	._str_fmt_foo3, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_foo3:	.asciz "fum"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Doing Assignment, getting the right side value
	set	-1, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]
	ba	end_if_stmt_14
	nop
else_stmt_12: 

end_if_stmt_14: 

! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-24, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	.internalStatic_i0, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]

	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -(92 + 24) & -8
	.section ".data"
	.global	foo
	.align 4
foo:	.word foo

	.section ".text"
	.align 4
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! init variable: fp2
! init is a function
! indodesID : foo
	set	foo, %l0
	add	%g0, %l0, %l0
! end of DoDesID
	mov	%l0, %l1
	set	-4, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! init variable: fp3
! init is a function
! indodesID : foo
	set	foo, %l0
	add	%g0, %l0, %l0
! end of DoDesID
	mov	%l0, %l1
	set	-8, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]



! making function call :foo
	call	foo
	nop
! Store return to a local tmp
	st	%o0, [%fp-12]



! Making Function Ptr Call : fp
	set	foo, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
! Moving the function call address to %l1
	mov	%l0, %l1
	call	%l1
	nop
! Store return to a local tmp
	st	%o0, [%fp-16]



! Making Function Ptr Call : fp2
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
! Moving the function call address to %l1
	mov	%l0, %l1
	call	%l1
	nop
! Store return to a local tmp
	st	%o0, [%fp-20]



! Making Function Ptr Call : fp3
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
! Moving the function call address to %l1
	mov	%l0, %l1
	call	%l1
	nop
! Store return to a local tmp
	st	%o0, [%fp-24]

	set	0, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 24) & -8
