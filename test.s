	.file	"test.c"
	.section	".text"
	.align 4
	.global _Z3foov
	.type	_Z3foov, #function
	.proc	04
_Z3foov:
.LLFB7:
	save	%sp, -96, %sp
.LLCFI0:
	mov	1, %g1
	mov	%g1, %i0
	return	%i7+8
	 nop
.LLFE7:
	.size	_Z3foov, .-_Z3foov
	.align 4
	.global _Z3fooiiid
	.type	_Z3fooiiid, #function
	.proc	04
_Z3fooiiid:
.LLFB8:
	save	%sp, -104, %sp
.LLCFI1:
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp-8]
	st	%i4, [%fp-4]
	ld	[%fp+68], %g1
	mov	%g1, %i0
	return	%i7+8
	 nop
.LLFE8:
	.size	_Z3fooiiid, .-_Z3fooiiid
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
.LLFB9:
	save	%sp, -96, %sp
.LLCFI2:
	mov	0, %g1
	mov	%g1, %i0
	return	%i7+8
	 nop
.LLFE9:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.7.1"
