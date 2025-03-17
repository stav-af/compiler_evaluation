#lang racket

(define (fib n)
  (define (fib-helper n a b)
    (if (= n 0) a
        (fib-helper (- n 1) b (+ a b))))
  (fib-helper n 0 1))

(displayln (fib (string->number (vector-ref (current-command-line-arguments) 0))))