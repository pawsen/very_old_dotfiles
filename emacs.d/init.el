;(setq debug-on-error t)

;; system type. Se http://www.gnu.org/s/emacs/manual/html_node/elisp/System-Environment.html
(defun macosx-p ()
  (interactive)
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin"))

(defun linux-p ()
  (interactive)
  "Return true if system is GNU/Linux-based"
  (string-equal system-type "gnu/linux"))

(defun windows-p ()
  (interactive)
  (string-equal system-type "windows-nt"))
;;(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/themes/")


(when (and (window-system)
           (>= emacs-major-version 24))
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
  )

;{{{ Look & Feel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load theme as the first thing, so all subprograms inherit the settings

(add-to-list 'load-path "~/.emacs.d/themes/color-theme-6.6.1")

(require 'color-theme)
(setq color-theme-load-all-themes nil)
;; contains loads of themes. Since i'm not using any of them, i dont need to load the entire  library
;;(color-theme-initialize) ;; this loads all themes

;; http://blog.nozav.org/post/2010/07/12/Updated-tangotango-emacs-color-theme
(require 'color-theme-tangotango)


;; Seperate color themes for tty(console) and frame
;; http://emacs-fu.blogspot.com/2009/03/color-theming.html
(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defun run-after-make-frame-hooks (frame)
  "Selectively run either `after-make-console-frame-hooks' or
`after-make-window-system-frame-hooks'"
  (select-frame frame)
  (run-hooks (if window-system
                 'after-make-window-system-frame-hooks
               'after-make-console-frame-hooks)))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)
(add-hook 'after-init-hook
          (lambda ()
            (run-after-make-frame-hooks (selected-frame))))

; initialize color themes for tty and frame
(set-variable 'color-theme-is-global nil)
(setq color-theme-is-cumulative nil) ; New theme should not contain remnants of a theme loaded earlier
(add-hook 'after-make-window-system-frame-hooks 'color-theme-tangotango)
;;(add-hook 'after-make-window-system-frame-hooks 'color-theme-zenburn)
(add-hook 'after-make-console-frame-hooks 'color-theme-tangotango)

;; On emacs 24, zenburn is loaded with
;;(load-theme 'zenburn)
;; kommer med en fejl i beta-udgave af emacs. Vi loader filen i stedet
;;(load-file "~/.emacs.d/themes/zenburn-theme.el")
;;(load-file "~/.emacs.d/themes/solarized-dark-theme.el")

;;(color-theme-tangotango)
;;(load-file "~/.emacs.d/themes/color-theme-solarized.el")
;;(color-theme-solarized-light)

;; Font family
;(set-default-font "DejaVu Sans Mono")
;; Font size 
;(set-face-attribute 'default nil :height 100) ; 100 er pkt 10

(require 'gui-init) ; load gui settings. Is placed in the beginning. If not emacs --daemon wont load the settings

;; Colorize #5f7f5f hex-numbers. Fra nxhtml-pakken
;; https://github.com/emacsmirror/nxhtml/blob/master/util/css-color.el
(require 'css-color)
(add-hook 'emacs-lisp-mode-hook 'css-color-mode)
(add-hook 'org-mode-hook 'css-color-mode)
(add-hook 'LaTex-mode-hook 'css-color-mode)

; tilføj mappe + undermapper til load-list
;http://stackoverflow.com/questions/221365/emacs-lisp-how-to-add-a-folder-and-all-its-first-level-sub-folders-to-the-load-p
;(let ((base "~/.emacs.d/elpa"))
;  (add-to-list 'load-path base)
;  (dolist (f (directory-files base))
;    (let ((name (concat base "/" f)))
;      (when (and (file-directory-p name) 
;                 (not (equal f ".."))
;                 (not (equal f ".")))
;        (add-to-list 'load-path name)))))

;; fx,  Load stuff for GNU/Linux systems only
;;(if (linux-p)
;;  (setq load-path (append load-path (list "~/emacs/lisp/linux")))
;;  (load-library "my-custom-linux"))

; Fix rettighedsproblem når server startes. Kun for windows. Se
;http://brain-break.blogspot.cm/2009/08/when-moving-from-gnu-emacs-22.html og
;http://stackoverflow.com/questions/885793/emacs-error-when-calling-server-start
(require 'server)
(when (and (= emacs-major-version 23) (= emacs-minor-version 1) (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)  ; Suppress error directory ~/.emacs.d/server is unsafe on windows.
  ;; server-start unless it is already running somewhere  
  (unless (= 0 (call-process "emacsclient" nil nil nil "--eval" "nil" "-a" "false"))  
    (server-start))
)

; Package manegement system. M-x package-list-package : mark with 'i', install with 'x'
(require 'package)
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("SC"  . "http://joseito.republika.pl/sunrise-commander/")
			 ))
; nedenstående indlæser pakker.
(package-initialize)

;;; auto-complete
;se http://cx4a.org/software/auto-complete/
; skal loades før LaTex
(require 'auto-complete-config)
(ac-config-default)
(ac-flyspell-workaround);for at få ac til at virke med flyspell, http://www.emacswiki.org/emacs/AutoComplete#toc6

;; smart redo/unde. Brug C-x u for undo-tree
(require 'undo-tree)
(global-undo-tree-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add newline when end-of-file is reached when using down-arrow
(setq next-line-add-newlines t)


;; edit with chrome
(when (linux-p)
  (if (and (daemonp) (locate-library "edit-server"))
      (progn
	(require 'edit-server)
	(edit-server-start)))
  )

;; emacs-nav
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-nav/")
(require 'nav)

;; w3m
(add-to-list 'load-path "~/.emacs.d/lisp/w3m")
(require 'w3m-load)
(setq w3m-use-cookies t) ;; use cookies


;; yasnippet. Notice there is a bundle version(simpler) and the regular version(this).
(require 'yasnippet)

;; turned off, because itøs useless in fortran
;; (yas/initialize)
;; ;; snippets are placed two places. load-directory is for the snippets that ships with yasnippet. root-directory is for your owm snippets. See
;; ;; http://capitaomorte.github.com/yasnippet/snippet-organization.html
;; (yas/load-directory "~/.emacs.d/elpa/yasnippet-0.6.1/snippets")
;; (setq yas/root-directory "~/.emacs.d/mysnippets")
;; ;; Load the snippets
;; (yas/load-directory yas/root-directory)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido
(ido-mode 1)
;(ido-mode 'both) ;; for buffers and files
(setq ido-create-new-buffer 'always)  ;; dont ask wether to create new buffer, just do it.
(setq
    ido-file-extensions-order '(".tex" ".org")
    ido-ignore-buffers ;; ignore these guys
    '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
      "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
    ido-use-filename-at-point nil         ; don't use filename at point (annoying)
    ido-use-url-at-point nil              ; don't use url at point (annoying)
    ido-enable-last-directory-history nil ; forget latest selected directory names
    ido-enable-flex-matching t            ; fuzzy maching - Smart. turn off by 'nil'
; Flex or fuzzy matching is the ability to match any item containing the characters in the given sequence. For example, "mwc" might match a file named "my_wicked_class.rb"
    ido-max-prospects 6                   ; don't spam my minibuffer
    ido-confirm-unique-completion t       ; wait for RET, even with unique completion
;;    ido-everywhere t                      ; ???
    ido-create-new-buffer 'always         ; virker måske ikke. dont ask wether to create new buffer, just do it.
    confirm-nonexistent-file-or-buffer nil); same as above, but works

;; Virker pt ikke
;;(require 'ido-ubiquitous)
;;(ido-ubiquitous 1)

;; Give balanced delimiters(parentes) different colors
;; http://emacs-fu.blogspot.com/2011/05/toward-balanced-and-colorful-delimiters.html
(when (require 'rainbow-delimiters nil 'noerror) 
  (global-rainbow-delimiters-mode) ;; use emacs wide
  ;; (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
  ;; (add-hook 'LaTex-mode-hook 'rainbow-delimiters-mode)
  ;; (add-hook 'f90-mode-hook 'rainbow-delimiters-mode)
  )

;; EasyPG, Encryption
(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys nil ; If non-nil, always asks user to select recipients.
      epa-file-encrypt-to "pawsen@gmail.com" ; *Recipient(s) used for encrypting files.
      )


;; buffer-extension.
;; funktioner: kill-current-mode-buffers, copy-buffer-file-name-as-kill (giver full path til fil)
;; (require 'buffer-extension)

;; ack
;; Som grep men måske smartere. Virker ikke pt. Skal bruge nyere udgave af ack...el filen
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autopair- dvs luk (),{}, http://code.google.com/p/autopair/
(require 'autopair)
(autopair-global-mode t)
(setq autopair-autowrap t)
(message "hi2")


; vis hvilke parenteser der passer sammen, men ikke hoppe.
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)
(setq show-paren-ring-bell-on-mismatch t)

(global-visual-line-mode 1) ; 1 for on, 0 for off.
(global-auto-revert-mode t) ; Opdag automatisk at filer ændres uden for emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; browse-kill-ring
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))

;; indent pasted text. Useful! 
; http://emacs.wordpress.com/2007/01/22/killing-yanking-and-copying-lines/
(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode scheme-mode lisp-mode
                                           c-mode c++-mode objc-mode
                                           LaTeX-mode TeX-mode f90-mode))
      (indent-region (region-beginning) (region-end) )))

;; Use M-w copy line, C-w kill line
;; (put 'kill-ring-save 'interactive-form
;;      '(interactive
;;        (if (use-region-p)
;;            (list (region-beginning) (region-end))
;;          (list (line-beginning-position) (line-beginning-position 2)))))
;; (put 'kill-region 'interactive-form      
;;      '(interactive
;;        (if (use-region-p)
;;            (list (region-beginning) (region-end))
;;          (list (line-beginning-position) (line-beginning-position 2)))))

;; List-register. Used with 'C-x r v', as defined in bindings
(require 'list-register)

;;  Turn only cua on for rectangles(Mark a rectangle). Use: C-ret
(setq cua-enable-cua-keys nil) 
(cua-mode t)

;; uniquify. Make buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TABBAR
;; Mere info på http://www.emacswiki.org/emacs/TabBarMode

(require 'tabbar)
(autoload 'tabbar-mode "tabbar" "Show tab bars." t)
(tabbar-mode t) ;; turn tabbar on
(require 'tabbar-ruler)

;; when closing a tab, show the last opened buffer, instead of the neighboring tab.
                                        ; (remove-hook 'kill-buffer-hook 'tabbar-buffer-track-killed)
'(tabbar-default-face ((t (:inherit variable-pitch :background "gray72" :foreground "blue" :height 0.8))))
'(tabbar-selected-face ((t (:inherit tabbar-default-face :background "bisque" :foreground "blue" :box (:line-width 2 :color "white" :style released-button)))))
'(tabbar-cycle-scope (quote tabs))
'(tabbar-mode t nil (tabbar))


;; make all buffers show as tabs
;;(setq tabbar-buffer-groups-function (lambda (buffer) (list "All buffers")))

;; Define your own rule for grouping tabs. Se also ~line 1668 in tabber.el
(defun my-tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
 This function is a custom function for tabbar-mode's tabbar-buffer-groups.
 This function group all buffers into 3 groups:
 Those Dired, those user buffer, and those emacs buffer.
 Emacs buffer are those starting with "*"."
 (list
  (cond
   ((string-equal "*" (substring (buffer-name) 0 1))
    "Emacs Buffer")
   ((eq major-mode 'dired-mode)
    "Dired" )
   (t
    "User Buffer")
   )))
;;(setq tabbar-buffer-groups-function (quote my-tabbar-buffer-groups))
(setq tabbar-buffer-groups-function (quote tabbar-buffer-groups)); grups by major mode. Nessesary when using tabbar-ruler.


;;;;;;;;;;;;;;;
;; Babel

;; (autoload 'babel "babel"
;;   "Use a web translation service to translate the message MSG." t)
;;    (autoload 'babel-region "babel"
;;      "Use a web translation service to translate the current region." t)
;;    (autoload 'babel-as-string "babel"
;;      "Use a web translation service to translate MSG, returning a string." t)
;;    (autoload 'babel-buffer "babel"
;;      "Use a web translation service to translate the current buffer." t)

;; (define-minor-mode babel-permanent-translation-mode "Bable translate notext")

;; (define-key mode-specific-map [?o] (lambda()(interactive)(if (babel-permanent-translation-mode) (add-hook 'post-command-hook 'rgr/context-babel nil t)(remove-hook 'post-command-hook 'rgr/context-babel))))
;; (setq babel-echo-area t)

;; (setq babel-echo-area t)
;; (setq babel-preferred-from-language "Danish")
;; (setq babel-preferred-to-language "English")

;;;;;;;;;;;;;;;;;;;;
;; ssh-config mode. Jeg ved ikke præcis hvad godt den gør.
(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

;(delete-selection-mode t) ;; delete selected text - flyttet til bunden af init-filen
(setq default-major-mode 'text-mode)
(mouse-wheel-mode t)               ;; mouse scrolling
(fset 'yes-or-no-p 'y-or-n-p)      ;; Don't make me type out long answers...
(global-hl-line-mode 1)            ;; highlight current line
(blink-cursor-mode 0)              ;; Ingen blinkende curser
(setq compile-command "make")
;(setq initial-scratch-message nil)


;;;; activate mouse in terminal
;; (unless window-system
;;   (require 'mouse)
;;   (xterm-mouse-mode t)
;;   (defun track-mouse (e))
;;   (setq mouse-sel-mode t)
;;   (global-set-key [mouse-4] '(lambda ()
;;                                (interactive)
;;                                (scroll-down 1)))
;;   (global-set-key [mouse-5] '(lambda ()
;;                                (interactive)
;;                                (scroll-up 1))))

(setq visible-bell t
;      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      font-lock-verbose nil
      inhibit-startup-message t
      transient-mark-mode t
      delete-by-moving-to-trash nil ;; destroy the bahavier of socket if t. Se
;;http://superuser.com/questions/176207/emacs-daemon-not-deleting-socket
;;http://superuser.com/questions/194395/why-does-tmp-emacsuid-server-get-stale-after-last-emacsclient-exits
      shift-select-mode t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 100
      ediff-window-setup-function 'ediff-setup-windows-plain
      kill-whole-line t ; Killing line also deletes \n
      save-place-file "~/.emacs.d/saveplace"
)
;; remember position in file, so it start at the same position. Only works on linux
(when (linux-p)
  (setq-default save-place t) ;; activate it for all buffers
  (require 'saveplace)        ;; get the package
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Linjenummerering
(global-linum-mode 1) ; altid linjenumre

;;Vis linie og kolonne numre nederst
(line-number-mode 1)
(column-number-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (windows-p)
  (setq browse-url-browser-function 'browse-url-chrome)) ;; Default Web Browser
(when (linux-p)
  (setq browse-url-browser-function 'browse-url-generic
	browse-url-generic-program "chromium"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recent file menu
(require 'recentf) ;; recent file-menu
(recentf-mode 1)
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 100)

;;For C og HTML filer skal filerne viser med smart farvning
(setq c-mode-hook 'font-lock-mode)
(setq html-mode-hook 'font-lock-mode)

;;Filer der ender op .c og .h er c-filer og .html er HTML-filer
(setq auto-mode-alist
      (append '(("\\.c$"  . c-mode)
		("\\.h$"  . c-mode)
		("\\.html$" . html-mode)
		("README" . text-mode) 
		("\\.pde$" . c++-mode)
		("\\.geo$"  . c++-mode)
		) auto-mode-alist))

;{{{ Lua mode
;    - http://lua-mode.luaforge.net/
(autoload 'lua-mode "lua-mode" "Major-mode for editing lua scripts." t)
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
;}}}

;(defun my-make-directory-yes-or-no (dir)
;  "Ask user to create the DIR, if it does not already exist."
;  (if dir
;      (if (not (file-directory-p dir))
;          (if (yes-or-no-p (concat "The directory `" dir
;                                   "' does not exist currently. Create it? "))
;              (make-directory dir t)
;            (error
;             (concat "Cannot continue without directory `" dir "'"))))
;    (error "my-make-directory-yes-or-no: missing operand")))

(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'magit-status "magit" nil t)
;; (require 'magit)

;; Hippie expand. Auto-complete word
(setq hippie-expand-try-functions-list '(try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-list try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; stavekontrol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (windows-p)
    ;; Anvend aspell til stavekontrol (Windows) - correct the path in order to point to your aspell location
  (setq-default ispell-program-name 
		"c:\\Program Files (x86)\\Aspell\\bin\\aspell.exe" ; hjemmemaskine
					;"x:\\emacs\\config\\Aspell\\bin\\aspell.exe" ; DTU-maskine
		ispell-dictionary "dansk")
  )


(when (linux-p)
  (setq-default ispell-program-name "hunspell") ;;"aspell"

  (require 'rw-language-and-country-codes) 
  (require 'rw-ispell)
  (require 'rw-hunspell)
  ;(rw-hunspell-setup)

  (eval-after-load "ispell"
    (progn
      (setq-default  
       ispell-extra-args '("-a" "-i" "utf-8") ; aspell doesn't understand -i utf-8, hunspell needs it
       ispell-silently-savep t ;; Don't nag about saving the personal dictionary every time we add a new word with ispell
       ispell-dictionary "en_GB_hunspell" ;; "da_DK_hunspell";  "da")
       ispell-personal-dictionary (expand-file-name "~/.emacs.d/.hunspell_en_US")
       rw-hunspell-dicpath-list (quote ("/usr/share/hunspell")) 
       rw-hunspell-make-dictionary-menu t 
       rw-hunspell-use-rw-ispell t 
       )
      ;; Use a symbol when a word is mispelled. Ugly symbol.
      ;;(require 'flyspell_extra)
      ;;(load-file "~/.emacs.d/lisp/flyspell_extra.el")
      ))
  (setq ispell-really-hunspell t)

  ;; Bemærk at emacs ikke har en selvstænding aspell variabel. Derfor bruges ispell
  ;; Always start a new ispell process for flyspell checking; to not do so is unbearably slow with aspell on Windows.

  ;; Navnet på den personlige ordbog skal være kendt af hunspell. Ellers bliver ordene ikke genmt. se http://stackoverflow.com/questions/7653754/emacs-on-win32-with-hunspell-personal-dictionary-does-not-get-saved/
  (setq ispell-personal-dictionary
        (expand-file-name "~/.emacs.d/.hunspell_en_US"))
  (setq flyspell-large-region 0)

  ;; start latex for the following modes
  ;;(dolist (hook '(text-mode-hook) '(LaTex-mode-hook))
  ;;  (add-hook hook (lambda () (flyspell-mode 1))))

  ;;use flyspell-prog-mode to enable spell checking only within comments of source code.
  ;; (add-hook 'c++-mode-hook
  ;;         (lambda ()
  ;;           (flyspell-prog-mode)
  ;;         ))
  ;; (add-hook 'f90-mode-hook
  ;;         (lambda ()
  ;;           (flyspell-prog-mode)
  ;;         ))

  )
  (setq ispell-personal-dictionary
        (expand-file-name "~/.emacs.d/.hunspell_en_US"))



;; highligt all occurences of a word. 
(require 'highlight-symbol)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ELDOC
;; eldoc provides documentation for Elisp files
;;Turn on documentation in elisp mode
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; c-eldoc displays the arguments of C functions while one is programming.
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; ***************************************************************
;; isearch is a useful navigation mechanism. This works a little
;; better if isearch puts you at the start of the search, not the end:
;; ***************************************************************
;; DISABLET fordi det ødelægger brugen af M-n M-p

;; (add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
;; (defun my-goto-match-beginning ()
;;   (when isearch-forward (goto-char isearch-other-end)))

;; (defadvice isearch-exit (after my-goto-match-beginning activate)
;;   "Go to beginning of match."
;;   (when isearch-forward (goto-char isearch-other-end)))

;;     (defun my-goto-match-beginning ()
;;       (when (and isearch-forward (not isearch-mode-end-hook-quit))
;;         (goto-char isearch-other-end)))

;; Gives a more smooth scolling in windows.
;; http://stackoverflow.com/questions/3631220/fix-to-get-smooth-scrolling-in-emacs
(when (windows-p)
 (setq redisplay-dont-pause t
       scroll-margin 1
       scroll-step 1
       scroll-conservatively 10000
       scroll-preserve-screen-position 1)
 )

;; for debugging
(add-hook 'gdb-mode-hook
          (lambda ()
            (setq gdb-many-windows 't)
            (define-key gud-mode-map [C-H-f8] 'gdb-many-windows)

	    ; These are local binding. I have set them as global instead in bindings.el
	    ;; (define-key gud-mode-map [f5] 'gud-step) ; go into function
	    ;; (define-key gud-mode-map [C-f] 'gud-up) ; stack up/down
	    ;; (define-key gud-mode-map [S-f5] 'gud-down)
	    ;; (define-key gud-mode-map [f6] 'gud-next) ; step over
	    ;; (define-key gud-mode-map [H-f6] 'gud-stepi)
	    ;; (define-key gud-mode-map [C-f6] 'gud-jump)
	    ;; (define-key gud-mode-map [f7] 'gud-until) ; run until next break-point
	    ;; (define-key gud-mode-map [C-f7] 'gud-finish) ; finish and return from
	    subfunction
            ;;(setq gdb-use-separate-io-buffer 't)
            (tool-bar-mode 't)
            ))

 (setq preferred-debugger-alist
       '((c-mode . gdb)
         (c++-mode . gdb)
))
;;         (cperl-mode . perldb)
;;         (python-mode . pdb)
;;         (jde-mode . jdb)
;;         ))

;; Change backup behavior to save in a specified directory
(setq backup-directory-alist '(("." . "~/.emacs.d/saves/"))
 backup-by-copying      t
 version-control        t
 delete-old-versions    t
 kept-new-versions      10
 kept-old-versions      5
)

(setq shift-select-mode nil) ; select text with shift-arrow.
(delete-selection-mode t) ;; delete selected text - added again to enasure that emacs realle does it.



;; ;; pdee, PYTHON
;; (add-to-list 'load-path "~/.emacs.d/lisp/pdee/")
;; (defvar pdee-install-dir "~/.emacs.d/lisp/pdee/")
;; (setq pdee-load-all nil)
;; (require 'pdee-init)   ;; Set up pdeE Load Paths
;; (require 'pdee-python) ;; If you want the python facilities [optional]

;; GABI, python
;; (add-to-list 'load-path "~/.emacs.d/lisp/emacs-for-python/")
;; (require 'epy-setup)   ;; Set up pdeE Load Paths
;; (require 'epy-python) ;; If you want the python facilities [optional]
;; (epy-setup-checker "pyflakes %f")
;;(require 'highlight-indentation)
;;(add-hook 'python-mode-hook 'highlight-indentation)

(when (linux-p)
  (when (executable-find "dictd")
    ;; dictem
    (add-to-list 'load-path "~/.emacs.d/lisp/dictem-1.0.2/")
    (load "~/.emacs.d/my_dictim.el")
    ))

(load-file "~/.emacs.d/lisp/smart-scan.el")
(load-file "~/.emacs.d/my_eshell.el")
(load-file "~/.emacs.d/my_defun.el")
(load-file "~/.emacs.d/my_compile.el")
(load-file "~/.emacs.d/my_bindings.el")
(load-file "~/.emacs.d/my_latex.el")
(load-file "~/.emacs.d/my_c.el")
;;(load-file "~/.emacs.d/my_cedet.el")

;;set up unicode - utf8. Has to come last for some reason
;; http://www.factsandpeople.com/facts-mainmenu-5/2-editor-emacs/114-other-coding-systems-with-emacs
;;(when (linux-p)
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8) ;; might destry c/p on windows
;;  (set-language-environment "UTF-8")
;;  )

(when (windows-p)
  ;; restore correct pasting text from emacs (tested on Windows XP):
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; The next line is only needed for the MS-Windows clipboard
  (set-clipboard-coding-system 'utf-16le-dos)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(LaTeX-float "htb")
 '(custom-safe-themes (quote ("1440d751f5ef51f9245f8910113daee99848e2c0" "485737acc3bedc0318a567f1c0f5e7ed2dfde3fb" default)))
 '(ede-project-directories (quote ("/home/paw/documents/Dropbox/Storskala/Granular/simple_sphere"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

