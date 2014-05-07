/*
 * Generated Wed May 07 14:02:13 PDT 2014
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

	.section ".data"
	.global	c
	.align 4
c:	.word 10

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
! local variable:   a    without init, just add offset
! init variable: c
	set	100, %l1
	set	-8, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Const local
	set	200, %l1
	set	-12, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! Const local
	set	1, %l1
	set	-16, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	.section ".data"
	.align 4
main_f_c_2:	.single 0r0.11
	.section ".text"
	.align 4
! Const local
	set	main_f_c_2, %l1
	set	-20, %l0
	add	%fp, %l0, %l0
	ld	[%l1], %l1
	st	%l1, [%l0]

! local variable:   local1    without init, just add offset
! init variable: local2
	set	1, %l1
	set	-28, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! init variable: local3
	set	2, %l1
	set	-32, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! init variable: local6
	set	c, %l0
	add	%g0, %l0, %l0
	ld	[%l0], %l1
	set	-36, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
! init variable: local7
	set	-8, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l1
	set	-40, %l0
	add	%fp,%l0, %l0
	st	%l1, [%l0]

! init variable: local4
	set	1, %l1
	set	-44, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! init variable: local5
	set	0, %l1
	set	-48, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	_strFmt, %o0
	set	main0, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main0:	.asciz "hello"

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
main1:	.asciz "hi"

	.section ".text"
	.align 4
	set	_endl, %o0
	call	printf
	nop

	set	1, %l0
	set	_intFmt, %o0
	mov	%l0, %o1
	call	printf
	nop
	set	_endl, %o0
	call	printf
	nop

	set	-4, %l0
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
	set	main1, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
main1:	.asciz "true"

	.section ".text"
	.align 4
	set	_endl, %o0
	call	printf
	nop

	.section ".data"
	.align 4
const_f_0:	.single 0r1.1
	.section ".text"
	.align 4
	set	const_f_0, %l0
	ld	[%l0], %f0
	call	printFloat
	nop
	set	_endl, %o0
	call	printf
	nop

	.section ".data"
	.align 4
const_f_1:	.single 0r2.2
	.section ".text"
	.align 4
	set	const_f_1, %l0
	ld	[%l0], %f0
	call	printFloat
	nop
	set	_endl, %o0
	call	printf
	nop

	.section ".data"
	.align 4
main_f_2:	.single 0r1.1
	.section ".text"
	.align 4
! init variable: localfloat
	set	main_f_2, %l1
	set	-52, %l0
	add	%fp, %l0, %l0
	ld	[%l1], %l1
	st	%l1, [%l0]

! init variable: localbool
	set	1, %l1
	set	-56, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

! init variable: localbool2
	set	0, %l1
	set	-60, %l0
	add	%fp, %l0, %l0
	st	%l1, [%l0]

	set	-56, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, 0
	be	setFalse2
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done2
	nop
setFlase2:
	set	_boolF, %o0
	call	printf
	nop
done2:
	set	_endl, %o0
	call	printf
	nop

	set	-60, %l0
	add	%fp, %l0, %l0
	ld	[%l0], %l0
	cmp	%l0, 0
	be	setFalse3
	nop
	set	_boolT, %o0
	call	printf
	nop
	ba	done3
	nop
setFlase3:
	set	_boolF, %o0
	call	printf
	nop
done3:
	set	_endl, %o0
	call	printf
	nop

	ret
	restore
! from DoFuncDecl2
	SAVE.main = -(92 + 60) & -8
	.section ".text"
	.align 4
	.global foo
foo:
	set	SAVE.foo, %g1
	save	%sp, %g1, %sp
	set	_strFmt, %o0
	set	foo2, %o1
	call	printf
	nop

	.section ".rodata"
	.align 4
foo2:	.asciz "hello1"

	.section ".text"
	.align 4
	set	_endl, %o0
	call	printf
	nop

	ret
	restore
! from DoFuncDecl2
	SAVE.foo = -92 & -8
