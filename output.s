/*
 * Generated Tue May 06 19:08:39 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.global	a
	.align 4
	.section ".bss"
a:	.skip 4

	.global	b
	.align 4
	.section ".bss"
b:	.skip 4

	.global	c
	.align 4
	.section ".bss"
c:	.skip 4

	.global	b1
	.align 4
	.section ".bss"
b1:	.skip 4

	.global	b2
	.align 4
	.section ".bss"
b2:	.skip 4

	.global	f1
	.align 4
	.section ".bss"
f1:	.skip 4

	.global	f2
	.align 4
	.section ".bss"
f2:	.skip 4

	.global	f3
	.align 4
	.section ".bss"
f3:	.skip 4

	.align 4
	.section ".bss"
si1:	.skip 4

	.align 4
	.section ".bss"
sf1:	.skip 4

	.align 4
	.section ".bss"
sb1:	.skip 4

	.align 4
	.section ".data"
si2:	.word 1

	.align 4
	.section ".data"
sf2:	.single 0r1.11

	.align 4
	.section ".data"
sb2:	.word 1

	.global	ci1
	.align 4
	.section ".data"
ci1:	.word 10

	.global	cf1
	.align 4
	.section ".data"
cf1:	.single 0r10.01

	.global	cb1
	.align 4
	.section ".data"
cb1:	.word 1

	.global	i1
	.align 4
	.section ".data"
i1:	.word 1

	.global	b3
	.align 4
	.section ".data"
b3:	.word 1

	.global	f4
	.align 4
	.section ".data"
f4:	.single 0r1.0

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable without init, just add offset
	set	1, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	2, %l1
	set	-12, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	1, %l1
	set	-16, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	0, %l1
	set	-20, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	_strFmt, %o0
	set	main0, %o1
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	main1, %o1
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	main2, %o1
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	main3, %o1
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	set	_strFmt, %o0
	set	main4, %o1
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	ret
	restore
! from DoFuncDecl2
	SAVE.main = (-92 + 20) & -8
	.section ".rodata"
main0:	.asciz "hello"
main1:	.asciz "hi"
main2:	.asciz "1"
main3:	.asciz "true"
main4:	.asciz "1.1"

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

	set	_endl, %o0
	call	printf
	nop

	ret
	restore
! from DoFuncDecl2
	SAVE.foo = -92 & -8
	.section ".rodata"
foo0:	.asciz "hello1"

