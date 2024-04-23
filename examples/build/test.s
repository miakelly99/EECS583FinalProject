	.text
	.file	"test.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movb	x(%rip), %al
	testb	%al, %al
	je	.LBB0_2
	jmp	.LBB0_1
.LBB0_1:
	movb	x, %al
	movzbl	%al, %esi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf@PLT
.LBB0_2:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	x,@object                       # @x
	.data
	.globl	x
	.p2align	2
x:
	.byte	1                               # 0x1
	.size	x, 1

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
