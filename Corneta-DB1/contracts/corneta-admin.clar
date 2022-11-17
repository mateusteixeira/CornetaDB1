(define-constant OWNER tx-sender)

(define-constant ONLY_ADMIN (err u1))
(define-constant FOUND (err u2))
(define-constant NOT_FOUND (err u3))
(define-constant NOT_ALLOWED (err u4))

(define-map admins
    {admin: principal}
    {enabled: bool}
)

(map-set admins {admin: tx-sender} {enabled: true})

(define-private (get-admin (user principal))
    (map-get? admins {admin: user})
)

(define-private (exists (user principal))
    (is-some (get-admin user))
)

(define-private (create-admin (user principal) (enabled bool))
    (begin
        (asserts! (not (is-eq OWNER user)) NOT_ALLOWED)
        (asserts! (is-admin) ONLY_ADMIN)
        (map-set admins {admin: user} {enabled: enabled})
        (ok true)
    )
)

(define-public (add-admin (user principal))
    (begin
        (asserts! (not (exists user)) FOUND)
        (create-admin user true)
    )
)

(define-public (update-admin (user principal) (enabled bool))
    (begin 
        (asserts! (exists user) NOT_FOUND)
        (create-admin user enabled)
    )
)

(define-public (delete-admin (user principal))
    (begin
        (asserts! (is-admin) ONLY_ADMIN)
        (asserts! (exists user) NOT_FOUND)
        (asserts! (not (is-eq OWNER user)) NOT_ALLOWED)
        (ok (map-delete admins {admin: user}))    
    )
)

(define-read-only (is-admin)
    (default-to false (get enabled (get-admin tx-sender)))
)