(define-module (jayu utils lists)
  #:use-module (srfi srfi-1))

(define-public (nth pos lst)
  "Get the element from LST at position POS."
  (if (or (>= pos (length lst)) (< pos 0))
      (error "Index out of bounds")
    (car (drop lst pos))))
