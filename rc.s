/*
 * Generated Wed May 21 11:16:44 PDT 2014
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
.value_one:	.single 0r1.0
.value_zero:	.single 0r0.0
	.section ".text"
	.align 4
	.global add
add:
	set	SAVE.add, %g1
	save	%sp, %g1, %sp


! storing 0th element onto stack
	set	68, %l0
	add	%fp, %l0, %l0
	st	%i0, [%l0]


! storing 1th element onto stack
	set	72, %l0
	add	%fp, %l0, %l0
	st	%i1, [%l0]


! storing 2th element onto stack
	set	76, %l0
	add	%fp, %l0, %l0
	st	%i2, [%l0]


! storing 3th element onto stack
	set	80, %l0
	add	%fp, %l0, %l0
	st	%i3, [%l0]


! storing 4th element onto stack
	set	84, %l0
	add	%fp, %l0, %l0
	st	%i4, [%l0]


! storing 5th element onto stack
	set	88, %l0
	add	%fp, %l0, %l0
	st	%i5, [%l0]
! indodesID : a
	set	68, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : b
	set	72, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : a
	set	68, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:a to %l1
	mov	%l0, %l1

! indodesID : b
	set	72, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:b to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-4]
! indodesID : c
	set	76, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : AddOp
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:AddOp to %l1
	mov	%l0, %l1

! indodesID : c
	set	76, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:c to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-8]
! indodesID : d
	set	80, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : AddOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:AddOp to %l1
	mov	%l0, %l1

! indodesID : d
	set	80, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:d to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-12]
! indodesID : e
	set	84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : AddOp
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:AddOp to %l1
	mov	%l0, %l1

! indodesID : e
	set	84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:e to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-16]
! indodesID : f
	set	88, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : AddOp
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:AddOp to %l1
	mov	%l0, %l1

! indodesID : f
	set	88, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:f to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-20]
! indodesID : g
	set	92, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : AddOp
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:AddOp to %l1
	mov	%l0, %l1

! indodesID : g
	set	92, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:g to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-24]
! indodesID : h
	set	96, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : AddOp
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding first operand:AddOp to %l1
	mov	%l0, %l1

! indodesID : h
	set	96, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! adding second operand:h to %l2
	mov	%l0, %l2

	add	%l1, %l2, %l0
	st	%l0, [%fp-28]
! indodesID : AddOp
	set	-28, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.add = -(92 + 28) & -8
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp


! making function call :add
! moving all the arguments into %o registers
	set	1, %l0
! 0th argument of this function
	mov	%l0, %o0
	set	2, %l0
! 1th argument of this function
	mov	%l0, %o1
	set	3, %l0
! 2th argument of this function
	mov	%l0, %o2
	set	4, %l0
! 3th argument of this function
	mov	%l0, %o3
	set	5, %l0
! 4th argument of this function
	mov	%l0, %o4
	set	6, %l0
! 5th argument of this function
	mov	%l0, %o5
	set	7, %l0
! 6th argument of this function
! 6th argument of this function
	st	%l0, [%sp+92]
	set	8, %l0
! 7th argument of this function
! 7th argument of this function
	st	%l0, [%sp+96]
	call	add
	nop
! Store return to a local tmp
	st	%o0, [%fp-4]

! indodesID : FuncCall
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
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
