.data

  #strings to be printed during calculator use
  welcome: .asciiz "Welcome to the 32 bit integer Calculator!\n"
  closing: .asciiz "Exiting the Calculator. Thank you!\n"
  oops: .asciiz "Input not recognized, please try again.\n"
  negativeError: .asciiz "Negative exponents are not allowed, please try again.\n"
  negativeFactStr: .asciiz "Negative factorial is undefined, please enter a positive integer.\n"
  enterX: .asciiz "Enter a value for x:\n"
  enterY: .asciiz "Enter a value for y:\n"
  addStr: .asciiz "The chosen operation is x + y\n"
  subStr: .asciiz "The chosen operation is x - y\n"
  multStr: .asciiz "The chosen operation is x * y\n"
  divStr: .asciiz "The chosen operation is x / y\n"
  modStr: .asciiz "The chosen operation is x % y\n"
  sqrStr: .asciiz "The chosen operation is x ^ 2\n"
  powStr: .asciiz "The chosen operation is x ^ y\n"
  factStr: .asciiz "The chosen operation is x!\n"
  remainderStr: .asciiz " with a remainder of "
  newLine: .asciiz "\n\n"

  #operator characters to be printed
  addOp: .asciiz " + "
  subOp: .asciiz " - "
  multOp: .asciiz " * "
  divOp: .asciiz " / "
  modOp: .asciiz " % "
  powOp: .asciiz " ^ "
  factOp: .asciiz "!"
  equalOp: .asciiz " = "

  #variables for storing values across system calls
  varHi: .word 0
  varLo: .word 0

  #Menu options to be printed
  select: .asciiz "Enter the number of the operation to be performed\n"
  list: .asciiz "(1) x + y\n(2) x - y\n(3) x * y\n(4) x / y\n(5) x % y\n(6) x ^ 2\n(7) x ^ y\n(8) x!\n(0) EXIT\n"

  .globl main

