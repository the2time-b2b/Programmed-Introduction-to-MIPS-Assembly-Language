## Total restaurant bill calculator
##
## Register Use:
##
## $s0 tip+tax 
## $s1 tip rate
## $s2 tax rate
## $s3 meal cost
## $a0 tax+tip dollars

        .globl  main

        # Get meal cost
main:   li      $v0,4       # print a prompt (code 4 put in $v0)
        la      $a0,prompt  # address of prompt put in $a0
        syscall

        li      $v0,5       # input an integer  (code 5 put in $v0)
        syscall             # 32-bit result returned in $v0
        move    $s0,$v0     # save it in $s3 
        
        # Calculations
        lw      $s1, tip    # get tip rate
        lw      $s2, tax    # get tax rate

        nop

        addu    $s3,$s1,$s2 # total rate in percent

        mul     $s4,$s0,$s3 # mealcost*(total rate)
        div     $s4,$s4,100 # mealcost*(total rate)/100

        addu    $s5,$s0,$s4 # total bill

        # Output
        li      $v0,4       # print string
        la      $a0,head1   # "tax plus tip"
        syscall

        move    $a0,$s4     # get tax+tip
        li      $v0,1       # print integer
        syscall

        li      $v0,4       # print string
        la      $a0,head2   # "total cost"
        syscall

        move    $a0,$s5     # get total
        li      $v0,1       # print integer
        syscall

        li      $v0,10      # exit
        syscall

        .data
tip:    .word   15          # tip rate in percent
tax:    .word    8          # tax rate in percent

prompt: .asciiz "Enter food cost: "
head1 : .asciiz "   Tax plus tip: "
head2 : .asciiz "     Total cost: "

