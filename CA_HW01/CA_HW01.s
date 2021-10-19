.data
cost: .word 10, 15, 20
costSize: .word 3
str: .string "Min Cost is  "
.text
# t0: cost
# t1: costSize
# t2: constant, then be prev2
# t3: prev1
# t4: temp
# t5: i
# t6: *t0
main:
    addi sp, sp, -4
    sw   ra, (0)sp         # save return address
    la   a0, cost          # load array cost
    la   a1, costSize      # load integer costSize
    jal  ra, minCost       # call function
    jal  ra, printf        # printf
    
    addi sp, sp, 4
    li   a7, 10            # end call
    ecall

minCost:
    addi sp, sp, -12
    sw   ra, (0)sp
    sw   a0, (4)sp
    sw   a1, (8)sp
    lw   t0, (4)sp
    lw   t1, (8)sp
    lw   t1, (0)t1
    beq  t1, x0, con0      # if costSize==0, return 0
    addi t2, x0, 1
    beq  t1, t2, con1      # if costSize==1, return *cost
    addi t2, x0, 1
    beq  t1, t2, con2      # if costSize==2, return...
    
    lw   t2, (0)t0         # t2 = prev2
    lw   t3, (4)t0         # t3 = prev1
    addi  t5, x0, 2        # i=2
    addi  t0, t0, 4        # t0[1]
Loop:
    beq  t5, t1, Done      # if t1==t5, break the loop
    addi  t0, t0, 4        # t0 = t0 + 1 ,this is address
    lw    t6, (0)t0        # t6 = *t0    ,this is value
    add   t4, x0, x0
    bge   t3, t2, loopcon
    add   t4, t6, t3
then:
    add t2, x0, t3
    add t3, x0, t4
    addi t5, t5, 1
    j Loop
Done:
    bge t3, t2, Dcon
    add a0, t3, x0
    j return
 
return:
    lw ra, 0(sp)
    addi sp, sp, 12
    jr ra

con0:                      # return 0
    add a0, x0, a0
    j return

con1:                      # return *(cost)
    lw a0, (0)t0
    j return    

con2:                      # return min(*cost, *(cost+1))
    lw t2, (0)t1
    lw t3, (4)t1
    bge t2, t3, subcon2    # if t2>t3 return t3
    add a0, t2, x0
    j return

subcon2:
    add a0, t3, x0
    j return

loopcon:
    add t4, t6, t2
    j then

Dcon:
    add a0, t2, x0
    j return

printf:
    addi sp, sp, -8
    sw   ra, 0(sp)
    sw   a0, 4(sp)
    la   a0, str
    li   a7, 4
    ecall
    lw   a0, 4(sp)
    li   a7, 1
    ecall
    lw   ra, 0(sp)
    addi sp, sp, 8
    jr ra