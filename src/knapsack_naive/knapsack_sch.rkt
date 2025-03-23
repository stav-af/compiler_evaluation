#lang racket

(define (knapSack n)
  (define (generate-list start count)
    (if (<= count 0)
        '()
        (cons start (generate-list (+ start 1.0) (sub1 count)))))

  (define (knapSack-helper weights values capacity)
    (cond
      [(or (null? weights) (null? values))
       0.0]
      [(< capacity 0.0)
       0.0]
      [else
       (let ([whead (car weights)]
             [vhead (car values)])
         (if (> whead capacity)
             (knapSack-helper (cdr weights) (cdr values) capacity)
             (let* ([excludeVal (knapSack-helper (cdr weights) (cdr values) capacity)]
                    [includeVal (+ vhead
                                   (knapSack-helper (cdr weights) (cdr values)
                                                    (- capacity whead)))])
               (if (> excludeVal includeVal)
                   excludeVal
                   includeVal))))]))

  (define big-weights (generate-list 1.0 n))
  (define big-values  (generate-list 10.0 n))

  (knapSack-helper big-weights big-values 400.0))

(displayln
  (knapSack (string->number (vector-ref (current-command-line-arguments) 0))))