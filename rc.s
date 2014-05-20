/*
 * Generated Mon May 19 18:25:36 PDT 2014
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
	set	1, %l0
! return stmt
	mov	%l0, %i0
	ret
	restore

	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -92 & -8
	.section ".data"
	.global	p
	.align 4
p:	.word foo

	.section ".text"
	.align 4
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp


! Making Function Ptr Call : p
	set	p, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l0
! Moving the function call address to %l1
	mov	%l0, %l1
	call	%l1
	nop
! indodesID : FuncCall
	set	-4, %l0
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
	SAVE.main = -(92 + 4) & -8
