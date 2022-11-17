(define-constant NO_USER_FOUND (err u14))
(define-constant MAX_LEN_ERROR (err u15))
(define-constant PAGE_NOT_FOUND (err u16))
(define-constant MAX_LEN_USER_PER_PAGE u50)

(define-map users 
    {game: uint, page: uint}
    {list: (list 50 {game: uint, user: principal})}
)

(define-map users-page
    {game: uint}
    {curr-page: uint, list: (list 500 {game: uint, page: uint})}
)

(define-private (add-to-curr-users (game uint) (user principal))
    (concat (get list (unwrap-panic (get-users game (get-curr-page-users game)))) (list {game: game, user: user}))
)

(define-private (curr-page-users-has-room (game uint))
    (let 
        ((usr-list (get list (get-users game (get-curr-page-users game)))))
        (and
            (is-some usr-list)
            (> MAX_LEN_USER_PER_PAGE (len (unwrap-panic usr-list)))
        )
    )
)

(define-read-only (get-users-at-page (game uint) (page uint))
    (ok (unwrap! (get-users game page) NO_USER_FOUND))
)

(define-private (next-page-users-list (game uint) (user principal))
    (let
        (
            (next-page (+ (get-curr-page-users game) u1))
            (new-list (list {game: game, page: next-page}))
        )
        (map-set users-page
            {game: game}
            {curr-page: next-page,
             list:
                (if (is-eq next-page u1)
                    (unwrap! (as-max-len? new-list u500) MAX_LEN_ERROR)
                    (unwrap! (as-max-len? (concat (get list (unwrap-panic (get-users-page game))) new-list) u500) MAX_LEN_ERROR)
                )
            }
        )
        (create-user game user true)
    )
)

(define-private (create-user (game uint) (user principal) (new-page bool))
    (ok
        (map-set users
            {page: (get-curr-page-users game), game: game}
            {list:
                (if new-page
                    (unwrap-panic (as-max-len? (list {game: game, user: user}) u50))
                    (unwrap-panic (as-max-len? (add-to-curr-users game user) u50))
                )
            }
        )
    )
)

(define-private (search-user-by-page (match-info {game: uint, page: uint}))
    (let
        ((users-list (unwrap! (get-users-at-page (get game match-info) (get page match-info)) PAGE_NOT_FOUND)))
        (ok (map validate-user-bet (get list users-list)))
    )
)

(define-private (get-users (game uint) (page uint))
    (map-get? users {game: game, page: page})
)

(define-private (validate-user-bet (match-info {game: uint, user: principal}))
    (ok (contract-call? .corneta-winner-v2 add-winner match-info))
)

(define-private (get-curr-page-users (game uint))
    (default-to u0 (get curr-page (get-users-page game)))
)

(define-public (add-user (game uint))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-bridge-v2)) (err u999))
        (if (curr-page-users-has-room game)
            (create-user game tx-sender false)
            (next-page-users-list game tx-sender)
        )    
    )
)

(define-public (search-users (pages (list 500 {game: uint, page: uint})))
    (begin
        (asserts! (is-eq contract-caller (as-contract .corneta-bridge-v2)) (err u999))
        (ok (map search-user-by-page pages))
    )
)

(define-read-only (get-users-page (game uint))
    (map-get? users-page {game: game})
)
