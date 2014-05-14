/*
 * Generated Tue May 13 23:56:08 PDT 2014
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
! local variable:   m    without init, just add offset

! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	0, %l1
	add	%l0, %l1, %l0
! put the address of the field into %l2
	mov	%l0, %l2
! load the value of the field and put into %l0
	ld	[%l0], %l0
! Doing Assignment, getting the right side value
	set	1, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	mov	%l2, %l0
	st	%l1, [%l0]

! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into %l2
	mov	%l0, %l2
! load the value of the field and put into %l0
	ld	[%l0], %l0
! Doing Assignment, getting the right side value
	.section ".data"
	.align 4
dodes_dot_assign_right_f_return_2:	.single 0r1.1
	.section ".text"
	.align 4
	set	dodes_dot_assign_right_f_return_2, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	mov	%l2, %l0
	st	%l1, [%l0]

! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into %l2
	mov	%l0, %l2
! load the value of the field and put into %l0
	ld	[%l0], %l0
! Doing Assignment, getting the right side value
	set	0, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	mov	%l2, %l0
	st	%l1, [%l0]

! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
	set	0, %l1
	add	%l0, %l1, %l0
! put the address of the field into %l2
	mov	%l0, %l2
! load the value of the field and put into %l0
	ld	[%l0], %l0
! indodesID : dodes_dot
	set	null, %l0
	add	null, %l0, %l0
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
	SAVE.main = -(92 + 12) & -8
