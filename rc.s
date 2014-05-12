/*
 * Generated Sun May 11 17:53:54 PDT 2014
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
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable:   c    without init, just add offset
! init variable: x
	set	1, %l1
	set	-44, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! indodesID : x
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! doing array dereference
! indodesID : x
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	mov	%l0, %l1
	set	4, %o0
	mov	%l1, %o1
	call	.mul
	nop

! move the actual offset to %l1
	mov	%o0, %l1
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %l1, %l0
	ld	[%l0], %l0
! done with do array des
	cmp	%l0, 0
	be	setFalse2
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done2
	nop
setFalse2:
	set	_boolF, %o0
	call	printf
	nop
done2:
	set	_endl, %o0
	call	printf
	nop

! indodesID : x
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! doing array dereference
! indodesID : x
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	mov	%l0, %l1
	set	4, %o0
	mov	%l1, %o1
	call	.mul
	nop

! move the actual offset to %l1
	mov	%o0, %l1
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %l1, %l0
	ld	[%l0], %l0
! done with do array des
! Doing Assignment, getting the right side value
	set	0, %l0
! moving the right side value to %l1
	mov	%l0, %l1
! Doing Assignment, getting the left side location
	set	null, %l0
	add	null, %l0, %l0
	st	%l1, [%l0]
! indodesID : x
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

! doing array dereference
! indodesID : x
	set	-44, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	mov	%l0, %l1
	set	4, %o0
	mov	%l1, %o1
	call	.mul
	nop

! move the actual offset to %l1
	mov	%o0, %l1
	set	-40, %l0
	add	%fp, %l0, %l0
	add	%l0, %l1, %l0
	ld	[%l0], %l0
! done with do array des
	cmp	%l0, 0
	be	setFalse4
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done4
	nop
setFalse4:
	set	_boolF, %o0
	call	printf
	nop
done4:
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 44) & -8
