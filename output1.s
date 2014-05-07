/*
 * Generated Wed Apr 30 22:34:32 PDT 2014
 */

	.global	a, b, c
	.section ".bss"
	.align 4
a:	.skip 4
	.section ".bss"
	.align 4
b:	.skip 4
	.section ".bss"
	.align 4
c:	.skip 4

	.section ".data"
	.global main
	.align 4
main:	
	save %sp, -96, %sp
	ret 
	restore
