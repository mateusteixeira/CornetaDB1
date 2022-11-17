(define-constant SEARCH_USERS_ERROR (err u8))
(define-constant ADD_MATCH_RESULT_ERROR (err u9))
(define-constant CALCULATE_ERROR (err u10))
(define-constant GENERATE_RANK_ERROR (err u11))

(define-public (create-bet (game uint) (s1 uint) (s2 uint) (free bool) (you-got uint))
    (let
        (
            (res-bet (contract-call? .corneta-bet-v2 add-bet game {s1: s1, s2: s2, free: free, you-got: you-got}))
            (res-usr (contract-call? .corneta-user-v2 add-user game))
        )
        (if (is-err res-bet)
            res-bet
            (if (is-err res-usr)
                res-usr
                (ok true)
            )
        )
    )
)

(define-public (close-bet (game uint) (match-info (list 500 {game: uint, page: uint})) (r1 uint) (r2 uint) (balance uint))
    (begin
        (unwrap! (contract-call? .corneta-match-result-v2 add-match-result game r1 r2 balance) ADD_MATCH_RESULT_ERROR)
        (unwrap! (calc-bet game match-info) CALCULATE_ERROR) 
        (unwrap! (contract-call? .corneta-winner-v2 generate-rank match-info) GENERATE_RANK_ERROR)
        (ok true)
    )
)

(define-private (calc-bet (game uint) (pages (list 500 {game: uint, page: uint})))
    (begin
        (unwrap! (contract-call? .corneta-user-v2 search-users pages) SEARCH_USERS_ERROR)
        (ok true)
    )
)