(define-constant BET_NOT_FOUND (err u13))
(define-constant NO_WINNER_FOUND (err u17))
(define-constant ERR_ADD_COUNTER (err u18))
(define-constant ERR_ADD_RANK (err u19))

(define-map winners
    {game: uint, page: uint, award: uint}
    {list: (list 50 {game: uint, user: principal})}
)

(define-map winners-page
    {game: uint, award: uint}
    {curr-page: uint}
)

(define-private (add-to-curr-winners (game uint) (user principal) (award uint))
    (concat (get list (unwrap-panic (get-winners game (get-curr-page-winners game award) award))) (list {game: game, user: user}))
)

(define-private (curr-page-winners-has-room (game uint) (award uint))
    (and
        (is-some (get list (get-winners game (get-curr-page-winners game award) award)))
        (> u50 (len (unwrap-panic (get list (get-winners game (get-curr-page-winners game award) award)))))
    )
)

(define-private (curr-page-winners-incr (game uint) (user principal) (award uint))
    (unwrap-panic (as-max-len? (add-to-curr-winners game user award) u50))
)

(define-private (get-winners-at-page (game uint) (page uint) (award uint))
    (ok (unwrap! (get-winners game page award) NO_WINNER_FOUND))
)

(define-private (get-curr-page-winners (game uint) (award uint))
    (default-to u0 (get curr-page (map-get? winners-page {game: game, award: award})))
)

(define-private (next-page-winners-list (game uint) (user principal) (award uint) (free bool))
    (begin
        (map-set winners-page
            {game: game, award: award}
            {curr-page: (+ (get-curr-page-winners game award) u1)})
        (create-winner game user award free true)
    )
)

(define-private (rank-w1 (match-info {game: uint, user: principal}))
    (ok (unwrap! (contract-call? .corneta-rank-v2 add-rank (get game match-info) u1 (get user match-info)) ERR_ADD_RANK))
)

(define-private (rank-w2 (match-info {game: uint, user: principal}))
    (ok (unwrap! (contract-call? .corneta-rank-v2 add-rank (get game match-info) u2 (get user match-info)) ERR_ADD_RANK))
)

(define-private (rank-w3 (match-info {game: uint, user: principal}))
    (ok (unwrap! (contract-call? .corneta-rank-v2 add-rank (get game match-info) u3 (get user match-info)) ERR_ADD_RANK))
)

(define-private (rank-w0 (match-info {game: uint, user: principal}))
    (ok (unwrap! (contract-call? .corneta-rank-v2 add-rank (get game match-info) u0 (get user match-info)) ERR_ADD_RANK))
)

(define-private (search-winners (match-info {game: uint, page: uint}))
    (let
        (
            (game (get game match-info))
            (page (get page match-info))
        )
        (try! (search-winners-by-award game page u1))
        (try! (search-winners-by-award game page u2))
        (try! (search-winners-by-award game page u3))
        (try! (search-winners-by-award game page u0))
        (ok true)
    )
)

(define-private (search-winners-by-award (game uint) (page uint) (award uint))
    (if (is-some (get-winners game page award))
        (let
            ((wlist (get list (try! (get-winners-at-page game page award)))))
            (if (is-eq award u1)
                (map rank-w1 wlist)
                (if (is-eq award u2)
                    (map rank-w2 wlist)
                    (if (is-eq award u3)
                        (map rank-w3 wlist)
                        (map rank-w0 wlist)
                    )
                )
            )
            (ok true)
        )
        (ok true)
    )
)

(define-private (create-winner (game uint) (user principal) (award uint) (free bool) (new-page bool))
    (begin
        (map-set winners
            {game: game, page: (get-curr-page-winners game award), award: award}
            {list: 
                (if new-page
                    (unwrap-panic (as-max-len? (list {game: game, user: user}) u50))
                    (curr-page-winners-incr game user award))
            }
        )
        (if (not free)
            (begin
                (try! (contract-call? .corneta-match-result-v2 add-award game award))
                (ok (unwrap! (contract-call? .corneta-counter-v2 add-total game award) ERR_ADD_COUNTER))
            )
            (ok true)
        )
    )
)

(define-private (get-winners (game uint) (page uint) (award uint))
    (map-get? winners {game: game, page: page, award: award})
)

(define-public (add-winner (match-info {game: uint, user: principal}))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-user-v2)) (err u999))
        (let
            (
                (game (get game match-info))
                (user (get user match-info))
                (bet (unwrap! (contract-call? .corneta-bet-v2 get-bet game user) BET_NOT_FOUND))
                (s1 (get s1 bet))
                (s2 (get s2 bet))
                (free (get free bet))
                (award (contract-call? .corneta-match-result-v2 get-user-award game s1 s2))
            )
            (if (curr-page-winners-has-room game award)
                (ok (create-winner game user award free false))
                (ok (next-page-winners-list game user award free))
            )            
        )
    )
)

(define-public (generate-rank (match-info (list 500 {game: uint, page: uint})))
    (let
        ((info (default-to {game: u0, page: u0} (element-at match-info u0))))
        (asserts! (is-eq contract-caller (as-contract .corneta-bridge-v2)) (err u999))
        (try! (contract-call? .corneta-match-result-v2 set-perc (get game info)))
        (ok (map search-winners match-info))
    )
)