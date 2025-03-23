#lang racket

(define (catalan n)
  (if (= n 0)
      1
      (catalan-sum n 0)))

(define (catalan-sum n i)
  (if (= i n)
      0
      (+ (* (catalan i) (catalan (- n 1 i)))
         (catalan-sum n (+ i 1)))))

(let* ([args (vector->list (current-command-line-arguments))]
       [n (string->number (car args))])
  (printf "~a\n" (catalan n)))