addi $s0, $zero, 666 
# num1 = 666

addi $s1, $zero, 777 
# num2 = 777

addi $s0, $s0, 111
# num1 = num1 + 111

subi $s1, $s1, 111
# num2 = num2 - 111

sub $t0, $s2, $s1
# t0 = s2 - s1

srl $t0, $t0, 31
# $t0 = $t0 >> 31

addi $t1, $zero, 1
# $t1 = 1

beq $t0, $t1, 2
# if ($t0 == $t1 == 1) , jump

addi $s2 $zero, 555
# s2 = 555 (no jump)

beq $t0,$t0,1

addi $s2 $zero, 888
# s2 = 888 (jump)


addi $t0, $zero, 0
sw $s0, 0, $t0
sw $s1, 4, $t0
sw $s2, 8, $t0
# 寫入資料到memory