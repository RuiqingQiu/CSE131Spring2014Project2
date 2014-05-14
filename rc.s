/*
 * Generated Tue May 13 22:53:38 PDT 2014
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
	.section ".bss"
	.align 4
.globalScope_a0:	.skip 4

	.global	.const_global_b1
	.align 4
	.section ".data"
.const_global_b1:	.word 10

	.align 4
	.section ".data"
.AutoConstGlobalScope_c3:	.word 10

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! indodesID : a
	set	.globalScope_a0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! Doing Assignment, getting the right side value
	set	10, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	.globalScope_a0, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]
! indodesID : a
	set	.globalScope_a0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! indodesID : b
! Doing Assignment, getting the right side value
	set	10, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	.globalScope_a0, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]
! indodesID : a
	set	.globalScope_a0, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0

! indodesID : c
! Doing Assignment, getting the right side value
	set	10, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	.globalScope_a0, %l0
	add	%g0, %l0, %l0
	st	%l1, [%l0]
	ret
	restore

! from DoFuncDecl2
	SAVE.main = -92 & -8
