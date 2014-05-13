/*
 * Generated Tue May 13 00:52:11 PDT 2014
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
	.global print
print:
	set	SAVE.print, %g1
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
	set	_strFmt, %o0
	set	print0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
print0:	.asciz "int i is : "

	.section ".text"
	.align 4

! indodesID : i
	set	68, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	print1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
print1:	.asciz "float j is : "

	.section ".text"
	.align 4

! indodesID : j
	set	72, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0

	call	printFloat
	nop
	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	print2, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
print2:	.asciz "bool k is : "

	.section ".text"
	.align 4

! indodesID : k
	set	76, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0

	cmp	%l0, 0
	be	setFalse0
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done0
	nop
setFalse0:
	set	_boolF, %o0
	call	printf
	nop
done0:
	set	_endl, %o0
	call	printf
	nop

	ret
	restore

! from DoFuncDecl2
	SAVE.print = -92 & -8
	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp


! making function call :print
! moving all the arguments into %o registers
	set	1, %l0
! 0th argument of this function
	mov	%l0, %o0
	.section ".data"
	.align 4
MakingFuncCall_f_return_1:	.single 0r2.0
	.section ".text"
	.align 4
	set	MakingFuncCall_f_return_1, %l0
	ld	[%l0], %f0
	ld	[%l0], %l0
! 1th argument of this function
	mov	%l0, %o1
	set	1, %l0
! 2th argument of this function
	mov	%l0, %o2
	call	print
	nop
! Store return to a local tmp
	st	%o0, [%fp-4]

	ret
	restore

! from DoFuncDecl2
	SAVE.main = -(92 + 4) & -8
