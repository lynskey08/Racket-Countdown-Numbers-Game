#lang racket

; Defined a list called num that contains the numbers that can be used in
; the calcuation of the sum
(define numList (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
numList

; random number generator - picks a random number between the values 101 and 999
; I set the max number as 1000 and not 999 because the set value cannot be chosen
; randomly and in case we want to use 999. I did not change the min number because
; the min number can be chosen randomly. 
(define targetNumber (random 101 1000))
targetNumber

; defined an empty list to store the 6 random numbers from the list numList
(define numSelection (list))


; defines the function that takes in the variable l(basically the list of numbers)
(define (randomNumList l)
  ; define the function randomNumber that uses list-ref to get a certain position in
  ; a list. In this case I use it to find a certain random number in the list l.
  (define randomNumber(list-ref l(random (length l)))
  ;set the list l and removes the random number from the list l that has already been selected to ensure that it cannot be selected again
  (set! l(remove randomNumber l))
  (if (= (length numSelection) 6)
      numSelection
      (randomNumList l)))




; the list numList is passed into this empty list randomNumList
(randomNumList numList)



  