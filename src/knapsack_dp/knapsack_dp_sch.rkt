#lang racket

(define (knapSack n)
  (define (generate-list start count)
    (if (<= count 0)
        '()
        (cons start (generate-list (+ start 1.0) (sub1 count)))))

  (define (knapSack-helper weights values capacity)
    ;; We'll implement the 2D DP approach here.
    
    ;; Convert capacity to an exact integer (e.g., 400).
    (define cap (inexact->exact (floor capacity)))
    (define count (length weights))
    
    ;; dp[i][c] = best value using first i items, capacity c
    (define dp
      (make-vector (add1 count)
                   (vector-copy (make-vector (add1 cap) 0.0))))

    ;; Accessors for dp
    (define (dp-ref i c)
      (vector-ref (vector-ref dp i) c))

    (define (dp-set! i c val)
      (vector-set! (vector-ref dp i) c val))

    ;; Fill dp in a nested loop
    (for ([i (in-range 1 (add1 count))])
      ;; Convert the (i-1)-th weight from a float (e.g., 1.0) to an exact integer (1).
      (define raw-w (list-ref weights (sub1 i)))        ; e.g. 1.0
      (define w (inexact->exact (floor raw-w)))         ; e.g. 1
      ;; The (i-1)-th value stays a float (that’s fine for summation).
      (define v (list-ref values (sub1 i)))
      
      (for ([c (in-range (add1 cap))])
        (if (> w c)
            ;; Can't include this item
            (dp-set! i c (dp-ref (sub1 i) c))
            (let ([excludeVal (dp-ref (sub1 i) c)]
                  [includeVal (+ v (dp-ref (sub1 i) (- c w)))])
              (dp-set! i c (if (> excludeVal includeVal)
                               excludeVal
                               includeVal))))))

    ;; Return dp[count][cap]
    (dp-ref count cap))

  ;; Build [1.0..n] for weights, [10.0..(9+n)] for values
  (define big-weights (generate-list 1.0 n))
  (define big-values  (generate-list 10.0 n))

  (knapSack-helper big-weights big-values 400.0))

;; Finally, call knapSack on the command-line argument and print result
(displayln
  (knapSack (string->number (vector-ref (current-command-line-arguments) 0))))
