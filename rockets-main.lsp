#!/usr/bin/env newlisp

(load "/var/www/newlisp-rockets.lisp") ; this is where the magic happens!

; Rockets - Main Page
; 
; This is the first version of the self-hosted blog for newLISP on Rockets.
; Version 0.01 (Rockets version shown on page)

(display-header)
(display-navbar "newLISP on Rockets" '("About" "Contact"))
(start-div "hero-unit")
	(display-image "rockets.png")
	(displayln "<h2>The newLISP on Rockets Blog</h2>")
	(displayln "<P>Currently running newLISP on Rockets version: " $ROCKETS_VERSION "</p>")
(end-div)

; THIS IS TEMPORARY TAKE OUT AS SOON AS WE HAVE VALIDATION
(define (author-name str-author-id)
	; temporary -- I am the only valid poster for the moment
	(case str-author-id
		("0" "Rocket Man")))+

(open-database "ROCKETS-BLOG2")

;(displayln "Checking for user cookie:" ($COOKIES "rockets-4dckq3-e4jcx-2wgxc")) ; this is the Rockets signin cookie.  Will be in external file or db at some point.
;(displayln "Checking for test cookie: " ($COOKIES "name2"))

; get all existing posts
(set 'posts-query-sql (string "SELECT * from Posts;"))
(set 'posts-result (reverse (query posts-query-sql))) ; reverse it so newest posts first
; print out all posts
(dolist (x posts-result)
	(displayln "<br><a href='rockets-delete.lsp?post=" (x 0) "'>Delete post</a>")
	(displayln "<h4>" (x 3) "</h4>")
	(displayln "<BR><B>Date:</b> " (x 2) "")
	(displayln "<br><B>Author:</b> " (author-name (x 1)) "")
	(displayln "<br><br><p>" (format-for-web (x 4)) "</p>")
	(displayln "<hr>")
)

; print post entry box
(display-post-box "Post something..." "postsomething" "rockets-post.lsp" "subjectline" "replybox" "Post Message")

; table structure:  ((0 "Id" "INTEGER" 0 nil 1) (1 "PosterId" "TEXT" 0 nil 0) (2 "PostDate" "DATE" 0 nil 0) (3 "PostSubject" "TEXT" 0 nil 0) (4 "PostContent" "TEXT" 0 nil 0))

(close-database)
(display-footer "Ingenium Technologies")
(display-page) ; this is needed to actually display the page!
(exit)