.text
  main:

  li $v0 4 #system call for print string
  la $a0 welcome #loads memory address for welcome into $a0
  syscall #prints welcome

  j Menu #jump to main menu

  Menu: #main menu where user selects operation to be performed
        li $v0 4 #system call for print string
        la $a0 select #loads memory address for welcome into $a0
        syscall #prints select

        li $v0 4 #system call for print string
        la $a0 list #loads memory address for list into $a0
        syscall #prints list

        li $v0 5 #system call forint input
        syscall

        #save integers for branching comparisons on user input
        addi $t1 $zero 1
        addi $t2 $zero 2
        addi $t3 $zero 3
        addi $t4 $zero 4
        addi $t5 $zero 5
        addi $t6 $zero 6
        addi $t7 $zero 7
        addi $t8 $zero 8

        #conditionals to branch to operation execution
        beq $v0 $zero Exit #input is 0, exit program
        beq $v0 $t1 Add #input is 1, branch to Add
        beq $v0 $t2 Subtract #input is 2, branch to Subtract
        beq $v0 $t3 Multiply #input is 3, branch to Multiply
        beq $v0 $t4 Divide #input is 4, branch to Divide
        beq $v0 $t5 Modulo #input is 5, branch to Modulo
        beq $v0 $t6 Square #input is 6, branch to Square
        beq $v0 $t7 Power #input is 7, branch to Power
        beq $v0 $t8 Factorial #input is 8, branch to Factorial

        #none of the above conditions are met, so input is invalid
        li $v0 4 #system call for print string
        la $a0 oops #loads memory address for oops into $a0
        syscall #prints oops

        j Menu # reload menu for user to make a selection

  Add: #user input is 1, branched to from main menu. Executes addition operation.
       li $v0 4 #system call for print string
       la $a0 addStr #loads memory address for addStr into $a0
       syscall #prints addStr

       li $v0 4 #system call for print string
       la $a0 enterX #loads memory address for enterX into $a0
       syscall #prints enterX

       li $v0 5 #system call for int input
       syscall
       move $t0 $v0 #moves user input for x to $t0

       li $v0 4 #system call for print string
       la $a0 enterY #loads memory address for enterY into $a0
       syscall #prints enterY

       li $v0 5 #system call for int input
       syscall
       move $t1 $v0 #moves user input for y to $t1

       add $t2 $t0 $t1 #result of x + y stored in $t2

       li $v0 1 #system call to print int
       add $a0 $t0 $zero #int value of x in $a0
       syscall

       li $v0 4 #system call for print string
       la $a0 addOp # memory address for + symbol
       syscall

       li $v0 1 #system call to print int
       add $a0 $t1 $zero #int value of y in $a0
       syscall

       li $v0 4 #system call for print string
       la $a0 equalOp # memory address for equal operator
       syscall

       li $v0 1 #system call to print int
       add $a0 $t2 $zero #int value of x + y in $a0
       syscall

       li $v0 4 #system call for print string
       la $a0 newLine # memory address for newLine character
       syscall

       j Menu # jump back to main menu

  Subtract: #user input is 2, branched to from main menu. Executes subtraction operation.
            li $v0 4 #system call for print string
            la $a0 subStr #loads memory address for subStr into $a0
            syscall #prints subStr

            li $v0 4 #system call for print string
            la $a0 enterX #loads memory address for enterX into $a0
            syscall #prints enterX

            li $v0 5 #system call for int input
            syscall
            move $t0 $v0 #moves user input for x to $t0

            li $v0 4 #system call for print string
            la $a0 enterY #loads memory address for enterY into $a0
            syscall #prints enterY

            li $v0 5 #system call for int input
            syscall
            move $t1 $v0 #moves user input for y to $t1

            sub $t2 $t0 $t1 #result of x - y stored in $t2

            li $v0 1 #system call to print in
            add $a0 $t0 $zero #int value of x in $a0
            syscall

            li $v0 4 #system call for print string
            la $a0 subOp # memory address for - symbol
            syscall

            li $v0 1 #system call to print in
            add $a0 $t1 $zero #int value of y in $a0
            syscall

            li $v0 4 #system call for print string
            la $a0 equalOp # memory address for equal operator
            syscall

            li $v0 1 #system call to print in
            add $a0 $t2 $zero #int value of x - y in $a0
            syscall

            li $v0 4 #system call for print string
            la $a0 newLine # memory address for newLine character
            syscall

            j Menu # jump back to main menu

  Multiply: #user input is 3, branched to from main menu. Executes multiply operation.
            li $v0 4 #system call for print string
            la $a0 multStr #loads memory address for multStr into $a0
            syscall #prints multStr

            li $v0 4 #system call for print string
            la $a0 enterX #loads memory address for enterX into $a0
            syscall #prints enterX

            li $v0 5 #system call for int input
            syscall
            move $t0 $v0 #moves user input for x to $t0

            li $v0 4 #system call for print string
            la $a0 enterY #loads memory address for enterY into $a0
            syscall #prints enterY

            li $v0 5 #system call for int input
            syscall
            move $t1 $v0 #moves user input for y to $t1

            mult $t0 $t1 #x * y is now stored in hi-lo

            li $v0 1 #system call to print in
            add $a0 $t0 $zero #int value of x in $a0
            syscall

            li $v0 4 #system call for print string
            la $a0 multOp # memory address for * symbol
            syscall

            li $v0 1 #system call to print in
            add $a0 $t1 $zero #int value of y in $a0
            syscall

            li $v0 4 #system call for print string
            la $a0 equalOp # memory address for equal operator
            syscall

            mflo $t3 #lower 32 bits of product in $t3

            li $v0 1 #system call to print int
            add $a0 $t3 $zero #int value of x * y in $a0
            syscall

            li $v0 4 #system call for print string
            la $a0 newLine # memory address for newLine character
            syscall

            j Menu # jump back to main menu

  Divide: #user input is 4, branched to from main menu. Executes division operation.

          li $v0 4 #system call for print string
          la $a0 divStr #loads memory address for divStr into $a0
          syscall #prints divStr

          li $v0 4 #system call for print string
          la $a0 enterX #loads memory address for enterX into $a0
          syscall #prints enterX

          li $v0 5 #system call for int input
          syscall
          move $t0 $v0 #moves user input for x to $t0

          li $v0 4 #system call for print string
          la $a0 enterY #loads memory address for enterY into $a0
          syscall #prints enterY

          li $v0 5 #system call for int input
          syscall
          move $t1 $v0 #moves user input for y to $t1

          div $t0 $t1 #x / y, quotient in lo, remainder in hi

          li $v0 1 #system call to print int
          add $a0 $t0 $zero #int value of x in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 divOp # memory address for / symbol
          syscall

          li $v0 1 #system call to print in
          add $a0 $t1 $zero #int value of y in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 equalOp # memory address for equal operator
          syscall

          mfhi $t2 #remainder in $t2
          mflo $t3 #quotient in $t3

          #if hi is 0, there is no remainder. if hi is non-0, then there is a
          #remainder and should be printed.

          la $t6 varHi #load memory address of temp variable to store hi result
          la $t7 varLo #load memory address of temp variable to store lo result

          sw $t2 0($t6) #store value of hi (remainder) in varHi
          sw $t3 0($t7) #store value of lo (quotient) in varLo

          bne $t2 $zero DivWithRemainder #branch to DivWithRemainder if hi is non-0
          j DivNoRemainder #branch to DivNoRemainder if hi is 0

  DivNoRemainder: #Branch here if the remainder is 0 after division
                  #we know the value in hi is 0, so we only display lo in result

                  la $t0 varLo #load memory address of varLo into $t0
                  lw $t1 0($t0) #load stored value of lo (quotient) into $t1

                  li $v0 1 #system call to print int
                  add $a0 $t1 $zero #int value of quotient x / y in $a0 (from lo stored in memory)
                  syscall

                  li $v0 4 #system call for print string
                  la $a0 newLine # memory address for newLine character
                  syscall

                  j Menu # jump back to main menu

  DivWithRemainder: #Branch here if there is a non-0 remainder

                    la $t2 varLo #load memory address of varLo into $t2
                    la $t3 varHi #load memory address of varHi into $t3
                    lw $t0 0($t2) #load stored value of lo (quotient) into $t0
                    lw $t1 0($t3) #load stored value of hi (remainder) into $t1

                    li $v0 1 #system call to print int
                    add $a0 $t0 $zero #int value of quotient from x / y in $a0 (from lo stored in memory)
                    syscall

                    li $v0 4 #system call for print string
                    la $a0 remainderStr # memory address for remainderStr character
                    syscall

                    li $v0 1 #system call to print int
                    add $a0 $t1 $zero #int value of remainder from x / y in $a0 (from hi stored in memory)
                    syscall

                    li $v0 4 #system call for print string
                    la $a0 newLine # memory address for newLine character
                    syscall

                    j Menu # jump back to main menu

  Modulo: #user input is 5, branch here from menu. Executes modulo operation

          li $v0 4 #system call for print string
          la $a0 modStr #loads memory address for modStr into $a0
          syscall #prints modStr

          li $v0 4 #system call for print string
          la $a0 enterX #loads memory address for enterX into $a0
          syscall #prints enterX

          li $v0 5 #system call for int input
          syscall
          move $t0 $v0 #moves user input for x to $t0

          li $v0 4 #system call for print string
          la $a0 enterY #loads memory address for enterY into $a0
          syscall #prints enterY

          li $v0 5 #system call for int input
          syscall
          move $t1 $v0 #moves user input for y to $t1

          div $t0 $t1 #x / y, quotient in lo, remainder in hi

          li $v0 1 #system call to print int
          add $a0 $t0 $zero #int value of x in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 modOp # memory address for % symbol
          syscall

          li $v0 1 #system call to print int
          add $a0 $t1 $zero #int value of y in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 equalOp # memory address for equal operator
          syscall

          mfhi $t2 #remainder of x / y in $t2

          #modulo calculates the remainder of a quotient, therefore we only
          #need the value in hi to display the result

          li $v0 1 #system call to print int
          add $a0 $t2 $zero #int value of x % y (from hi register) in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 newLine # memory address for newLine character
          syscall

          j Menu # jump back to main menu

  Square: #user input is 6, branch here from menu. Executes square operation.

          li $v0 4 #system call for print string
          la $a0 sqrStr #loads memory address for sqrStr into $a0
          syscall #prints sqrStr

          li $v0 4 #system call for print string
          la $a0 enterX #loads memory address for enterX into $a0
          syscall #prints enterX

          li $v0 5 #system call for int input
          syscall
          move $t0 $v0 #moves user input for x to $t0

          mult $t0 $t0 # x ^ 2 is now stored in hi-lo

          li $v0 1 #system call to print int
          add $a0 $t0 $zero #int value of x in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 powOp # memory address for ^ symbol
          syscall

          li $v0 1 #system call to print int
          addi $a0 $zero 2 #int value of 2 in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 equalOp # memory address for equal operator
          syscall

          mflo $t3 #lower 32 bits of product in $t3

          li $v0 1 #system call to print int
          add $a0 $t3 $zero #int value of x * y in $a0
          syscall

          li $v0 4 #system call for print string
          la $a0 newLine # memory address for newLine character
          syscall

          j Menu # jump back to main menu

  Power: #user input is 7, branch here from menu. Executes power operation.

         li $v0 4 #system call for print string
         la $a0 powStr #loads memory address for powStr into $a0
         syscall #prints powStr

         li $v0 4 #system call for print string
         la $a0 enterX #loads memory address for enterX into $a0
         syscall #prints enterX

         li $v0 5 #system call for int input
         syscall
         move $s0 $v0 #moves user input for x to $s0
         add $s2 $s0 $zero #moves user input for x to $s2 for use in PowerLoop

         li $v0 4 #system call for print string
         la $a0 enterY #loads memory address for enterY into $a0
         syscall #prints enterY

         li $v0 5 #system call for int input
         syscall
         move $s1 $v0 #moves user input for y to $s1

         # check for negative exponent, not allowed
         slt $t0 $s1 $zero #if $s1 < 0, $t0 = 1, else 0
         bne $t0 $zero NegativeExp #displays error message, then returns to top of Power

         li $v0 1 #system call to print int
         add $a0 $s0 $zero #int value of x in $a0
         syscall

         li $v0 4 #system call for print string
         la $a0 powOp # memory address for ^ symbol
         syscall

         li $v0 1 #system call to print int
         add $a0 $s1 $zero  #int value of y in $a0
         syscall

         li $v0 4 #system call for print string
         la $a0 equalOp # memory address for equal operator
         syscall

         #must handle case when exponent is 0
         bne $s1 $zero PowerLoop #non-0 exponent, branch to PowerLoop

         li $v0 1 #system call to print int
         addi $a0 $zero 1  #result of x ^ y always 1 if y = 0
         syscall

         li $v0 4 #system call for print string
         la $a0 newLine # memory address for newLine character
         syscall

         j Menu # jump back to menu

  PowerLoop: #helper function to calculate x ^ y

             mult $s0 $s2 # perform first multiplication of x * x

             mflo $s2 # place lower 32 bits of product back in $s2

             addi $s1 $s1 -1 #decrement value of y
             slti $t0 $s1 2 # $t0 = 1 if y < 2 , 0 otherwise

             beq $t0 $zero PowerLoop #loops again after decrement

             li $v0 1 #system call to print int
             add $a0 $s2 $zero  #result of x ^ y from #s2 to $a0
             syscall

             li $v0 4 #system call for print string
             la $a0 newLine # memory address for newLine character
             syscall

             j Menu # jump back to menu

  NegativeExp: #branch here from Power if user inputs negative exponent

               li $v0 4 #system call for print string
               la $a0 negativeError #loads memory address for negativeError into $a0
               syscall #prints negativeError

               j Power #jump to Power

  Factorial: #user input is 8, branch here from menu. Executes factorial operation.

             li $v0 4 #system call for print string
             la $a0 factStr #loads memory address for factStr into $a0
             syscall #prints factStr

             li $v0 4 #system call for print string
             la $a0 enterX #loads memory address for enterX into $a0
             syscall #prints enterX

             li $v0 5 #system call for int input
             syscall

             #check for invalid input, x < 0 not defined
             slti $t0 $v0 0 # $t0 = 1 if $v0 < 0, else $t0 = 0
             bne $t0 $zero NegativeFact #branch to NegativeFact if input is < 0

             move $s0 $v0 #temporarily store user input in $s0

             li $v0 1 #system call to print int
             add $a0 $s0 $zero #loads user input into $a0
             syscall

             li $v0 4 #system call for print string
             la $a0 factOp #loads memory address for factOp into $a0
             syscall #prints factOp

             li $v0 4 #system call for print string
             la $a0 equalOp #loads memory address for equalOp into $a0
             syscall #prints equalOp

             addi $s1 $zero 1 #load 1 to $s1 for the factorial base case
             add $a0 $s0 $zero #place user input into $a0

             jal Fact1 #jump and link to Fact1 helper function

             li $v0 1 #system call to print int
             add $a0 $v1 $zero #result in $v1 from linked procedure
             syscall

             li $v0 4 #system call for print string
             la $a0 newLine # memory address for newLine character
             syscall

             j Menu #jump back to menu

  Fact1: #helper function 1 for computing factorial, checks for base case

         addi $sp $sp -8 #adjust stack pointer for 2 items
         sw $a0 0($sp) #store current n for factorial calculation
         sw $ra 4($sp) #store return address from jump and link

         slti $t0 $a0 1 #sets $t0 to 1 when n < 1 is true
         beq $t0 $zero Fact2 # branch to recursion when n >= 1
         add $v1 $s1 $zero # adding storing result in $v1
         addi $sp $sp 8 # pop and restore the stack
         jr $ra # jumps to saved return address

  Fact2: #helper function 2 for computing factorial, recursive portion

         addi $a0 $a0 -1 # decrements n for factorial calculation
         jal Fact1 # jumps and links to calculate if base case not met

         lw $a0 0($sp) # load $a0 to calculate n * (n-1)
         lw $ra 4($sp) # load proper return address
         addi $sp $sp 8 # pop the stack
         mul $v1 $a0 $v1 # performs actual multiplication of n * (n-1)

         jr $ra # jumps to saved return address

  NegativeFact: #error message for negative operand input for factorial

                li $v0 4 #system call for print string
                la $a0 negativeFactStr #loads memory address for negativeFactStr into $a0
                syscall #prints negativeFactStr

                j Factorial # jump to Factorial so user can try again

  Exit: #user input is 0, branch here from menu. Terminates the application.
        li $v0 4 #system call for print string
        la $a0 closing #loads memory address for welcome into $a0
        syscall #prints closing

        li $v0 10 # system call to exit
        syscall
