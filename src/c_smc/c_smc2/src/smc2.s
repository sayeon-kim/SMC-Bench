	.text
	.file	"smc2.c"
	.globl	main                    # -- Begin function main
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
	subq	$80, %rsp
	movabsq	$foo, %rax
	movl	$0, -4(%rbp)
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rdi
	callq	change_page_permissions_of_address
	cmpl	$-1, %eax
	jne	.LBB0_2
# %bb.1:
	movq	stderr, %rdi
	movq	%rdi, -56(%rbp)         # 8-byte Spill
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movabsq	$.L.str, %rsi
	movq	-56(%rbp), %rdi         # 8-byte Reload
	movq	%rax, %rdx
	movb	$0, %al
	callq	fprintf
	movl	$1, -4(%rbp)
	movl	%eax, -60(%rbp)         # 4-byte Spill
	jmp	.LBB0_3
.LBB0_2:
	movabsq	$.L.str.1, %rdi
	callq	puts
	movl	%eax, -64(%rbp)         # 4-byte Spill
	callq	foo
	movabsq	$.L.str.1, %rdi
	movq	.Lmain.shellcode, %rcx
	movq	%rcx, -48(%rbp)
	movq	.Lmain.shellcode+8, %rcx
	movq	%rcx, -40(%rbp)
	movq	.Lmain.shellcode+16, %rcx
	movq	%rcx, -32(%rbp)
	movl	.Lmain.shellcode+24, %eax
	movl	%eax, -24(%rbp)
	movw	.Lmain.shellcode+28, %dx
	movw	%dx, -20(%rbp)
	movq	-16(%rbp), %rcx
	movq	-48(%rbp), %rsi
	movq	%rsi, (%rcx)
	movq	-40(%rbp), %rsi
	movq	%rsi, 8(%rcx)
	movq	-32(%rbp), %rsi
	movq	%rsi, 16(%rcx)
	movl	-24(%rbp), %eax
	movl	%eax, 24(%rcx)
	movb	-20(%rbp), %r8b
	movb	%r8b, 28(%rcx)
	callq	puts
	movl	%eax, -68(%rbp)         # 4-byte Spill
	callq	foo
	movl	$0, -4(%rbp)
.LBB0_3:
	movl	-4(%rbp), %eax
	addq	$80, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movabsq	$.L.str.2, %rdi
	movl	$0, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %esi
	movb	$0, %al
	callq	printf
	movl	%eax, -8(%rbp)          # 4-byte Spill
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end1:
	.size	foo, .Lfunc_end1-foo
	.cfi_endproc
                                        # -- End function
	.globl	change_page_permissions_of_address # -- Begin function change_page_permissions_of_address
	.p2align	4, 0x90
	.type	change_page_permissions_of_address,@function
change_page_permissions_of_address:     # @change_page_permissions_of_address
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	callq	getpagesize
	movl	$7, %edx
	xorl	%ecx, %ecx
	movl	%ecx, %edi
	movl	%eax, -20(%rbp)
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rsi
	xorl	%ecx, %ecx
	movl	%edx, -24(%rbp)         # 4-byte Spill
	movl	%ecx, %edx
	divq	%rsi
	movq	-16(%rbp), %rsi
	subq	%rdx, %rdi
	addq	%rdi, %rsi
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdi
	movslq	-20(%rbp), %rsi
	movl	-24(%rbp), %edx         # 4-byte Reload
	callq	mprotect
	cmpl	$-1, %eax
	jne	.LBB2_2
# %bb.1:
	movl	$-1, -4(%rbp)
	jmp	.LBB2_3
.LBB2_2:
	movl	$0, -4(%rbp)
.LBB2_3:
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end2:
	.size	change_page_permissions_of_address, .Lfunc_end2-change_page_permissions_of_address
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Error while changing page permissions of foo(): %s\n"
	.size	.L.str, 52

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"Calling foo"
	.size	.L.str.1, 12

	.type	.Lmain.shellcode,@object # @main.shellcode
	.section	.rodata,"a",@progbits
	.p2align	4
.Lmain.shellcode:
	.asciz	"H1\322H1\300H\273/bin/sh\000SH\211\347PWH\211\346\260;\017\005"
	.size	.Lmain.shellcode, 30

	.type	.L.str.2,@object        # @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"i: %d\n"
	.size	.L.str.2, 7


	.ident	"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"
	.section	".note.GNU-stack","",@progbits
