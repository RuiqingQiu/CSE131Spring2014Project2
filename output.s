/*
 * Generated Wed May 07 17:37:20 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".bss"
	.global	bool1
	.align 4
bool1:	.skip 4

	.global	bool2
	.align 4
	.section ".data"
bool2:	.word 1

	.align 4
	.section ".data"
bool3:	.word 0

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
	set	bool1, %l0
	add	%g0, %l0, %l0
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

	set	_strFmt, %o0
	set	main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main0:	.asciz "true"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main1:	.asciz "false"

	.section ".text"
	.align 4

	set	_endl, %o0
	call	printf
	nop

	ret
	restore
! from DoFuncDecl2
	SAVE.main = -92 & -8
