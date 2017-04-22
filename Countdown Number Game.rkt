#lang racket
#|
; Defined a list called num that contains the numbers that can be used in
; the calcuation of the sum
(define numList (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
(display "This is the range of that 6 randomly generated numbers will be chosen from: ")numList
(display "\n")

;Random number generator - picks a random number between the values 101 and 999
;I set the max number as 1000 and not 999 because the set value cannot be chosen
; randomly and in case we want to use 999. I did not change the min number because
; the min number can be chosen randomly. 
(define targetNumber (random 101 1000))
(display "This is the target number: ")targetNumber
(display "This is the randomly selected range of numbers you can use: ")

;Defined an empty list to store the 6 random numbers from the list numList
(define numSelection (list))

;Defines the function that takes in the variable l(basically the list of numbers)
(define (randomNumList l)
  ;Define the function randomNumber that uses list-ref to get a certain position in
  ; a list. In this case I use it to find a certain random number in the list l.
  (define randomNumber(list-ref l(random (length l))))
  ;Removes the random number from the list l that has already been selected to
  ;ensure that it cannot be selected again
  (set! l(remove randomNumber l))
  ;Add the random number to the list numSelection
  (set! numSelection (cons randomNumber numSelection))
  ;if the length of l is 6
  (if (= (length numSelection) 6)
     numSelection ;print numSelection
      (randomNumList l))) ;else call the function again with the updated l list

; the list numList is passed into this empty list randomNumList
(randomNumList numList)

; the algorithm
(display "\n")
(display "\n")
(display "\n")



; define a list called start with the values -1 and 1. 1 represents a number and
; -1 represents an operator
(define start(list -1 -1 -1 -1 1 1 1 1))
; define a lost getPerms that gets all the permutations of the list start and
; removes the duplicates.
(define getPerms(remove-duplicates (permutations start)))
; then we define a to-rpn(reverse polish notation) function that add two numbers
; to the front and one operator to the back of the permutation as this is required
; for it to be a valid rpn
(define (to-rpn l)
  (append (list 1 1) l (list -1)))
; map passes each item of the list getPerms into the function to-rpn in order to
; validate it
;(map to-rpn getPerms)

; defines the function valid-rpn that validates the format of a rpn equation
(define (valid-rpn? e [s 0])
  (if (null? e)
      (if (= s 1) #t #f)
      (if(= (car e) 1)
         (valid-rpn? (cdr e) (+ s 1))
         (if (< s 2) #f (#t)))))
(display "\n")
(display "\n")|#

(define l(list 1 2 '+ 4 '-))









