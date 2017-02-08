#lang racket

; Defined a list called num that contains the numbers that can be used in
; the calcuation of the sum
(define num (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
num

; random number generator - picks a random number between the values 101 and 999
(define rand (random 101 999))
rand