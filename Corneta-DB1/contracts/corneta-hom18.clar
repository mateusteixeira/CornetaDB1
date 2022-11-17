(define-constant MATCH_NUMBER u18)
(define-constant BET_AMOUNT u5000000)

(define-constant ONLY_ADMIN (err u1))
(define-constant INVALID_SCORE (err u2))
(define-constant IS_CLOSED (err u3))
(define-constant IS_CONCLUDED (err u4))
(define-constant DISTRIBUTE_ERROR (err u5))
(define-constant BET_NOT_FOUND (err u13))
(define-constant STX_TRANSFER_ERROR (err u6))
(define-constant SAME_CONTRACT (err u7))

(define-data-var concluded bool false)
(define-data-var opened bool true)

(define-private (is-allowed)
    (ok (asserts! (contract-call? .corneta-admin is-admin) ONLY_ADMIN))
)

(define-private (distribute-award (pages (list 500 {game: uint, page: uint})))
    (ok (map search-users-to-share pages))
)

(define-private (search-users-to-share (match-info {game: uint, page: uint}))
    (let 
        (
            (game (get game match-info))
            (page (get page match-info))
            (list-users (get list (try! (contract-call? .corneta-user-v2 get-users-at-page game page))))
        )
        (ok (map pay-stx-to-winner list-users))
    )
)

(define-private (pay-stx-to-winner (match-info {game: uint, user: principal}))
    (let
        (
            (game (get game match-info))
            (user (get user match-info))
            (bet (unwrap! (contract-call? .corneta-bet-v2 get-bet game user) BET_NOT_FOUND))
            (free (get free bet))
            (you-got (get you-got bet))
        )
        (if (not free)
            (ok (unwrap! (as-contract (stx-transfer? you-got tx-sender user)) STX_TRANSFER_ERROR))
            (ok true)
        )   
    )
)

(define-public (save-bet (bet {s1: int, s2: int, free: bool}))
    (begin
        (asserts! (var-get opened) IS_CLOSED)
        (asserts! (not (var-get concluded)) IS_CONCLUDED)
        (asserts! (and (>= (get s1 bet) 0) (>= (get s2 bet) 0)) INVALID_SCORE)
        (let        
            (
                (s1 (to-uint (get s1 bet)))
                (s2 (to-uint (get s2 bet)))
                (free (get free bet))                
                (res (contract-call? .corneta-bridge-v2 create-bet MATCH_NUMBER s1 s2 free u0))
            )
            (if (is-err res)
                res
                (if (not free)
                    (ok (unwrap! (stx-transfer? BET_AMOUNT tx-sender (as-contract tx-sender)) STX_TRANSFER_ERROR))
                    (ok true)
                )
            )
        )
    )
)

(define-public (finalize-bet (r1 int) (r2 int))
    (begin
        (try! (is-allowed))
        (asserts! (not (var-get concluded)) IS_CONCLUDED)
        (asserts! (and (>= r1 0) (>= r2 0)) INVALID_SCORE)
        (let
            (
                (pages (unwrap! (get list (contract-call? .corneta-user-v2 get-users-page MATCH_NUMBER)) (err u0)))
                (res (contract-call? .corneta-bridge-v2 close-bet MATCH_NUMBER pages (to-uint r1) (to-uint r2) (stx-get-balance (as-contract tx-sender))))
            )
            (if (is-err res)
                res
                (begin 
                    (unwrap! (distribute-award pages) DISTRIBUTE_ERROR)
                    (ok (var-set concluded true))
                )
            )
        )
    )
)

(define-public (change-status (status bool))
    (begin
        (try! (is-allowed))
        (ok (var-set opened status))
    )
)

(define-public (transfer-amount (contract principal))
    (begin
        (try! (is-allowed))
        (asserts! (not (is-eq (as-contract tx-sender) contract)) SAME_CONTRACT)
        (ok (unwrap! (as-contract (stx-transfer? (stx-get-balance tx-sender) tx-sender contract)) STX_TRANSFER_ERROR))    
    )
)