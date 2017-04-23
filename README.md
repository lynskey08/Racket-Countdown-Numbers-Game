# Racket-Countdown-Numbers-Game

**Student Name:** Gareth Lynskey </br>
**Student ID:** G00312651 </br>
**Course:** Software Development </br>
**Current Year:** 4th Year </br>
**Module:** Theory of Algorithms </br>
**Lecturer:** Dr. Ian McLoughlin </br>

## **_Introduction_**
As part of this project we were given the task of creating a program that solves the countdown numbers game
as seen on the BBC4 television show [Countdown](http://datagenetics.com/blog/august32014/index.html), using the 
functional programming language Racket. 
In the Countdown Numbers game contestants are given six random numbers and a target number. The target number 
is a randomly generated three digit integer between 101 and 999 inclusive. The six random numbers are selected
from the following list of numbers: <br>
**<p align="center">[1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 25, 50, 75, 100]</p>**

**Rules of the Game:**
- You can only use the four basic operations – add(+), subtract(-), multiply(*) and divide(/).
– You can use the six random numbers to calculate the target number, or less (if possible). 
- Each of the six random numbers can only be used once. 
- If the same number appears twice in the list of six then it may be used twice. 
- Negative numbers and fractions are not allowed. For example, you can’t subtract a 7 from a 2, as that would give -5, and likewise
you can’t divide 2 by 7 as that gives a fraction. <br>

**Example:**<br>
Suppose the target number is 424 and the six random numbers are [1, 2, 2, 10, 25, 100]. 
Then the following calculation works: (100×(2+2))+25−1. The steps in this calculation are broken down into individual
operations as follows. First add 2 and 2, to give 4. Then multiply this by
100, to give 400. Then add 25 to give 425. Finally subtract 1 to give 424.

## **_How to Run_**
- Download and install [Racket](https://racket-lang.org/download/).
- Clone the repository from https://github.com/lynskey08/Racket-Countdown-Numbers-Game/ in your command prompt.
> git clone https://github.com/lynskey08/Racket-Countdown-Numbers-Game/
- Start DrRacket and click: File -> Open, and navigate to the folder of the downloaded repository and select the
file "Countdown Number Game.rkt".
- When the file is open in DrRacket, click the "Run" button in the top right corner of the application. <br>
**Output:**
The application will generate a random target number between 101 and 999. It will also randomly generate 6 numbers
from the list of numbers [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 25, 50, 75, 100] to be used 
in the calculation.

## **_Solution_**
```Racket
(define numList (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
```
Here I defined a list of numbers called numList that contains the range of numbers that the six random numbers are chosen from.

```Racket
(define opsList(list '+ '+ '+ '+ '+ '- '- '- '- '- '* '* '* '* '* '/ '/ '/ '/ '/))
```
I defined a list operators called opsList that contains the operators that can be used in the calcuation of the sum. 
The reason I have 5 of each operator is because I originally wanted to generate all the permutations of all the numbers
and operators and then pass them through the valid-rpn? to filter out the non-valid rpn expressions. I ran into problems
trying to figure out this method so I created a function that randomly selects 5 operators which I will explain below.

```Racket
(define targetNumber (random 101 1000))
```
The target number generator uses the Racket built in random function and generates a random number between the values 101 and 999.
I set the value of the max number to 1000 and not 999 because the set value cannot be chosen randomly, meaning 999 will never be choosen. I did not change the min number because the min number can be chosen randomly.

```Racket
(define numSelection4 (list))
(define (randomNumList l) 
  (define randomNumber(list-ref l(random (length l))))  
  (set! l(remove randomNumber l)) 
  (set! numSelection4 (cons randomNumber numSelection4))  
  (if (= (length numSelection4) 4)
     numSelection4 ;print numSelection4
      (randomNumList l))
)
(randomNumList numList)
```
Here I defined a function which I used to generate a list 4 random numbers from the list of given numbers. I used this same function
again to generate a list of 2 numbers, a list 4 operators and a list of a single operator. The reason I chose to generate the numbers and operators using this method was to make adhering to the reverse polish notation stucture much easier. In order for a reverse polish notation to be valid, it must have two numbers at the start of the stack and one operator at the end.

```Racket
(define perms(remove-duplicates (permutations (append numSelection4 opsSelection4))))
```
Here I defined the function perms that appends the lists numSelection4 and opsSelection4. It then generates all the permutations and removed any duplicates between them.

```Racket
(define (to-rpn l)
  (cond [(valid-rpn? (append numSelection2 l opsSelection1))
   (calculate-RPN (append numSelection2 l opsSelection1))]))
```
He is a to-rpn(reverse polish notation) function that add two numbers
to the front of the stack, and one operator to the back of the stack, as I mentioned above,
this is required for it to be a valid rpn.

```Racket
(define (calculate-RPN expr)
  (for/fold ([stack '()]) ([token expr])
    (printf "~a\t -> ~a~N" token stack)
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (cons (/ y x) s)]
     [('^ (list x y s ___)) (cons (expt y x) s)]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))
```
This is the algorithm in which I used to calculate the reverse polish notation which I found [here](https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket).


```Racket
(display (~v (remove-duplicates answerList)))
```
This displays the list of of all the possible calculations of the equation.

```Racket
(map to-rpn perms)
```
Here map passes each item of the list perms into the function to-rpn in order to validate it.

## **_Reverse Polish Notation_**
Reverse Polish notation is a syntax for writing mathematical expressions in which every operator follows all of its operands, in contrast to Polish notation (PN), which puts the operator before its operands. It is also known as postfix notation. It does not need any parentheses as long as each operator has a fixed number of operands.<br>
**Example:**<br>
Consider the following bracketed expression:<br>
((5 + 4) × 9) ÷ (6 − 3) <br>
This expression is written in what we call in-fix notation – the (binary) operators are written
in-between their (two) operands. The operators in this case are the common addition, subtraction,
multiplication and division. The operands are the numbers to which these operators are to
be applied: 5, 4, 9, 6 and 3. In reverse Polish notation (RPN), this expression is written as:<br>
5 4 + 9 × 6 3 − ÷<br>
The difference between the RPN form and the infix form is simply that the operator is written
after its two operands, rather than between.<br>
The reason I chose to use the reverse polish notation was because it makes it much easier
to evaluate an equation using only a single stack. I used the stack to help validate rpn expressions by checking each
element of the list. Pushing and pulling involves placing or removing an element to/from the top of the stack. 

## **_Conclusion_**
In the end I didn't have enough time the optimise the algorithm as much as I had planned. The algorithm checks if the answer to the equation is the target answer. It tries to filters out equations that are by 0 and it also tries to filter out equations that are being divides by a greater number. This algorithm is still home to many errors as it prints out valid answers which are incorrect.
For example: If the target number was 165, and one of the equations evaluates to -165, the negative answer would be outputted as correct. If I were to do the project again I would have started it a lot earlier and I would have looked into fixing this error and maybe optimising the algorithm some more. Towards the end i had little time and I started to rush everything.

# **_Resources_**

[https://en.wikipedia.org/wiki/Reverse_Polish_notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation)<br>
[https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket](https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket)<br>
[http://stackoverflow.com/questions/40566422/random-function-in-racket](http://stackoverflow.com/questions/40566422/random-function-in-racket)<br>
[http://stackoverflow.com/questions/1041603/how-do-i-write-push-and-pop-in-scheme](http://stackoverflow.com/questions/1041603/how-do-i-write-push-and-pop-in-scheme)<br>
[https://learnonline.gmit.ie/mod/url/view.php?id=189393](https://learnonline.gmit.ie/mod/url/view.php?id=189393)<br>
[https://docs.racket-lang.org/guide/set_.html](https://docs.racket-lang.org/guide/set_.html)<br>
[https://docs.racket-lang.org/guide/read-write.html](https://docs.racket-lang.org/guide/read-write.html)<br>
[http://stackoverflow.com/questions/19913606/delete-element-from-list-in-scheme](http://stackoverflow.com/questions/19913606/delete-element-from-list-in-scheme)<br>
[http://stackoverflow.com/questions/4583224/how-do-i-write-a-procedure-that-randomly-selects-a-pair-from-a-list](http://stackoverflow.com/questions/4583224/how-do-i-write-a-procedure-that-randomly-selects-a-pair-from-a-list)<br>
[http://stackoverflow.com/questions/15058246/reverse-list-scheme](http://stackoverflow.com/questions/15058246/reverse-list-scheme)<br>
[https://docs.racket-lang.org/](https://docs.racket-lang.org/)<br>
[https://github.com/PaprikaZ/programming-exercises/blob/master/racket/leetcode/evaluate-reverse-polish-notation.rkt](https://github.com/PaprikaZ/programming-exercises/blob/master/racket/leetcode/evaluate-reverse-polish-notation.rkt)<br>
[http://www.datagenetics.com/blog/august32014/index.html](http://www.datagenetics.com/blog/august32014/index.html)<br>

