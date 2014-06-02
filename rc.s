/*
 * Generated Sun Jun 01 21:54:36 PDT 2014
 */

	.section ".rodata"
.endl:		.asciz "\n"
.intFmt:	.asciz "%d"
.strFmt:	.asciz "%s"
.boolT:		.asciz "true"
.boolF:		.asciz "false"
.indexOutOfBoundMsg:	.asciz "Index value of %d is outside legal range [0,%d).\n"
.nullPtrDereferenceMsg:	.asciz "Attempt to dereference NULL pointer.\n"
.doubleDeleteErrorMsg:	.asciz "Double delete detected. Memory region has already been released in heap space.\n"
.memoryLeakErrorMsg:	.asciz "%d memory leak(s) detected in heap space.\n"
.deallocatedStackMsg:	.asciz "Attempt to dereference a pointer into deallocated stack space.\n"

	.section ".data"
	.align 4
.value_one:	.single 0r1.0
.value_zero:	.single 0r0.0
.lowest_stack_pointer:	.word 0xFFFFFFFF
.heap_check_list_head:	.word 0
.heap_check_list_current:	.word 0
.heap_check_list_size:	.word 0
.total_memory_leak:	.word 0
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! Allocate heap space for head of the linkedlist
	set	1, %o0
	set	12, %o1
	call	calloc
	nop
! Add the address into the heap lookup list
	mov	%o0, %l1
! Update the current node address for create the list
	set	.heap_check_list_current, %l0
	st	%l1, [%l0]
	set	.heap_check_list_head, %l0
	st	%l1, [%l0]
	ld	[%l0], %l0
	!init deleted field to be false
	set	0, %l1
	add	%l0, 4, %l0
	st	%l1, [%l0]
	set	1, %l1
	set	.heap_check_list_size, %l0
	st	%l1, [%l0]
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
! local variable:   p    without init, just add offset
! Local variable, offset: -40 base: %fp
! init variable: i
	set	0, %l1
	set	-84, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Do While Label
whileStmt_3: 
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:i to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan4
	nop

! lessThanOp set false
	set	0, %l0
	set	-92, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
	ba	lessThan4_done
	nop

lessThan4:	
! lessThanOp set true
	set	1, %l0
	set	-92, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
lessThan4_done:

! indodesID : LessThanOp
	set	-92, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_3_end
	nop
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! get the index value into %l0
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_5
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_5
	nop

	ba	.array_bound_check_5_end
	nop

! Index Out Of Bound
.array_bound_check_5: 
	set	.indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_5_end: 
! indodesID : i
	set	-84, %l0
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
	set	-96, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
! done with do array des
! doing new statement 
	set	1,%o0
	set	4, %o1
	call	calloc
	nop
! need to store the newly allocated mem to the pointer
	set	-96, %l0
	add	%fp, %l0, %l0
	st	%o0, [%l0]
! Store the value of the address we allocated
	mov	%o0, %l1
	set	.heap_check_list_head, %l0
	ld	[%l0], %l0
.set_new_node_6_start: 
	ld	[%l0], %l2
	mov	%l2, %o1
	set	.intFmt, %o0
	call	printf
	nop
	set	.boolF, %o1
	set	.strFmt, %o0
	call	printf
	nop
	mov	%l1, %o1
	set	.intFmt, %o0
	call	printf
	nop
	set	.endl, %o0
	call	printf
	nop
! Compare the current node address field to new address
	cmp	%l1, %l2
	be	.set_new_node_6
	nop
	add	%l0, 8, %l0
	ld	[%l0], %l2
! Check if there's no next
	cmp	%l2, %g0
	be	.set_new_node_6_allocate
	nop
	mov	%l2, %l0
	ba	.set_new_node_6_start
	nop
.set_new_node_6_allocate:
! Allocate new node
	set	1, %o0
	set	12, %o1
	call	calloc
	nop
	st	%o0, [%l0]
	ld[%l0], %l0
	st	%l1, [%l0]
	set	0, %l1
	st	%l1, [%l0+4]
	st	%l1, [%l0+8]
	ba	.set_new_node_6_end
	nop
.set_new_node_6: 
	add	%l0, 4, %l0
	set	0, %l1
	st	%l1, [%l0]
.set_new_node_6_end: 
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-100, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-84, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : LessThanOp
	set	-92, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_3
	nop
whileStmt_3_end: 
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Doing Assignment, getting the right side value
	set	0, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	-84, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]
! Do While Label
whileStmt_8: 
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! lessThanOP first operand:i to %l1
	mov	%l0, %l1

	set	10, %l0
! lessThanOP second operand:10 to %l2
	mov	%l0, %l2

	cmp	%l1, %l2
	bl	lessThan9
	nop

