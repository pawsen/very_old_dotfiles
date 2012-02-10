;; ubuntu packages needed
;; dict - client installed by default
;; dictd - server
;; dict-wn - Wordnet dictinory
;; any other dicts you want

(when (executable-find "dictd")            ; check dictd is available
  (require 'dictem))


(setq dictem-server "localhost")

(setq dictem-use-user-databases-only t)

(setq dictem-port   "2628")
(dictem-initialize)

(setq dictem-default-strategy "word")

;; For creating hyperlinks on database names
;; and found matches.
(add-hook 'dictem-postprocess-match-hook
          'dictem-postprocess-match)

;; For highlighting wwwthe separator between the definitions found.
;; This also creates hyperlink on database names.
(add-hook 'dictem-postprocess-definition-hook
          'dictem-postprocess-definition-separator)

;; For creating hyperlinks in dictem buffer
;; that contains definitions.
(add-hook 'dictem-postprocess-definition-hook
          'dictem-postprocess-definition-hyperlinks)

;; For creating hyperlinks in dictem buffer
;; that contains information about a database.
(add-hook 'dictem-postprocess-show-info-hook
          'dictem-postprocess-definition-hyperlinks)

(define-key dictem-mode-map [tab] 'dictem-next-link)
(define-key dictem-mode-map [(backtab)] 'dictem-previous-link)
(define-key dictem-mode-map [return] 'dictem-run-search)

(setq dictem-user-databases-alist
      '(("_en-en"  . ("wn" "gcide" "foldoc"))
      ("wn"  . ("wn"))
))

;;; http://paste.lisp.org/display/89086
(defun dictem-run-define-at-point-with-query ()
  "Query the default dict server with the word read in within this function."
  (interactive)
  (let* ((default-word (thing-at-point 'symbol))
         (default-prompt (concat "Lookup Word "
                                 (if default-word
                                     (concat "(" default-word ")") nil)
                                 ": "))
         (dictem-query
          (funcall #'(lambda (str)
                       "Remove Whitespace from beginning and end of a string."
                       (replace-regexp-in-string "^[ \n\t]*\\(.*?\\)[ \n\t]*$"
                                                 "\\1"
                                                 str))
                   (read-string default-prompt nil nil default-word))))
    (if (= (length dictem-query) 0) nil
      (dictem-run 'dictem-base-search "*" dictem-query "."))))

(defun dictem-run-define-at-point ()
emacs gnus
  "dictem look up for thing at point"
  (interactive)
  (let* ((default-word (thing-at-point 'symbol))
         (dictem-query
          (funcall #'(lambda (str)
                       "Remove Whitespace from beginning and end of a string."
                       (replace-regexp-in-string "^[ \n\t]*\\(.*?\\)[ \n\t]*$"
                                                 "\\1"
                                                 str))
                   default-word)))
    (if (= (length dictem-query) 0) nil
      (dictem-run 'dictem-base-search "*" dictem-query "."))))

;; (global-set-key "\C-ca" 'dictem-run-define-at-point)
;; (global-set-key "\C-cA" 'dictem-run-define-at-point-with-query)

;; (global-set-key "\C-cs" 'dictem-run-search)
;; (global-set-key "\C-cm" 'dictem-run-match)

(provide 'dictim-init)
;; (global-set-key "\C-cd" 'dictem-run-define)

