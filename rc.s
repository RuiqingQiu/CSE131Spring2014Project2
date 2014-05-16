/*
 * Generated Fri May 16 13:45:36 PDT 2014
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
	.global	.const_global_c0
	.align 4
	.section ".data"
.const_global_c0:	.word 10

	.section ".text"
	.align 4
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   head    without init, just add offset
! local variable:   node    without init, just add offset
! doing new statement 
	set	1,%o0
	set	12, %o1
	call	calloc
	nop
! need to store the newly allocated mem to the pointer
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%o0, [%l0]

 ! Doing dereference operation
	set	-4, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-12]
! End of DoDereference

! doing struct field & put into %l2
	set	-12, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-16]
! load the value of the field and put into %l0
	ld	[%l0], %l0
! Doing Assignment, getting the right side value
	set	0, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-16, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]
! Doing Assignment, getting the right side value
! indodesID : head
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
! init variable: i
	set	0, %l1
	set	-20, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_6: 
! indodesID : i
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : c
! end of DoDesID
! indodesID : i
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:i to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:c to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan7
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-24]
	ba	lessThan7_done
	nop

lessThan7:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-24]
lessThan7_done:

! indodesID : LessThanOp
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_6_end
	nop

 ! Doing dereference operation
	set	-8, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-28]
! End of DoDereference

! doing struct field & put into %l2
	set	-28, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-32]
! load the value of the field and put into %l0
	ld	[%l0], %l0
! doing new statement 
	set	1,%o0
	set	12, %o1
	call	calloc
	nop
! need to store the newly allocated mem to the pointer
	set	-32, %l0
	add	%fp, %l0, %l0
! new statement, is reference or address, load one more time
	ld	[%l0], %l0
	st	%o0, [%l0]

 ! Doing dereference operation
	set	-8, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-36]
! End of DoDereference

! doing struct field & put into %l2
	set	-36, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-40]
! load the value of the field and put into %l0
	ld	[%l0], %l0

 ! Doing dereference operation
	set	-40, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Dereference expr hold address
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-44]
! End of DoDereference

! doing struct field & put into %l2
	set	-44, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-48]
! load the value of the field and put into %l0
	ld	[%l0], %l0

 ! Doing dereference operation
	set	-8, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-52]
! End of DoDereference

! doing struct field & put into %l2
	set	-52, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-56]
! load the value of the field and put into %l0
	ld	[%l0], %l0
! indodesID : pointer to struct arrow
	set	-56, %l0
	add	%fp, %l0, %l0
! ExprSTO: pointer to struct arrow hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:pointer to struct arrow to %l1
	mov	%l0, %l1

	set	1, %l0
! adding second operand:1 to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-60]
! Doing Assignment, getting the right side value
! indodesID : AddOp
	set	-60, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-48, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]

 ! Doing dereference operation
	set	-8, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-64]
! End of DoDereference

! doing struct field & put into %l2
	set	-64, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-68]
! load the value of the field and put into %l0
	ld	[%l0], %l0

 ! Doing dereference operation
	set	-68, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Dereference expr hold address
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-72]
! End of DoDereference

! doing struct field & put into %l2
	set	-72, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	8, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-76]
! load the value of the field and put into %l0
	ld	[%l0], %l0
! indodesID : pointer to struct arrow
	set	-76, %l0
	add	%fp, %l0, %l0
! ExprSTO: pointer to struct arrow hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop


 ! Doing dereference operation
	set	-8, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-80]
! End of DoDereference

! doing struct field & put into %l2
	set	-80, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-84]
! load the value of the field and put into %l0
	ld	[%l0], %l0

 ! Doing dereference operation
	set	-84, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Dereference expr hold address
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-88]
! End of DoDereference

! doing struct field & put into %l2
	set	-88, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	0, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-92]
! load the value of the field and put into %l0
	ld	[%l0], %l0
! Doing Assignment, getting the right side value
! indodesID : node
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-92, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]

 ! Doing dereference operation
	set	-8, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-96]
! End of DoDereference

! doing struct field & put into %l2
	set	-96, %l0
	add	%fp, %l0, %l0
! struct expr, one more load
	ld	[%l0], %l0
	set	4, %l1
	add	%l0, %l1, %l0
! put the address of the field into a tmp
	st	%l0, [%fp-100]
! load the value of the field and put into %l0
	ld	[%l0], %l0
! Doing Assignment, getting the right side value
! indodesID : pointer to struct arrow
	set	-100, %l0
	add	%fp, %l0, %l0
! ExprSTO: pointer to struct arrow hold address, one more load
	ld	[%l0], %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
! indodesID : i
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-104, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-20, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : LessThanOp
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_6
	nop
whileStmt_6_end: 
	set	0, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 104) & -8