! lessThanOp set false
	set	0, %l0
	set	-108, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
	ba	lessThan9_done
	nop

lessThan9:	
! lessThanOp set true
	set	1, %l0
	set	-108, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
lessThan9_done:

! indodesID : LessThanOp
	set	-108, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	cmp	%l0, %g0
	be	whileStmt_8_end
	nop
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! doing array dereference
! get the index value into %l0
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! Move the value to %l1
	mov	%l0, %l1
	cmp	%l1, 10
	bge	.array_bound_check_10
	nop

! No error
! Check less than 0
	cmp	%l1, %g0
	bl	.array_bound_check_10
	nop

	ba	.array_bound_check_10_end
	nop

! Index Out Of Bound
.array_bound_check_10: 
	set	.indexOutOfBoundMsg, %o0
	mov	%l1, %o1
	set	10, %o2
	call	printf
	nop

! Calling Exit 1
	set	1, %o0
	call	exit
	nop

.array_bound_check_10_end: 
! indodesID : i
	set	-84, %l0
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
	set	-112, %l2
	add	%fp, %l2, %l2
	st	%l0, [%l2]
! done with do array des
! doing delete statement 
	set	-112, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
! %l0 stores the address of the pointer
! need to check if delete a nullptr
! Check if the dereferenced result is nullptr.
	cmp	%l0,%g0
	be	.nullptr_dereference_check_11
	nop
 ! dereferenced result is not nullptr.
	ba	.nullptr_dereference_check_end_11
	nop
! dereferenced result if nullptr 
.nullptr_dereference_check_11: 
	set	.nullPtrDereferenceMsg,%o0
	call	printf
	nop
	set	1,%o0
	call	exit
	nop
.nullptr_dereference_check_end_11: 
! Doing double delete check
	set	-112, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
	mov	%l0, %l1
	set	.heap_check_list_head, %l0
	ld	[%l0], %l0
.double_delete_check_11_start: 
	ld	[%l0], %l2
	mov	%l2, %o1
	set	.intFmt, %o0
	call	printf
	nop
	set	.boolT, %o1
	set	.strFmt, %o0
	call	printf
	nop
	mov	%l1, %o1
	set	.intFmt, %o0
	call	printf
	nop
	set	.endl, %o0
	call	printf
	nop
	cmp	%l1, %l2
	be	.double_delete_check_11
	nop
	add	%l0, 8, %l0
	ld	[%l0], %l0
	cmp	%l0, %g0
	be	.double_delete_check_11_end
	nop
	ba	.double_delete_check_11_start
	nop
.double_delete_check_11: 
	add	%l0, 4, %l0
	ld	[%l0], %l2
	cmp	%l2, %g0
	be	.double_delete_check_11_true
	nop
	set	.doubleDeleteErrorMsg, %o0
	call	printf
	nop
	set	1, %o0
	call	exit
	nop
.double_delete_check_11_true: 
	set	1, %l1
	st	%l1, [%l0]
.double_delete_check_11_end: 
	set	-112, %l0
	add	%fp, %l0, %l0
	mov	%l0,%o0
	call	free
	nop

! set pointer to null
	st	%g0, [%l0]
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! indodesID : i
	set	-84, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! PostIncOp first operand:i to %l1
	mov	%l0, %l1

! Store the previous value before post inc to a tmp location
	set	-116, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	inc	%l1

	set	-84, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : LessThanOp
	set	-108, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
! while loop ending always go back
	ba	whileStmt_8
	nop
whileStmt_8_end: 
	set	.strFmt, %o0
	set	._str_fmt_main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
._str_fmt_main0:	.asciz "done"

	.section ".text"
	.align 4

	set	.endl, %o0
	call	printf
	nop

	set	.heap_check_list_head, %l0
	set	.total_memory_leak, %l1
	ld	[%l1], %l1
	ld	[%l0], %l0
.check_memory_leak_12_start: 
	ld	[%l0+4], %l2
	cmp	%l2, %g0
	be	.check_memory_leak_12
	nop
	add	%l0, 8, %l0
	ld	[%l0], %l0
	cmp	%l0, %g0
	be	.check_memory_leak_12_end
	nop
	ba	.check_memory_leak_12_start
	nop
.check_memory_leak_12: 
	inc	%l1
	add	%l0, 8, %l0
	ld	[%l0], %l0
	cmp	%l0, %g0
	be	.check_memory_leak_12_end
	nop
	ba	.check_memory_leak_12_start
	nop
.check_memory_leak_12_end: 
	sub	%l1, 1, %l1
	cmp	%l1, %g0
	be	.check_memory_leak_12_no_memory_leak
	nop
	mov	%l1, %o1
	set	.memoryLeakErrorMsg, %o0
	call	printf
	nop
.check_memory_leak_12_no_memory_leak: 
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 120) & -8
