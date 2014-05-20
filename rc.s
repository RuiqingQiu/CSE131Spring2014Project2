/*
 * Generated Tue May 20 12:28:03 PDT 2014
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
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   a    without init, just add offset
! init variable: i
	set	-1, %l1
	set	-44, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_2: 
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PreIncOp first operand:i to %l1
	mov	%l0, %l1

	inc	%l1

! Store the pre inc value into local tmp
	st	%l1, [%fp-48]
	set	-44, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : preIncOp
	set	-48, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:preIncOp to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan3
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-52]
	ba	lessThan3_done
	nop

lessThan3:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-52]
lessThan3_done:

! indodesID : LessThanOp
	set	-52, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_2_end
	nop
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! get the index value into %l0
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_4
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_4
	nop

	ba	.array_bound_check_4_end
	nop

! Index Out Of Bound
.array_bound_check_4: 
	set	_indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_4_end: 
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-56]
! done with do array des
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Doing Assignment, getting the right side value
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-56, %l0
	add	%fp, %l0, %l0
! exprSTO hold address, one more load
	ld	[%l0], %l0
	st	%l1, [%l0]
! indodesID : LessThanOp
	set	-52, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_2
	nop
whileStmt_2_end: 
! doing array dereference
	set	2, %l0
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-64]
! done with do array des

! Doing address of operation
	set	-64, %l0
	add	%fp, %l0, %l0
! addressof, targetSTO holds address, one more load
	ld	[%l0], %l0
! Store the address onto tmp
	st	%l0, [%fp-68]
! Doing type cast
! indodesID : AddressOfOp
	set	-68, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Store the value into a tmp
	st	%l0, [%fp-72]
! End of type cast


 ! Doing dereference operation
	set	-72, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_7
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_7
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_7: 
	set	_nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_7: 
	set	-72, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-76]
! End of DoDereference
! doing array dereference
	set	0, %l0
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-80]
! done with do array des

! Doing address of operation
	set	-80, %l0
	add	%fp, %l0, %l0
! addressof, targetSTO holds address, one more load
	ld	[%l0], %l0
! Store the address onto tmp
	st	%l0, [%fp-84]
! Doing type cast
! indodesID : AddressOfOp
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Store the value into a tmp
	st	%l0, [%fp-88]
! End of type cast


 ! Doing dereference operation
	set	-88, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_9
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_9
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_9: 
	set	_nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_9: 
	set	-88, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	st	%l0, [%fp-92]
! End of DoDereference
! Doing Assignment, getting the right side value
! getting the address of the right side struct
	set	-92, %l0
	add	%fp, %l0, %l0
! struct assignment, right hold address, one more load
	ld	[%l0], %l0
	mov	%l0, %o1
! getting the address of the left side struct
	set	-76, %l0
	add	%fp, %l0, %l0
! struct assignment, left hold address, one more load
	ld	[%l0], %l0
	mov	%l0, %o0
	set	20, %o2
! making memcpy function call
	call	memcpy
	nop
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Doing Assignment, getting the right side value
	set	-1, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-44, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
! Do While Label
whileStmt_12: 
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PreIncOp first operand:i to %l1
	mov	%l0, %l1

	inc	%l1

! Store the pre inc value into local tmp
	st	%l1, [%fp-120]
	set	-44, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : preIncOp
	set	-120, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:preIncOp to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan13
	nop

! lessThanOp set false
	set	0, %l0
	st	%l0, [%fp-124]
	ba	lessThan13_done
	nop

lessThan13:	
! lessThanOp set true
	set	1, %l0
	st	%l0, [%fp-124]
lessThan13_done:

! indodesID : LessThanOp
	set	-124, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_12_end
	nop
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! get the index value into %l0
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_14
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_14
	nop

	ba	.array_bound_check_14_end
	nop

! Index Out Of Bound
.array_bound_check_14: 
	set	_indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_14_end: 
! indodesID : i
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	4, %o0
	mov	%l0, %o1
	call	.mul
	nop

! the actual offset in %o0
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %o0, %l0
! Store the address into a tmp
	st	%l0, [%fp-128]
! done with do array des
! indodesID : array_doDesignator2
	set	-128, %l0
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
	set	._str_fmt_main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main0:	.asciz " "

	.section ".text"
	.align 4

! indodesID : LessThanOp
	set	-124, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_12
	nop
whileStmt_12_end: 
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
	SAVE.main = -(92 + 128) & -8
