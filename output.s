/*
 * Generated Thu May 08 21:09:51 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".text"
	.align 4
	.global foo
foo:
	set	SAVE.foo, %g1
	save	%sp, %g1, %sp
	set	_strFmt, %o0
	set	foo0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
foo0:	.asciz "second "

	.section ".text"
	.align 4

! init variable: y
	set	1000, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	0, %l0
! return stmt
	mov	%l0, %o0
	ret
	restore

! from DoFuncDecl2
	SAVE.foo = -(92 + 4) & -8
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! init variable: x
	set	100, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	_strFmt, %o0
	set	main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main1:	.asciz "first "

	.section ".text"
	.align 4

	call	foo
	nop
! Store return to a local tmp
	st	%o0, [%fp-8]

! indodesID
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 8) & -8
