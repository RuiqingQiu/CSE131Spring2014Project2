/*
 * Generated Wed May 14 19:21:13 PDT 2014
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
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! init variable: x
	set	1, %l1
	set	-4, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : x
	set	-4, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID

! Doing address of operation
	set	-4, %l0
	add	%fp, %l0, %l0
! Store the address onto tmp
	st	%l0, [%fp-8]
! init variable: y
! init is an expression
! indodesID : AddressOfOp
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! end of DoDesID
	mov	%l0, %l1
	set	-12, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! indodesID : pointer dereference
	set	null, %l0
	add	null, %l0, %l0
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
	SAVE.main = -(92 + 12) & -8
