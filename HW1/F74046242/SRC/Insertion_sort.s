.data
Array: .word 9, 2, 8, 1, 6, 5, 4, 10, 3, 7 # you can change the element of array

.text
main:
	addi $t0, $zero, 4097      # $t0 = 0x00001001
	sll  $t0, $t0, 16          # set the base address of your array into $t0 = 0x10010000    
	nop
	addi $s0, $zero, 10        # set $s0 for the loop(array.length())
	addi $t1, $zero, 1         # set $t1(i) = 1
	addi $s1, $zero, -1        # $s1 = -1
Iloop:
	beq $t1, $s0, Exit         # if $t1 = 10, jump out of Iloop
	sll $t2, $t1, 2            # $t2 = $t1 * 4
	add $t2, $t2, $t0
	lw  $t2, 0($t2)            # $t2(temp) = Array[$t1]
	add $t7, $zero, $t1        # $t7 = $t1
Jloop:
	addi $t3, $t7, -1            # $t3 = $t7 - 1 (j = i - 1)
	sll  $t4, $t3, 2
	add  $t4, $t4, $t0
	add  $t8, $zero, $t4
	lw   $t4, 0($t4)             # $t4 = Array[$t3]
	slt  $t5, $t2, $t4           # $t5 = ($t2<$t4)?1:0
	slt  $t6, $s1, $t3           # $t6 = ($s1 < $t3)?1:0
	and  $t6, $t6, $t5           # $t6 = $t5 & $t6
	beq  $t6, $zero, Jloop_out   # jump out of Jloop if not conform to conditions
	sw   $t4, 4($t8)             # Array[$t3+1] = Array[$t3]
	addi $t7, $t7, -1            # $t7 = $t7 - 1 (j = j - 1)
	j Jloop
Jloop_out:
	sw   $t2, 4($t8)           # Array[$t3+1] = $t2(temp)
	addi $t1, $t1, 1           # $t1 = $t1 + 1
	j Iloop
Exit:
	li   $v0, 10               # program stop
	syscall
