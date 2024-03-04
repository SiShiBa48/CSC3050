	.file	"array.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	printBitmap
	.type	printBitmap, @function
printBitmap:

	#start your code
	addi sp,sp,-4
	sw ra,0(sp)
	la t5,bitmap
	li t1,0 	#i
	j loopi
	
loopi:
	li t0,16
	beq t1,t0,grend
	li t2,0 	#j
	j loopj
loopj:
	li t0,8
	beq t2,t0,updatei
	li t3,7 	#k
	j loopk
	
loopk:
	li t0,-1
	beq t3,t0,updatej
	slli t4,t1,3
	add t4,t4,t2
	
	add t4,t4,t5
	lb t6,0(t4)
	sra t6,t6,t3
	
	and t6,t6,1
	beqz t6,callblank
	li t0,1
	beq t6,t0,callone
	
updatei:
	addi t1,t1,1
	j callre
updatej:
	addi t2,t2,1
	j loopj
	
updatek:
	addi t3,t3,-1
	j loopk
	
callblank:
	addi sp,sp,-28
	sw t1,24(sp)
	sw t2,20(sp)
	sw t3,16(sp)
	sw t4,12(sp)
	sw t5,8(sp)
	sw t6,4(sp)
	sw ra,0(sp)
	li a0,32
	call putchar
	lw ra,0(sp)
	lw t1,24(sp)
	lw t2,20(sp)
	lw t3,16(sp)
	lw t4,12(sp)
	lw t5,8(sp)
	lw t6,4(sp)
	addi sp,sp,28
	j updatek
	
		
callone:
	addi sp,sp,-28
	sw t1,24(sp)
	sw t2,20(sp)
	sw t3,16(sp)
	sw t4,12(sp)
	sw t5,8(sp)
	sw t6,4(sp)
	sw ra,0(sp)
	li a0,49
	call putchar
	lw ra,0(sp)
	lw t1,24(sp)
	lw t2,20(sp)
	lw t3,16(sp)
	lw t4,12(sp)
	lw t5,8(sp)
	lw t6,4(sp)
	addi sp,sp,28
	j updatek
	
callre:
	addi sp,sp,-28
	sw t1,24(sp)
	sw t2,20(sp)
	sw t3,16(sp)
	sw t4,12(sp)
	sw t5,8(sp)
	sw t6,4(sp)
	sw ra,0(sp)
	li a0,10
	call putchar
	lw t1,24(sp)
	lw t2,20(sp)
	lw t3,16(sp)
	lw t4,12(sp)
	lw t5,8(sp)
	lw t6,4(sp)
	lw ra,0(sp)
	addi sp,sp,28
	j loopi
	
grend:
	lw ra,0(sp)
	addi sp,sp,4
	ret
	
	.size	printBitmap, .-printBitmap
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	li	a0,16
	sw	ra,12(sp)
	call	printBitmap
	lw	ra,12(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	bitmap, @object
	.size	bitmap, 128
bitmap:
	.string	"\020"
	.string	"\020"
	.string	"\020@"
	.ascii	" "
	.string	"\b\004\020"
	.string	"\020@"
	.ascii	"\360"
	.string	"\177x\037\374\020@\037"
	.string	""
	.string	"@ \200\023\370\020"
	.string	"\"@ \200\030H\021"
	.string	"\024@@\200TH!"
	.string	"\377~\037\370PH!"
	.ascii	"\bH\020\200PH?\374"
	.string	"\bH\020\200\227\376\001"
	.ascii	"\177H\020\200\020@\t "
	.ascii	"\bH\377\376\020\240\t\020"
	.string	"*H"
	.ascii	"\200\020\240\021\b"
	.string	"IH"
	.ascii	"\200\021\020!\004"
	.string	"\210\210"
	.ascii	"\200\021\020A\004"
	.string	"(\210"
	.string	"\200\022\b\005"
	.string	"\021\b"
	.string	"\200\024\006\002"
	.ident	"GCC: (SiFive GCC 10.1.0-2020.08.2) 10.1.0"
