(define-constant BET_NOT_FOUND_FOR_USER (err u20))
(define-constant UPDATE_BET_ERROR (err u21))
(define-constant NO_RANK_FOUND (err u22))

(define-map ranks
    {game: uint, page: uint}
    {list: (list 50 {user: principal, position: uint, spots: uint})}
)

(define-map ranks-page
    {game: uint}
    {curr-page: uint, last-position: uint}
)

(define-private (get-rank (game uint) (page uint)) 
    (map-get? ranks {game: game, page: page})
)

(define-private (add-to-curr-rank (game uint) (rank {user: principal, position: uint, spots: uint}))
    (concat
        (get list (unwrap-panic (get-rank-at-page game (get-curr-page-ranks game))))
        (list {user: (get user rank), position: (get position rank), spots: (get spots rank)})
    )
)

(define-private (create-rank (game uint) (rank {user: principal, position: uint, spots: uint}) (new-page bool))
    (ok
        (map-set ranks
            {game: game, page: (get-curr-page-ranks game)}
            {list:
                (if new-page
                    (unwrap-panic (as-max-len? (list rank) u50))
                    (unwrap-panic (as-max-len? (add-to-curr-rank game rank) u50))
                )
            }
        )
    )
)

(define-private (curr-page-ranks-has-room (game uint))
    (let
        ((rank-list (get list (get-rank game (get-curr-page-ranks game)))))
        (and
            (is-some rank-list)
            (> u20 (len (unwrap-panic rank-list)))
        )
    )
)

(define-private (get-curr-page-ranks (game uint))
    (default-to u0 (get curr-page (get-ranks-page game)))
)

(define-private (get-ranks-page (game uint))
    (map-get? ranks-page {game: game})
)

(define-private (next-page-ranks-list (game uint) (rank {user: principal, position: uint, spots: uint}))
    (let
        ((rp (default-to {curr-page: u0, last-position: u0} (get-ranks-page game))))
        (map-set ranks-page
            {game: game}
            {curr-page: (+ (get-curr-page-ranks game) u1), last-position: (get last-position rp)})
        (create-rank game rank true)
    )
)

(define-public (add-rank (game uint) (award uint) (user principal))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-winner-v2)) (err u999))
        (let 
            (
                (info-match (contract-call? .corneta-match-result-v2 get-info-match game award))
                (balance (get balance info-match))
                (perc (get perc info-match))
                (bet (unwrap! (contract-call? .corneta-bet-v2 get-bet game user) BET_NOT_FOUND_FOR_USER))
                (can-transfer (if (or (get free bet) (is-eq award u0)) false true))
                (average (if can-transfer (/ (* balance perc) u100) u0))
                (you-got (if can-transfer (/ average (contract-call? .corneta-counter-v2 get-total-by-award game award)) u0))
                (rp (default-to {curr-page: u0, last-position: u0} (get-ranks-page game)))
                (lp (+ (get last-position rp) u1))
            )

            (map-set ranks-page {game: game} (merge rp {last-position: lp}))
            (unwrap! (contract-call? .corneta-bet-v2 update-bet game user (merge bet {you-got: you-got})) UPDATE_BET_ERROR)

            (let
                (
                    (spots (if (is-eq award u0) u0 (if (is-eq award u1) u5 (- u5 award))))                    
                    (rank {user: user, position: lp, spots: spots})
                )
                (if (curr-page-ranks-has-room game)
                    (create-rank game rank false)
                    (next-page-ranks-list game rank)
                )                
            )
        )    
    )
)

(define-read-only (get-rank-at-page (game uint) (page uint))
    (ok (unwrap! (get-rank game page) NO_RANK_FOUND))
)