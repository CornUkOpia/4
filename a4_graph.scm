(define (make-graph)
    (define graph '())
    (define (add-node x)
      (cond ((eq? (checkNodeExists x graph) #f) (set! graph (cons (cons x '()) graph)) #t)
            (else #f)
          )
        )
    (define (checkNodeExists nodeToFind graphToCheck)
      (cond ((null? graphToCheck) #f)
            ((eq? nodeToFind (car (car graphToCheck))) #t)
            (else(checkNodeExists nodeToFind (cdr graphToCheck)))
            )
      

      )
    (define (add-edge x y)

      
      (cond ((and (eq? (checkNodeExists x graph) #t) (eq? (checkNodeExists y graph) #t))  (add-edge-to-node x y graph) (add-edge-to-node y x graph) #t)
            (else #f)
          )
      
        )
    (define (add-edge-to-node nodeToAddEdgeTo EdgeTo graphToCheck)
      (cond ((null? graphToCheck) #f)
            ((eq? (car (car graphToCheck)) nodeToAddEdgeTo)
             (cond ((null? (cdr (car graphToCheck))) (set! graph (add-modified-node-to-graph nodeToAddEdgeTo (cons (car (car graphToCheck)) (list (append (cdr (car graphToCheck)) (list EdgeTo)))) graph)))
                   (else (set! graph (add-modified-node-to-graph nodeToAddEdgeTo (cons (car (car graphToCheck)) (list (append (car (cdr (car graphToCheck))) (list EdgeTo)))) graph))))
             #t
             )
            (else (add-edge-to-node nodeToAddEdgeTo EdgeTo (cdr graphToCheck)))
            )
      )
    (define (add-modified-node-to-graph nodeToAddEdgeTo modifiedNode graphToModify)
      (cond ((null? graphToModify) #f)
            ((eq? (car (car graphToModify)) nodeToAddEdgeTo)
             (cons modifiedNode (cdr graphToModify))
             )
            (else (cons (car graphToModify) (add-modified-node-to-graph nodeToAddEdgeTo modifiedNode (cdr graphToModify))))
            )
      )
    (define (remove-node x)
      (display x)
      (display "\n")
        )
    (define (remove-edge x y)
      (display x)
      (display y)
      (display "\n")
        )
    

    (define (dispatch method)
      (display method)
        (cond ((eq? method 'add-node) add-node)
              ((eq? method 'add-edge) add-edge)
              ((eq? method 'remove-node) remove-node)
              ((eq? method 'remove-edge) remove-edge)
			  (else (lambda() (display "Unknown Request: ")
			                  (display method)(newline)))))
    dispatch)

(define G (make-graph))
(display G)
((G 'add-node) 'a)
((G 'add-node) 'b)
((G 'add-node) 'c)
((G 'add-edge) 'a 'b)
((G 'add-edge) 'a 'c)
((G 'add-edge) 'b 'c)
((G 'add-node) 'd)
((G 'add-edge) 'b 'd)
;((G 'remove-edge) 'a 'c)