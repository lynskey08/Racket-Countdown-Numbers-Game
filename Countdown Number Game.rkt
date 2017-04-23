#lang racket

; Defined a list numList that contains the numbers that can be used in the calcuation of the sum
(define numList (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
; Defined a list opsList that contains the operators that can be used in the calcuation of the sum
(define opsList(list '+ '+ '+ '+ '+ '- '- '- '- '- '* '* '* '* '* '/ '/ '/ '/ '/))
;(display "This is the range of that 6 randomly generated numbers will be chosen from: ")numList
;(display "\n")

;Random number generator - picks a random number between the values 101 and 999
;I set the max number as 1000 and not 999 because the set value cannot be chosen
;randomly and in case we want to use 999. I did not change the min number because
;the min number can be chosen randomly. 
(define targetNumber (random 101 1000))
(display "This is the target number: ")targetNumber
(display "This is the randomly selected range of numbers you can use: ")

;Defined empty lists to store the random numbers and operators from the lists numList and opsList.
;I created 4 list, numSelection4 to store 4 random numbers, numSelection2 to store 2 random
;numbers, opsSelection4 to store 4 random operators and opsSelection1 to store 1 random number
(define numSelection4 (list))
(define numSelection2 (list))
(define opsSelection4 (list))
(define opsSelection1 (list))

;Defines the function that takes in the variable l(basically the list of numbers)
;Define the function randomNumber that uses list-ref to get a certain position in
;a list. In this case I use it to find a certain random number and operator in the lists l.
;It then removes the random numbers and operators from the list l that has already been
;selected to ensure that it cannot be selected again
;Add the 4 random number to the list numSelection4, 2 random numbers to the list numSelection2,
;4 random operators to the list opsSelection4 and 1 random operator to the list opsSelection1
;if the length of l corresponds to its given value(e.g: if the numSelection4 is of length 4), print the list
;else call the function again with the updated l list
(define (randomNumList l)
  
  (define randomNumber(list-ref l(random (length l))))  
  (set! l(remove randomNumber l)) 
  (set! numSelection4 (cons randomNumber numSelection4))  
  (if (= (length numSelection4) 4)
     numSelection4 ;print numSelection4
      (randomNumList l))
)

(define (randomNumList2 l)
  (define randomNumber2(list-ref l(random (length l))))  
  (set! l(remove randomNumber2 l)) 
  (set! numSelection2 (cons randomNumber2 numSelection2))  
  (if (= (length numSelection2) 2)
     numSelection2 ;print numSelection2
      (randomNumList2 l)) 
)
; the list numList is passed into empty list randomNumList and randomNumList2
(randomNumList numList)
(randomNumList2 numList)

; function to retrieve 4 random operators from opsList
(define (randomOpsList4 l)
  
  (define randomOps(list-ref l(random (length l))))  
  (set! l(remove randomOps l)) 
  (set! opsSelection4 (cons randomOps opsSelection4))  
  (if (= (length opsSelection4) 4)
     opsSelection4 ;print opsSelection4
      (randomOpsList4 l))
)

; function to retrieve 1 random operators from opsList
(define (randomOpsList1 l)
  
  (define randomOps(list-ref l(random (length l))))  
  (set! l(remove randomOps l)) 
  (set! opsSelection1 (cons randomOps opsSelection1))  
  (if (= (length opsSelection1) 1)
     opsSelection1 ;print opsSelection2
      (randomOpsList1 l))
)
; the list opsList is passed into this empty list randomOpsList4 and randomOpsList1
(randomOpsList4 opsList)
(randomOpsList1 opsList)

(display "\n")
(display "\n")
(display "\n")

;
(define perms(remove-duplicates (permutations (append numSelection4 opsSelection4))))

;Function valid-rpn to validate the format of a rpn equation
;Takes in a list e with a stack s which is set to 0
(define (valid-rpn? e [s 0])
  ;if e is null, continue
  (if (null? e)
      ;if the stack is equal to 1 continue, else false
      (if (= s 1) #t #f)
       ;if the first thing of the list a number, return true
      (if(number? (car e))
         ;if it's a valid rpn, add an element to the stack
         (valid-rpn? (cdr e) (+ s 1))
         (if (> s 1)
             (valid-rpn? (cdr e) (- s 1))
             #f))))




;Calculate the Reverse Polish Notation
;adapted from: https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket
(define (calculate-RPN expr)
  (for/fold ([stack '()]) ([token expr])
    (printf "~a\t -> ~a~N" token stack)
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (if (< x y)
                                #f
                             (cons (- y x) s))]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (if (= y 0)
                                (cons 0 s)
                                (if (= x 0)
                                    (cons 0 s)
                                    (cons (/ y x) s)))]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))

; then we define a to-rpn(reverse polish notation) function that add two numbers
; to the front and one operator to the back of the permutation as this is required
; for it to be a valid rpn

(define (to-rpn l)
  (cond [(valid-rpn? (append numSelection2 l opsSelection1))
   (calculate-RPN (append numSelection2 l opsSelection1))]))
; map passes each item of the list perms into the function to-rpn in order to
; validate it
(map to-rpn perms)










