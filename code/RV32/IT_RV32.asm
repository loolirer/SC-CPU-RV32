addi  t0, x0, 0x000000ab
addi  t1, x0, 0x000000cd
addi  t5, x0, 2
add   t2, t0, t1
sub   t3, x0, t2
slt   t4, t3, t2
and   t1, t2, t3
or    t2, t3, t1
xor   t0, t1, t4
sll   t2, t1, t5
srl   t3, t2, t5
andi  t2, t1, 0x000000ef
ori   t3, t2, 0x000000fe
xori  t3, t3, 0x000000dc
lui   t4,     0x000abcde
slli  t1, t2, 2
srli  t2, t4, 2
add   t3, t1, t2
sw    t3, 0(t1)
lw    t0, 0(t1)
beq   x0, x0, label
add   t0, x0, x0
label:

# Display do resultado no LCD
addi  x30, t0, 0