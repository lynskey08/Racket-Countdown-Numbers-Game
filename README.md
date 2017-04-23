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
- When the file is open in DrRacket, click the "Run" button in the top right corner of the application.

## **_Solution_**
```Racket
(define numList (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))
```
Here I defined a list of numbers called numList that contains the range of numbers that the six random numbers are chosen from.

```Racket
(define opsList(list '+ '+ '+ '+ '+ '- '- '- '- '- '* '* '* '* '* '/ '/ '/ '/ '/))
```
I defined a list operators called opsList that contains the operators that can be used in the calcuation of the sum. 
The reason I have 5 of each operator is because some calculation may have to use



