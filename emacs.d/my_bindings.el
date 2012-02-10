; For forskellige modifier-keys, se
; http://www.gnu.org/s/libtool/manual/emacs/Modifier-Keys.html

(global-set-key "\M-g" 'goto-line) ;;Meta-g for goto linie nummer

; istedet for den indbyggede undo-funktion, bruges undo-tree. Se flere genveje i undo-tree.el
;(global-set-key (kbd "C-z") 'undo)
(when window-system (global-unset-key "\C-z")) ;; fjern standard bindingen.
(define-key undo-tree-map (kbd "C-z") 'undo-tree-undo)
(define-key undo-tree-map (kbd "C-S-z") 'undo-tree-redo)
;; (global-set-key (kbd "C-c q") 'auto-fill-mode) ;; autofill er "linewrap når linjen bliver for lang. se http://www.emacswiki.org/emacs/AutoFillMode

;; kill-ring menu
(global-set-key "\C-cy" '(lambda ()
			   (interactive)
			   (popup-menu 'yank-menu)))

;; M-q er optaget
;;(global-set-key "\M-q" 'backward-kill-word)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-z") 'ido-imenu)
;; Use ido for searching TAGS
;;(global-set-key [remap find-tag] 'ido-find-tag)
;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)

;; Open tags in another buffer
(global-set-key (kbd "M-:") 'my-goto-tag-other-window)

;; Go forward/backward to next occurence of a word
(global-set-key (kbd "M-n") 'smart-symbol-go-forward)
(global-set-key (kbd "M-p") 'smart-symbol-go-backward)

;; Remap M-/ til "shift"-tab
(global-set-key (kbd "<backtab>") 'hippie-expand);; 'dabbrev-expand)

;; Get a list of occurences of a word in a buffer
;; Normal binding(when searching) M-s o
(define-key isearch-mode-map (kbd "M-o") 'isearch-occur)
;; Find occurence of word in all open buffers, that shares major mode
;; This binding is removed. The funtion is still in my_defun

;; Save the search string and quit isearch
;; (define-key isearch-mode-map (kbd "M-w") 'isearch-save-and-exit)

;; New-line commands
;; Overwrite default behavior of C-j. The defualt behavier is very similar to the new behavior
(global-set-key (kbd "C-j") 'open-next-line)
(global-set-key (kbd "M-j") 'open-previous-line)

;; tabbar
(global-set-key (kbd "M-<up>") 'tabbar-backward-group)
(global-set-key (kbd "M-<down>") 'tabbar-forward-group)
(global-set-key (kbd "M-<left>") 'tabbar-backward)
(global-set-key (kbd "M-<right>") 'tabbar-forward)

(winner-mode 1); Remember the previous window configurations and jump back to them as needed
(global-set-key (kbd "C-c <up>") 'winner-undo)
(global-set-key (kbd "C-c <down>") 'winner-redo)

(global-set-key (kbd "C-c m") 'rotate-windows) ;; eq swap place

;; Function keys
(global-set-key [f1] 'jao-selective-display);; sort of code-folding. USEFUL!!
(global-set-key [H-f1] 'recentf-open-files)
(global-set-key [(meta f1)] 'recentf-interactive-complete) ;; use ido to search recently opened files
(global-set-key [S-f1] 'nav) ;; navigator
;(global-set-key [C-f2] 'grep)
(global-set-key [C-f2] 'dired)
;;(global-set-key '[f3]          'call-last-kbd-macro)
(global-set-key '[H-f3]    'toggle-kbd-macro-recording-on)

;; udkommenteret fordi jeg aldrig bruger dem
;(global-set-key [f4] 'query-replace)
;(global-set-key (kbd "C-<f5>") 'linum-mode);; C-f5 slår linjenummerering fra/til


;(global-set-key [f6] 'kill-other-buffers)    
;(global-set-key [f7] 'word-count-mode)
;; (global-set-key [f9] 'sumatra-jump-to-line) ; lav til local i tex-mode

;; easy spell check
(global-set-key (kbd "<f10>") 'ispell-word)
(global-set-key (kbd "C-S-<f10>") 'flyspell-mode)
(global-set-key (kbd "S-<f10>") 'flyspell-buffer)
(global-set-key (kbd "C-<f10>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f10>") 'flyspell-check-next-highlighted-word)
(global-set-key [H-f10]  'ispell-change-dictionary)

(global-set-key (kbd "C-<f12>") 'tool-bar-mode) ;; Turn off the menu bar
(global-set-key [f12] 'kill-buffer)
(global-set-key [C-tab] "\C-q\t"); insert tab
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil); brug 

(global-set-key [C-f8] 'my-compile-clean-func)
(global-set-key [S-f8] 'my-compile-upload-func) ;; til ardiono
(if (windows-p)
    (global-set-key [f8] 'sumatra-jump-to-line)
  (global-set-key [f8] 'my-compile-func)
  )
(global-set-key [H-f8] 'humble-gud) ;; start debugging
(global-set-key [C-S-f8] 'compile)
;; (global-set-key [S-f7] 'my-compile-package-func)
(global-set-key [f9] 'next-error)
(global-set-key [C-f9] 'previous-error)

(global-set-key [f5] 'gud-step) ; go into function
(global-set-key [C-f] 'gud-up) ; stack up/down
(global-set-key [S-f5] 'gud-down)
(global-set-key [f6] 'gud-next) ; step over
(global-set-key [H-f6] 'gud-stepi)
(global-set-key [C-f6] 'gud-jump)
(global-set-key [f7] 'gud-until) ; run until next break-point
(global-set-key [C-f7] 'gud-finish) ; finish and return from 

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key [f8] 'sumatra-jump-to-line)
))

; de følgende to funktioner findes i my-defun.el
(global-set-key [f11] 'quick-copy-line) ;kopierer hele linjen og flytter curser ned
(global-set-key (kbd "C-c d") 'avi-kill-line-save);; som kill-line, bare med kopier istedet;  C-3 C-d kopierer fx de næste tre linjer. Dvs C-# giver prefix
;; ovenstående ændre også <del>. For at sætte <del> tilbage til delete, køres nedenstående.
(global-unset-key [delete] )
(global-set-key [delete] 'delete-char)
;;(global-set-key [M-delete] 'kill-word) C-backspace does the same

(global-set-key [H-f11]
                (lambda () (interactive)
                  (switch-to-buffer-other-window nil)
                  (other-window -1)))
(global-set-key [S-f11]
                (lambda () (interactive) (switch-to-buffer nil)))
(global-set-key [C-f11] 'other-window)
(global-set-key [C-S-f11] (lambda () (interactive)
                                (other-window -1)))


(global-set-key "\C-x\C-u" 'shell); Open shell
(global-set-key (kbd "C-x m") 'eshell);open active eshell
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t))) ; start new eshell, even if one is active

;; Change default behavior of "pil-op/ned" in eshell. Normally up/down repeat an old command, but now it moves the curser around in the buffer
(defun m-eshell-hook ()
  ;; define control p, control n and the up/down arrow
  (define-key eshell-mode-map [(control p)] 'eshell-previous-matching-input-from-input)
  (define-key eshell-mode-map [(control n)] 'eshell-next-matching-input-from-input)
  
  (define-key eshell-mode-map [up] 'previous-line)
  (define-key eshell-mode-map [down] 'next-line)
  )
(add-hook 'eshell-mode-hook 'm-eshell-hook)

;; smex is a replecement for M-x, which uses ido
(require 'smex)
(smex-initialize)  
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex) ;; supersedes binding in starter-kit-bindings.org
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-x C-M") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(setq smex-show-unbound-commands t)
(smex-auto-update 30)

(global-set-key (kbd "C-c g") 'magit-status)

(global-set-key (kbd "C-x r v") 'list-register)
(global-set-key (kbd "C-c w") 'browse-url)  ;; Open link in browser. Cool
(global-set-key (kbd "C-c e") 'fc-eval-and-replace) ; repalce and evaluate lisp expression
(global-set-key (kbd "C-x C-r") 'toggle-sudo-edit) ; reopen current file as root

; (global-set-key [f9] 
;; 		(lambda()(interactive)
;; 		  (ispell-change-dictionary "en_US")
;; 		  (flyspell-buffer))) 

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;;Highligt the word where the pointer is
(global-set-key (kbd "C-c p") 'highlight-symbol-at-point)
;;(global-set-key (kbd "<f11>") 'highlight-symbol-next) ;; disse minder meget om M-n M-p
;;(global-set-key (kbd "<f12>") 'highlight-symbol-prev)

;; Window manipulation
(global-set-key [(control kp-6)] 'enlarge-window-horizontally)
(global-set-key [(control kp-4)] 'shrink-window-horizontally)
(global-set-key [(control kp-8)] 'enlarge-window)
(global-set-key [(control kp-2)] 'shrink-window)
;; Window manipulation
(global-set-key [(control kp-left)] 'enlarge-window-horizontally)
(global-set-key [(control kp-right)] 'shrink-window-horizontally)
(global-set-key [(control kp-up)] 'enlarge-window)
(global-set-key [(control kp-down)] 'shrink-window)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Map the window manipulation keys to meta 0, 1, 2, o
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-o") 'other-window) ; was facemenu-keymap

;; To help Unlearn C-x 0, 1, 2, o
(global-unset-key (kbd "C-x 3")) ; was split-window-horizontally
(global-unset-key (kbd "C-x 2")) ; was split-window-vertically
(global-unset-key (kbd "C-x 1")) ; was delete-other-windows
(global-unset-key (kbd "C-x 0")) ; was delete-window
(global-unset-key (kbd "C-x o")) ; was other-window


;(provide 'bindings)
