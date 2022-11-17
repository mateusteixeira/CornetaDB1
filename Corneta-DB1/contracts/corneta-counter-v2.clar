(define-map total
    {game: uint, award: uint}
    {count: uint}
)

(define-public (add-total (game uint) (award uint))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-winner-v2)) (err u999))     
        (let ((total-count (get-total-by-award game award)))
            (ok (map-set total {game: game, award: award} {count: (+ total-count u1)}))
        )
    )
)

(define-read-only (get-total-by-award (game uint) (award uint))
    (default-to u0 (get count (map-get? total {game: game, award: award})))
)