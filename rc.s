/*
 * Generated Thu May 29 10:45:50 PDT 2014
 */

	.section ".rodata"
.endl:		.asciz "\n"
.intFmt:	.asciz "%d"
.strFmt:	.asciz "%s"
.boolT:		.asciz "true"
.boolF:		.asciz "false"
.indexOutOfBoundMsg:	.asciz "Index value of %d is outside legal range [0,%d).\n"
.nullPtrDereferenceMsg:	.asciz "Attempt to dereference NULL pointer.\n"
.deallocatedStackMsg:	.asciz "Attempt to dereference a pointer into deallocated stack space.\n"

	.section ".data"
	.align 4
.value_one:	.single 0r1.0
.value_zero:	.single 0r0.0
.lowest_stack_pointer:	.word 0xFFFFFFFF
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! Store that stack pointer to the global variable if it's lowest
	set	.lowest_stack_pointer, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, %sp
	bgu	._DealloStack_main0
	nop

! No update for stack pointer
	ba	._DealloStack_main0_end
	nop

._DealloStack_main0: 
! Store the current stack pointer address to global
	set	.lowest_stack_pointer, %l0
	st	%sp, [%l0]

._DealloStack_main0_end: 
! init variable: b
	.section ".data"
	.align 4
main_f_1:	.single 0r4.22
	.section ".text"
	.align 4
	set	main_f_1, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l1], %l1
	st	%l1, [%l0]

! indodesID : b
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

! end of DoDesID
! Doing type cast
! indodesID : b
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

! end of DoDesID
! Convert float to int
	st	%l0, [%fp-12]
	ld	[%fp-12], %f0
	fstoi	%f0, %f0
	st	%f0, [%fp-12]
! End of type cast

! init variable: a
! init is an expression
! indodesID : type cast
	set	-12, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	mov	%l0, %l1
	set	-16, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID : a
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	set	.intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	.endl, %o0
	call	printf
	nop

! indodesID : a
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID

! Doing address of operation
	set	-16, %l0
	add	%fp, %l0, %l0
! Store the address onto tmp
	set	-24, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
! Doing type cast
! indodesID : AddressOfOp
	set	-24, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Store the value into a tmp
	set	-28, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
! End of type cast

! init variable: c
! init is an expression
! indodesID : type cast
	set	-28, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	mov	%l0, %l1
	set	-32, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]


 ! Doing dereference operation
	set	-32, %l0
	add	%fp, %l0, %l0
! Load pointer to get its value, the address it's pointing to
	ld	[%l0], %l0
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_6
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_6
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_6: 
	set	.nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_6: 
! Check if the dereferenced result is in deallocated stack space.
	mov	%l0, %l1
! Comparing current stack pointer & dereferenced pointer address
	add	%sp, 92, %l0
	cmp	%l1, %l0
	blu	.deallocated_stack_dereference_check_6
	nop

! Enter here if it's an okay pointer dereference
	ba	.deallocated_stack_dereference_check_6_end
	nop

.deallocated_stack_dereference_check_6: 
! Comparing this pointer to maximum stack pointer to see if it's actually in the stack space
	set	.lowest_stack_pointer, %l0
	ld	[%l0], %l0
	cmp	%l1, %l0
	blu	.deallocated_stack_dereference_check_6_end
	nop

	set	.deallocatedStackMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.deallocated_stack_dereference_check_6_end: 
	set	-32, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	set	-40, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
! End of DoDereference
! indodesID : pointer_dereference
	set	-40, %l0
	add	%fp, %l0, %l0
! ExprSTO: pointer_dereference hold address, one more load
	ld	[%l0], %l0
! load float to %f0
	ld	[%l0], %f0
	ld	[%l0], %l0

! end of DoDesID
	call	printFloat
	nop
	set	.endl, %o0
	call	printf
	nop


 ! Doing dereference operation
	set	-32, %l0
	add	%fp, %l0, %l0
! Load pointer to get its value, the address it's pointing to
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
	set	.nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_7: 
! Check if the dereferenced result is in deallocated stack space.
	mov	%l0, %l1
! Comparing current stack pointer & dereferenced pointer address
	add	%sp, 92, %l0
	cmp	%l1, %l0
	blu	.deallocated_stack_dereference_check_7
	nop

! Enter here if it's an okay pointer dereference
	ba	.deallocated_stack_dereference_check_7_end
	nop

.deallocated_stack_dereference_check_7: 
! Comparing this pointer to maximum stack pointer to see if it's actually in the stack space
	set	.lowest_stack_pointer, %l0
	ld	[%l0], %l0
	cmp	%l1, %l0
	blu	.deallocated_stack_dereference_check_7_end
	nop

	set	.deallocatedStackMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.deallocated_stack_dereference_check_7_end: 
	set	-32, %l0
	add	%fp, %l0, %l0
! Dereference, load one more time
	ld	[%l0], %l0
! Store the address of the dereferenced value into tmp
	set	-44, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
! End of DoDereference
! indodesID : pointer_dereference
	set	-44, %l0
	add	%fp, %l0, %l0
! ExprSTO: pointer_dereference hold address, one more load
	ld	[%l0], %l0
! load float to %f0
	ld	[%l0], %f0
	ld	[%l0], %l0

! end of DoDesID
	fmovs	%f0, %f1
	.section ".data"
	.align 4
getValueTo_f2_f_return_8:	.single 0r4.22
	.section ".text"
	.align 4
	set	getValueTo_f2_f_return_8, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0
	fmovs	%f0, %f2
! adding %f1 & %f2 to %f0
	fadds	%f1, %f2, %f0
	set	-48, %l2
	add	%fp, %l2, %l2
	st	%f0, [%l2]
! indodesID : AddOp
	set	-48, %l0
	add	%fp, %l0, %l0
! load float to %f0
	ld	[%l0], %f0
	ld	[%l0], %l0

! end of DoDesID
	call	printFloat
	nop
	set	.endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 48) & -8
