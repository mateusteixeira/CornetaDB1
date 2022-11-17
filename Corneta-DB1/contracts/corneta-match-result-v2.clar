(define-map results
    {game: uint}
    {r1: uint, r2: uint, balance: uint, commission: uint}
)

(define-map awards 
    {game: uint, award: uint}
    {perc: uint}
)

(define-private (get-result (game uint))
    (map-get? results {game: game})
)

(define-private (guessed-the-result (res (list 4 uint)))
    (and
        (is-eq (element-at res u0) (element-at res u2))
        (is-eq (element-at res u1) (element-at res u3))
    )
)

(define-private (guessed-the-winner-score (res (list 4 uint)))
    (let
        (
            (s1 (default-to u0 (element-at res u0)))
            (s2 (default-to u0 (element-at res u1)))
            (r1 (default-to u0 (element-at res u2)))
            (r2 (default-to u0 (element-at res u3)))
        )
        (and
            (not (is-eq r1 r2))
            (or
                (and (> s1 s2) (is-eq r1 s1))
                (and (> s2 s1) (is-eq r2 s2))
            )
        )
    )
)

(define-private (guessed-the-winner (res (list 4 uint)))
    (let
        (
            (s1 (default-to u0 (element-at res u0)))
            (s2 (default-to u0 (element-at res u1)))
            (r1 (default-to u0 (element-at res u2)))
            (r2 (default-to u0 (element-at res u3)))
        )    
        (or
            (and (is-eq s2 s1) (is-eq r1 r2))        
            (and (> s1 s2) (> r1 r2))
            (and (> s2 s1) (> r2 r1))
        )
    )
)

(define-private (get-award (game uint) (award uint))
    (map-get? awards {game: game, award: award})
)

(define-private (get-contract-balance (game uint))
    (default-to u0 (get balance (get-result game)))
)

(define-private (get-perc (game uint) (award uint))
    (default-to u0 (get perc (get-award game award)))
)

(define-public (set-perc (game uint))
    (let
        (
            (w1 (get-award game u1))
            (perc-w1 (default-to {perc: u50} w1))
            (w2 (get-award game u2))
            (perc-w2 (default-to {perc: u30} w2))
            (w3 (get-award game u3))
            (perc-w3 (default-to {perc: u20} w3))
        )
        (asserts! (is-eq contract-caller (as-contract .corneta-winner-v2)) (err u999))
        
        (or
            (and (is-some w1) (is-some w2) (is-some w3)
                (begin
                    (map-set awards {game: game, award: u1} (merge perc-w1 {perc: u50}))
                    (map-set awards {game: game, award: u2} (merge perc-w2 {perc: u30}))
                    (map-set awards {game: game, award: u3} (merge perc-w3 {perc: u20}))
                )
            )        
            (and (is-some w3) (is-none w1) (is-none w2)
                (map-set awards {game: game, award: u3} (merge perc-w3 {perc: u100}))
            )
            (and (is-some w2) (is-none w1) (is-none w3)
                (map-set awards {game: game, award: u2} (merge perc-w2 {perc: u100}))
            )
            (and (is-some w1) (is-none w2) (is-none w3)
                (map-set awards {game: game, award: u1} (merge perc-w1 {perc: u100}))
            )            
            (and (is-some w2) (is-some w3) (is-none w1)
                (begin
                    (map-set awards {game: game, award: u2} (merge perc-w2 {perc: u60}))
                    (map-set awards {game: game, award: u3} (merge perc-w3 {perc: u40}))
                )
            )
            (and (is-some w1) (is-some w3) (is-none w2)
                (begin
                    (map-set awards {game: game, award: u1} (merge perc-w1 {perc: u70}))
                    (map-set awards {game: game, award: u3} (merge perc-w3 {perc: u30}))
                )
            )            
            (and (is-some w1) (is-some w2) (is-none w3)
                (begin
                    (map-set awards {game: game, award: u1} (merge perc-w1 {perc: u60}))
                    (map-set awards {game: game, award: u2} (merge perc-w2 {perc: u40}))
                )
            )            
        )
        (ok true)
    )
)

(define-public (add-match-result (game uint) (r1 uint) (r2 uint) (balance uint))
    (let
        ((commission (/ (* balance u5) u100)))
         (asserts! (is-eq contract-caller (as-contract .corneta-bridge-v2)) (err u999))
        (ok (map-set results {game: game} {r1: r1, r2: r2, balance: (- balance commission), commission: commission}))    
    )
)

(define-public (add-award (game uint) (award uint))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-winner-v2)) (err u999))
        (if (is-none (get-award game award))
            (ok (map-set awards {game: game, award: award} {perc: u0}))
            (ok true)
        )
    )
)

(define-read-only (get-user-award (game uint) (s1 uint) (s2 uint))
    (let
        (
            (result (get-result game))
            (r1 (default-to u0 (get r1 result)))
            (r2 (default-to u0 (get r2 result)))
            (award 
                (if (guessed-the-result (list s1 s2 r1 r2))
                    u1
                    (if (guessed-the-winner-score (list s1 s2 r1 r2))
                        u2
                        (if (guessed-the-winner (list s1 s2 r1 r2))
                            u3
                            u0
                        )
                    )
                )
            )
        )
        award
    )
)

(define-read-only (get-results (game uint))
    (let ((res (get-result game)))
        (list (default-to u0 (get r1 res)) (default-to u0 (get r2 res)))
    )
)

(define-read-only (get-info-match (game uint) (award uint))
    {balance: (get-contract-balance game), perc: (get-perc game award)}
)