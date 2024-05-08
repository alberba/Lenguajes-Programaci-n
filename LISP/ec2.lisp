(defun ec2grau (a b c)
    (let ((delta (- (* b b) (* 4 a c))))
        (if (< delta 0)
            nil
        (let ((x1 (/ (- (- b) (sqrt delta)) (* 2 a)))
                (x2 (/ (+ (- b) (sqrt delta)) (* 2 a))))
            (list x1 x2)))
    )
)

(defun e2grau (a b c)
    (let ((delta (- (* b b) (* 4 a c))))
        (cond
            ((minusp delta) nil)
            ((zerop delta) (list (/ (- b) (* 2 a))))
            (t
                (list
                    (/ (+ (- b) (sqrt delta)) (* 2 a))
                    (/ (- (- b) (sqrt delta)) (* 2 a))
                )
            )
        )
    )
)