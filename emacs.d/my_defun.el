;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; søg efter definitioner i en fil med C-x C-z
(require 'imenu)
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
                              
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
                              
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
                             
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

;; Brug ido til søgning i TAGS

(defun ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapc (lambda (x)
	    (unless (integerp x)
	      (push (prin1-to-string x t) tag-names)))
	  tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-[f1] søg efter nyligt åbede filer
(defun recentf-interactive-complete ()
  "find a file in the recently open file using ido for completion"
  (interactive)
  (let* ((all-files recentf-list)
	 (file-assoc-list (mapcar (lambda (x) (cons (file-name-nondirectory x) x)) all-files))
	 (filename-list (remove-duplicates (mapcar 'car file-assoc-list) :test 'string=))
	 (ido-make-buffer-list-hook
	  (lambda ()
	    (setq ido-temp-list filename-list)))
	 (filename (ido-read-buffer "Find Recent File: "))
	 (result-list (delq nil (mapcar (lambda (x) (if (string= (car x) filename) (cdr x))) file-assoc-list)))
	 (result-length (length result-list)))
         (find-file 
	  (cond 
	   ((= result-length 0) filename)
	   ((= result-length 1) (car result-list))
	   ( t
	     (let ( (ido-make-buffer-list-hook
		     (lambda ()
		       (setq ido-temp-list result-list))))
	       (ido-read-buffer (format "%d matches:" result-length))))
	   ))))


(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2))


;  C-3 C-d kopierer fx de næste tre linjer. Dvs C-# giver prefix
(defun avi-kill-line-save (&optional arg)
  "Copy to the kill ring from point to the end of the current line.
    With a prefix argument, copy that many lines from point. Negative
    arguments copy lines backward. With zero argument, copies the
    text before point to the beginning of the current line."
  (interactive "p")
  (save-excursion
    (copy-region-as-kill
     (point)
     (progn (if arg (forward-visible-line arg)
	      (end-of-visible-line))
	    (point)))))


;; Complement to next-error
(defun previous-error (n)
  "Visit previous compilation error message and corresponding source code."
  (interactive "p")
  (next-error (- n)))

;; Rotate window
 (defun rotate-windows ()
   "Rotate your windows" (interactive) (cond ((not (> (count-windows) 1)) (message "You can't rotate a single window!"))
(t
 (setq i 1)
 (setq numWindows (count-windows))
 (while  (< i numWindows)
   (let* (
          (w1 (elt (window-list) i))
          (w2 (elt (window-list) (+ (% i numWindows) 1)))
          (b1 (window-buffer w1))
          (b2 (window-buffer w2))
          (s1 (window-start w1))
          (s2 (window-start w2))
          )
     (set-window-buffer w1  b2)
     (set-window-buffer w2 b1)
     (set-window-start w1 s2)
     (set-window-start w2 s1)
     (setq i (1+ i)))))))

;; debugging
(defun humble-gud ()
  "gdb if not already running, otherwise bring to front"
  (interactive)
  (require 'gud)
  (if (and (boundp 'gud-comint-buffer)  ;find running gdb process
           gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer))
      (if (fboundp 'gdb-restore-windows)
	  (gdb-restore-windows)
        (pop-to-buffer gud-comint-buffer))
    (call-interactively
     (or (cdr (assq major-mode preferred-debugger-alist))
         'gdb))))


;; start/stop recording macro with same key
;; http://stackoverflow.com/questions/6003666/one-key-macros-in-emacs
(defun toggle-kbd-macro-recording-on ()
  "One-key keyboard macros: turn recording on."
  (interactive)
  (define-key
    global-map
    (this-command-keys)
    'toggle-kbd-macro-recording-off)
  (start-kbd-macro nil))

(defun toggle-kbd-macro-recording-off ()
  "One-key keyboard macros: turn recording off."
  (interactive)
  (define-key
    global-map
    (this-command-keys)
    'toggle-kbd-macro-recording-on)
  (end-kbd-macro))

;; Very useful and cool sort of code-folding.
;http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/#comment-3458
(defun jao-selective-display ()
  "Activate selective display based on the column at point"
  (interactive)
  (set-selective-display
   (if selective-display
       nil
     (+ 1 (current-column)))))


;; Evaluate expression, delete the expression and insert the result.
;; http://emacs.wordpress.com/2007/01/17/eval-and-replace-anywhere/
(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;; Open current file as root
; http://splash-of-open-sauce.blogspot.com/2010/09/reopen-buffer-as-root-prompting-for_18.html
(defun toggle-sudo-edit (&optional buf)
  "Toggle BUF between editing as root and normal user.

Default BUF is current buffer. The positions of point and mark
are preserved through the toggle."
  (interactive)
  (let* ((buf (or buf (current-buffer)))
         (old-point (with-current-buffer buf (point)))
         (old-mark (with-current-buffer buf (mark)))
         (filename (buffer-file-name buf))
         (root-string "/sudo:root@localhost:")
         (currently-root (string-match-p (concat "^" root-string) filename))
         (new-filename (if currently-root
                           (substring filename (length root-string))
                         (concat root-string filename))))
    (find-alternate-file new-filename)
    (goto-char old-point)
    (set-mark old-mark)))


;; Open tag in another buffer.
;; Is also bound to 'C-x 4 .' but by making this function, it's possibel to bind it to another key
(defun my-goto-tag-other-window ()
  (interactive)
  (if (= 0 (current-column))
      (find-tag-other-window "" t)
    (find-tag-other-window (find-tag-default) )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add functionality to occur. 
;; search all open buffers that share the same mode as the active buffer.
;; http://www.masteringemacs.org/articles/2011/07/20/searching-buffers-occur-mode/
(eval-when-compile
  (require 'cl))
 
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))

;; This is the function you should bimd a key to 
(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))


(defun isearch-save-and-exit ()
  "Exit search normally. and save the `search-string' on kill-ring."
  (interactive)
  (isearch-done)
  (isearch-clean-overlays)
  (kill-new isearch-string))

;; Functions for open new lines. From:
;; http://www.emacswiki.org/emacs/OpenNextLine
;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

;; Move file, eg rename file and delete old
;; Udkommenteret fordi denne funktionalitet findes i buffer-extension.el, der kan findes på emacswiki
;; http://stackoverflow.com/questions/384284/can-i-rename-an-open-file-in-emacs
;; ;; Originally from stevey, adapted to support moving to a new directory.
;; (defun rename-file-and-buffer (new-name)
;;   "Renames both current buffer and file it's visiting to NEW-NAME."
;;   (interactive
;;    (progn
;;      (if (not (buffer-file-name))
;;          (error "Buffer '%s' is not visiting a file!" (buffer-name)))
;;      (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
;;                                                      (buffer-file-name)))))))
;;   (if (equal new-name "")
;;       (error "Aborted rename"))
;;   (setq new-name (if (file-directory-p new-name)
;;                      (expand-file-name (file-name-nondirectory
;;                                         (buffer-file-name))
;;                                        new-name)
;;                    (expand-file-name new-name)))
;;   ;; If the file isn't saved yet, skip the file rename, but still update the
;;   ;; buffer name and visited file.
;;   (if (file-exists-p (buffer-file-name))
;;       (rename-file (buffer-file-name) new-name 1))
;;   (let ((was-modified (buffer-modified-p)))
;;     ;; This also renames the buffer, and works with uniquify
;;     (set-visited-file-name new-name)
;;     (if was-modified
;;         (save-buffer)
;;       ;; Clear buffer-modified flag caused by set-visited-file-name
;;       (set-buffer-modified-p nil))
;;   (message "Renamed to %s." new-name)))


;; Increment or decrement a number. From
;; http://www.emacswiki.org/emacs/IncrementNumber
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun my-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))
