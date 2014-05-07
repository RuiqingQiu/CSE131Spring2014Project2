/*
 * Generated Tue May 06 20:42:56 PDT 2014
 */

	.section ".rodata"
_endl:		.asciz "\n"
_intFmt:	.asciz "%d"
_strFmt:	.asciz "%s"
_boolT:		.asciz "true"
_boolF:		.asciz "false"

	.section ".bss"
	.global	a
	.align 4
a:	.skip 4

	.section ".bss"
	.global	b
	.align 4
b:	.skip 4

	.section ".bss"
	.global	c
	.align 4
c:	.skip 4

	.section ".bss"
	.global	b1
	.align 4
b1:	.skip 4

	.section ".bss"
	.global	b2
	.align 4
b2:	.skip 4

	.section ".bss"
	.global	f1
	.align 4
f1:	.skip 4

	.section ".bss"
	.global	f2
	.align 4
f2:	.skip 4

	.section ".bss"
	.global	f3
	.align 4
f3:	.skip 4

	.section ".bss"
	.align 4
si1:	.skip 4

	.section ".bss"
	.align 4
sf1:	.skip 4

	.section ".bss"
	.align 4
sb1:	.skip 4

	.section ".data"
	.align 4
si2:	.word 1

	.section ".data"
	.align 4
sf2:	.single 0r1.11

	.section ".data"
	.align 4
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

	.section ".data"
	.global	i1
	.align 4
i1:	.word 1

	.section ".data"
	.global	b3
	.align 4
b3:	.word 1

	.section ".data"
	.global	f4
	.align 4
f4:	.single 0r1.0

	.section ".text"
	.align 4
	.global main
main:
	set	SAVE.main, %g1
	save	%sp, %g1, %sp
! local variable without init, just add offset
! Const local
	set	1, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Const local
	set	1, %l1
	set	-12, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	.section ".data"
	.align 4
main_f_2:	.single 0r0.11
	.section ".text"
	.align 4
! Const local
	set	main_f_2, %l1
	set	-16, %l0
	add	%fp, %l0, %l0
	ld	[%l1], %l1
	st	%l1, [%l0]

! local variable without init, just add offset
	set	1, %l1
	set	-24, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	2, %l1
	set	-28, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	1, %l1
	set	-32, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	0, %l1
	set	-36, %l0
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

	set	_strFmt, %o0
	set	main5, %o1
	call	printf
	nop

	set	_endl, %o0
	call	printf
	nop

	.section ".data"
	.align 4
main_f_2:	.single 0r1.1
	.section ".text"
	.align 4
	set	main_f_2, %l1
	set	-40, %l0
	add	%fp, %l0, %l0
	ld	[%l1], %l1
	st	%l1, [%l0]

	ret
	restore
! from DoFuncDecl2
	SAVE.main = (-92 + 40) & -8
	.section ".rodata"
main0:	.asciz "hello"
main1:	.asciz "hi"
main2:	.asciz "1"
main3:	.asciz "true"
main4:	.asciz "1.1"
main5:	.asciz "2.2"

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

