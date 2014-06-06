/*
 * Generated Thu Jun 05 20:55:59 PDT 2014
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
	.section ".data"
	.global	a
	.align 4
a:	.word nullptr

	.section ".text"
	.align 4
