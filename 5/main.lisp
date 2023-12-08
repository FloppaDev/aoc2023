#!/bin/sbcl --script

;
; I don't understand this language :)
;

; Reads input file to string.
(defun file-get-contents (filename)
    (with-open-file (stream filename)
        (let ((contents (make-string (file-length stream))))
            (read-sequence contents stream)
            contents
        )
    )
)

; Parses lines into lists of numbers
(let (
    (byte 0)
    (has_number 0)
    (number 0)
    (numbers ())
)
    (defun parse-line (line)
        (loop for ch across line do 
            (setq byte (char-code ch))

            (if (and (> byte 47) (< byte 58))
                (progn
                    (setq has_number 1)
                    (decf byte 48)
                    (setq number (* number 10))
                    (incf number byte)
                )

                (progn
                    (if (= has_number 1)
                        (push number numbers)
                    )

                    (setq has_number 0)
                    (setq number 0)
                )
            )
        )

        (if (= 1 has_number) 
            (push number numbers)
        )

        (reverse numbers)
    )
)

(defvar input (file-get-contents "input.txt"))

; Remap seed values
(let (
    (seeds ())
    (_seeds ())
    (values ())
    (dst-start 0)
    (src-start 0)
    (len 0)
    (remapped ())
)
    (with-input-from-string (s input)
        (do ((line (read-line s nil) (read-line s nil)))
            ((null line) ())

            (if (not (= (length line) 0))
                (if (search "map:" line) 
                    (progn
                        (setq seeds remapped)
                        (setq remapped ())
                    ) 
                    (if (search ":" line) 
                        (progn
                            (setq seeds (parse-line line))
                            (setq remapped seeds)
                        )

                        (progn
                            (setq values (parse-line line))
                            (setq dst-start (nth 0 values))
                            (setq src-start (nth 1 values))
                            (setq len (nth 2 values))

                            (setq _seeds ())
                            (print seeds)

                            (loop for seed in seeds do
                                (if (and (>= seed src-start) (< seed (+ src-start len)))
                                    (progn
                                        (setq seed (+ dst-start (- seed src-start)))
                                        (push seed remapped)
                                    )

                                    (push seed _seeds)
                                )
                            )

                            (setq seeds _seeds)
                        )
                    )
                )
            )
        )
    )

    (setq seeds remapped)
    (print seeds)
)

(terpri)
