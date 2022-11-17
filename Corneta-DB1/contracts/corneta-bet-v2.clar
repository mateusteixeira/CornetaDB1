(define-constant HAS_BET (err u12))
(define-constant BET_NOT_FOUND (err u13))

(define-map bets
    {game: uint, user: principal}
    {s1: uint, s2: uint, free: bool, you-got: uint}
)

(define-private (get-user-bet (game uint) (user principal))
    (map-get? bets {game: game, user: user})
)

(define-public (add-bet (game uint) (bet {s1: uint, s2: uint, free: bool, you-got: uint}))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-bridge-v2)) (err u999))
        (asserts! (is-none (get-user-bet game tx-sender)) HAS_BET)
        (ok (map-set bets {game: game, user: tx-sender} bet))
    )
)

(define-public (update-bet (game uint) (user principal) (bet {s1: uint, s2: uint, free: bool, you-got: uint}))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-rank-v2)) (err u999))
        (ok (map-set bets {game: game, user: user} bet))
    )
)

(define-read-only (get-bet (game uint) (user principal))
    (ok (unwrap! (get-user-bet game user) BET_NOT_FOUND))
)